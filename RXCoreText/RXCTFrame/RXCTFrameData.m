//
//  RXCTFrameData.m
//  RXExample
//
//  Created by Rush.D.Xzj on 15/11/3.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import "RXCTFrameData.h"
#import "RXCTImageFrame.h"
#import "RXCTLinkFrame.h"
#import "RXCTImageData.h"

#import "RXCTFrameParserConfig.h"

@interface RXCTFrameData ()

@property (nonatomic, strong) NSArray *m_imageAry;
@property (nonatomic, strong) NSArray *m_linkAry;

@property (nonatomic, strong) NSArray *m_textAry;

@end


@implementation RXCTFrameData

#pragma mark - ReadOnly Property
- (NSArray *)imageAry
{
    return self.m_imageAry;
}
- (NSArray *)linkAry
{
    return self.m_linkAry;
}
- (NSArray *)textAry
{
    return self.m_textAry;
}

#pragma mark - Property
- (void)setFrameRef:(CTFrameRef)frameRef
{
    if (_frameRef != frameRef) {
        if (_frameRef != nil) {
            CFRelease(_frameRef);
        }
        CFRetain(frameRef);
        _frameRef = frameRef;
    }
}


- (void)setAttributedArray:(NSArray *)attributedArray
{
    _attributedArray = attributedArray;
    NSMutableArray *imageAry = [NSMutableArray array];
    NSMutableArray *linkAry = [NSMutableArray array];
    NSMutableArray *textAry = [NSMutableArray array];
    for (RXCTFrame *rxctFrame in self.attributedArray) {
        if ([rxctFrame isKindOfClass:[RXCTImageFrame class]]) {
            [imageAry addObject:rxctFrame];
        } else if ([rxctFrame isKindOfClass:[RXCTLinkFrame class]]) {
            [linkAry addObject:rxctFrame];
        } else {
            [textAry addObject:rxctFrame];
        }
    }
    self.m_imageAry = imageAry;
    self.m_linkAry = linkAry;
    self.m_textAry = textAry;
    [self fillImagePosition];
}


#pragma mark - Private
// 调整image的位置
- (void)fillImagePosition
{
    if (self.imageAry.count == 0) {
        return;
    }
    NSArray *lines = (NSArray *)CTFrameGetLines(self.frameRef);
    NSUInteger lineCount = lines.count;
    
    CGPoint lineOrigins[lineCount];
    CTFrameGetLineOrigins(self.frameRef, CFRangeMake(0, 0), lineOrigins);
    int imgIndex = 0;
    RXCTImageFrame *imageFrame = self.imageAry[0];
    for (int i = 0; i < lineCount; i++) {
        if (imageFrame == nil) {
            break;
        }
        CTLineRef lineRef = (__bridge CTLineRef)lines[i];
        NSArray *runObjAry = (NSArray *)CTLineGetGlyphRuns(lineRef);
        for (id runObj in runObjAry) {
            CTRunRef runRef = (__bridge CTRunRef)runObj;
            NSDictionary *runAttributes = (NSDictionary *)CTRunGetAttributes(runRef);
            CTRunDelegateRef delegateRef = (__bridge CTRunDelegateRef)[runAttributes valueForKey:(id)kCTRunDelegateAttributeName];
            if (delegateRef == nil) {
                continue;
            }
            CGRect runBounds;
            CGFloat ascent;
            CGFloat descent;
            runBounds.size.width = CTRunGetTypographicBounds(runRef, CFRangeMake(0, 0), &ascent, &descent, NULL);
            runBounds.size.height = ascent + descent;
            CGFloat xOffset = CTLineGetOffsetForStringIndex(lineRef, CTRunGetStringRange(runRef).location, NULL);
            runBounds.origin.x = lineOrigins[i].x + xOffset;
            runBounds.origin.y = lineOrigins[i].y;
            runBounds.origin.y -= descent;
            CGPathRef pathRef = CTFrameGetPath(self.frameRef);
            CGRect colRect = CGPathGetBoundingBox(pathRef);
            CGRect delegateBounds = CGRectOffset(runBounds, colRect.origin.x, colRect.origin.y);
            imageFrame.imagePosition = delegateBounds;
            imgIndex++;
            if (imgIndex == self.imageAry.count) {
                imageFrame = nil;
            } else {
                imageFrame = self.imageAry[imgIndex];
            }
        }
    }
}




#pragma mark - Constructor And Destructor
- (void)dealloc
{
    if (_frameRef != nil) {
        CFRelease(_frameRef);
        _frameRef = nil;
    }
}

#pragma mark - Class Method

+ (RXCTFrameData *)parseWithArray:(NSArray *)ary config:(RXCTFrameParserConfig *)config
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    NSMutableArray *array = [NSMutableArray array];
    for (RXCTData *ctData in ary) {
        NSUInteger startPos = attributedString.length;
        RXCTFrame *rxctFrame = nil;
        NSAttributedString *ctDataAttributedString = [ctData attributedStringWithConfig:config outRXCTFrame:&rxctFrame];
        [attributedString appendAttributedString:ctDataAttributedString];
        NSUInteger length = attributedString.length - startPos;
        NSRange range = NSMakeRange(startPos, length);
        rxctFrame.range = range;
        [array addObject:rxctFrame];
    }
    // 创建 CTFramesetterRef 实例
    CTFramesetterRef framesetterRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);
    // 获得要绘制的区域的高度
    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX); // 限制的区域
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetterRef, CFRangeMake(0, 0), nil, restrictSize, nil);
    CGFloat textHeight = coreTextSize.height;
    // 创建 CTFrameRef 实例
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathAddRect(pathRef, NULL, CGRectMake(0, 0, config.width, textHeight));
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetterRef, CFRangeMake(0, 0), pathRef, NULL);
    CFRelease(pathRef);
    // 将生成好的 CTFrameRef 实例和计算好的绘制高度保存到 CoreTextData 实例中,最后返回CoreTextData实例
    RXCTFrameData *ctFrameData = [[RXCTFrameData alloc] init];
    ctFrameData.frameRef = frameRef;
    ctFrameData.height = textHeight;
    ctFrameData.content = attributedString;
    ctFrameData.attributedArray = array;
    ctFrameData.lineSpace = config.lineSpace;
    CFRelease(frameRef);
    CFRelease(framesetterRef);
    return ctFrameData;
}
@end
