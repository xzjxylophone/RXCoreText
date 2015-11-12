//
//  RXCTView.m
//  RXExample
//
//  Created by Rush.D.Xzj on 15/11/3.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import "RXCTView.h"
#import "RXCTImageData.h"
#import "RXCTLinkData.h"
#import "RXCTImageFrame.h"
#import "RXCTLinkFrame.h"
#import "UIImageView+WebCache.h"

@interface RXCTView ()

@property (nonatomic, strong) NSArray *ivAry;

@end


@implementation RXCTView


#pragma mark - Proverty
- (void)setRxctFrameData:(RXCTFrameData *)rxctFrameData
{
    // 当数据源变化的时候
    // 内部的iv也是需要变化的
    _rxctFrameData = rxctFrameData;
    self.ivAry = nil;
}


#pragma mark - UIGestureRecognizerDelegate


#pragma mark - Action
- (void)tgrAction:(id)sender
{
    UITapGestureRecognizer *tgr = sender;
    CGPoint point = [tgr locationInView:self];
    BOOL result = [self tapWithPoint:point];
    if (!result) {
        CGFloat offset = 0;
        switch (self.e_RXCT_TapType) {
            case kE_RXCT_TapType_None:
                return;
            case kE_RXCT_TapType_Next:
                offset = self.rxctFrameData.lineSpace;
                break;
            case kE_RXCT_TapType_Pre:
                offset = - self.rxctFrameData.lineSpace;
                break;
            default:
                break;
        }
        point.y += offset;
        [self tapWithPoint:point];
    }
}

#pragma mark - Private

- (void)initialize
{
    // 添加一个点击手势
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tgrAction:)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tgr];
    
    self.e_RXCT_TapType = kE_RXCT_TapType_None;
}


- (BOOL)tapWithPoint:(CGPoint)point
{
    for (RXCTImageFrame *imageFrame in self.rxctFrameData.imageAry) {
        // 翻转坐标系, 因为 imageData 中的坐标是CoreText的坐标系
        CGRect imageRect = imageFrame.imagePosition;
        CGPoint imagePosition = imageRect.origin;
        imagePosition.y = self.bounds.size.height - imageRect.origin.y - imageRect.size.height;
        CGRect rect = CGRectMake(imagePosition.x, imagePosition.y, imageRect.size.width, imageRect.size.height);
        if (CGRectContainsPoint(rect, point)) {
            [self safeDelegate_tapInRXCTView:self rxctData:imageFrame.rxctData];
            return YES;
        }
    }
    CTFrameRef frameRef = self.rxctFrameData.frameRef;
    CFArrayRef lines = CTFrameGetLines(frameRef);
    if (lines == NULL) {
        return NO;
    }
    CFIndex count = CFArrayGetCount(lines);
    // 获得每一行的origin坐标
    CGPoint origins[count];
    CTFrameGetLineOrigins(frameRef, CFRangeMake(0, 0), origins);
    // 翻转坐标系
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, self.bounds.size.height);
    transform = CGAffineTransformScale(transform, 1.0f, -1.0f);
    CFIndex idx = -1;
    for (int i = 0; i < count; i++) {
        CGPoint linePoint = origins[i];
        CTLineRef lineRef = CFArrayGetValueAtIndex(lines, i);
        // 获取每一行的CGRect信息
        CGFloat ascent = 0.0f;
        CGFloat descent = 0.0f;
        CGFloat leading = 0.0f;
        CGFloat width = (CGFloat)CTLineGetTypographicBounds(lineRef, &ascent, &descent, &leading);
        CGFloat height = ascent + descent;
        CGRect flippedRect = CGRectMake(linePoint.x, linePoint.y, width, height);
        CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
        if (CGRectContainsPoint(rect, point)) {
            // 将点击的坐标转换成相对于当前行的坐标
            CGPoint relativePoint = CGPointMake(point.x - CGRectGetMinX(rect), point.y - CGRectGetMinY(rect));
            // 获得当前点击坐标对应的字符串偏移
            idx = CTLineGetStringIndexForPosition(lineRef, relativePoint);
        }
    }
    
    if (idx == -1) {
        return NO;
    }
    
    NSLog(@"idx:%ld", idx);
    RXCTFrame *foundFrame = nil;
    for (RXCTLinkFrame *linkFrame in self.rxctFrameData.linkAry) {
        if (NSLocationInRange(idx, linkFrame.range)) {
            foundFrame = linkFrame;
            break;
        }
    }
    
    
    
    RXCTFrame *rxctFrame = nil;
    for (RXCTFrame *tmp in self.rxctFrameData.attributedArray) {
        if (NSLocationInRange(idx, tmp.range)) {
            rxctFrame = tmp;
            break;
        }
    }

    if (rxctFrame != nil) {
        [self safeDelegate_tapInRXCTView:self rxctData:rxctFrame.rxctData];
        return YES;
    } else {
        return NO;
    }
}

- (void)updateWithImage
{
    NSMutableArray *ary = [NSMutableArray array];
    for (RXCTImageFrame *imageFrame in self.rxctFrameData.imageAry) {
        RXCTImageData *imageData = (RXCTImageData *)imageFrame.rxctData;
        if (imageData.imageUrl.length != 0) {
            [ary addObject:imageFrame];
        }
    }
    if (self.ivAry.count == ary.count) {
        return;
    }
    for (UIView *view in self.ivAry) {
        [view removeFromSuperview];
    }
    NSMutableArray *ivAry = [NSMutableArray array];
    for (RXCTImageFrame *imageFrame in ary) {
        RXCTImageData *rxctImageData = (RXCTImageData *)imageFrame.rxctData;
        CGRect ivFrame = imageFrame.imagePosition;
        ivFrame.origin.y = self.bounds.size.height - ivFrame.origin.y - ivFrame.size.height;
        UIImageView *iv = [[UIImageView alloc] initWithFrame:ivFrame];
        NSURL *url = [NSURL URLWithString:rxctImageData.imageUrl];
        [iv sd_setImageWithURL:url placeholderImage:rxctImageData.imagePlacholder];
        [ivAry addObject:iv];
        [self addSubview:iv];
    }
    self.ivAry = ivAry;
    
    
    
}


#pragma mark - Safe Delegate
- (void)safeDelegate_tapInRXCTView:(RXCTView *)rxctView rxctData:(RXCTData *)rxctData
{
    if ([self.delegate respondsToSelector:@selector(tapInRXCTView:rxctData:)]) {
        [self.delegate tapInRXCTView:rxctView rxctData:rxctData];
    }
}



#pragma mark - Override
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 将坐标系上下翻转。对于底层的绘制引擎来说，屏幕的左下角是（0, 0）坐标。而对于上层的 UIKit 来说，左上角是 (0, 0) 坐标。所以我们为了之后的坐标系描述按 UIKit 来做，所以先在这里做一个坐标系的上下翻转操作。翻转之后，底层和上层的 (0, 0) 坐标就是重合的了。
    // 这个应该是 以左下角为(0,0)
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    if (self.rxctFrameData) {
        CTFrameDraw(self.rxctFrameData.frameRef, context);
    }
    
    for (RXCTImageFrame *imageFrame in self.rxctFrameData.imageAry) {
        RXCTImageData *imageData = (RXCTImageData *)imageFrame.rxctData;
        UIImage *image = [UIImage imageNamed:imageData.imageName];
        NSLog(@"imagePosition:%@", NSStringFromCGRect(imageFrame.imagePosition));
        if (image) {
            CGContextDrawImage(context, imageFrame.imagePosition, image.CGImage);
        }
    }
    
    [self updateWithImage];
    
}





#pragma mark - Constructor And Destructor
- (id)init
{
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

@end
