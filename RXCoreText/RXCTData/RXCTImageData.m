//
//  RXCTImageData.m
//  RXExample
//
//  Created by Rush.D.Xzj on 15/11/3.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import "RXCTImageData.h"
#import "RXCTFrameParserConfig.h"
#import "RXCTImageFrame.h"
@implementation RXCTImageData


#pragma mark - Static

static CGFloat ascentCallback(void *ref)
{
    RXCTImageData *imageData = (__bridge RXCTImageData *)ref;
    return imageData.height;
}
static CGFloat descentCallback(void *ref)
{
    return 0;
}
static CGFloat widthCallback(void *ref)
{
    RXCTImageData *imageData = (__bridge RXCTImageData *)ref;
    return imageData.width;
}

static void deallocCallback(void *ref)
{
    // Do Nothing
}

#pragma mark - Override
- (NSAttributedString *)attributedStringWithConfig:(RXCTFrameParserConfig *)config outRXCTFrame:(RXCTFrame **)outRXCTFrame
{

    CTRunDelegateCallbacks callbacks;
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
    callbacks.version = kCTRunDelegateVersion1;
    callbacks.getAscent = ascentCallback;
    callbacks.getDescent = descentCallback;
    callbacks.getWidth = widthCallback;
    callbacks.dealloc = deallocCallback;
    
    CTRunDelegateRef delegateRef = CTRunDelegateCreate(&callbacks, (__bridge void *)(self));
    // 使用 0xFFFC 作为空白的占位符
    unichar objectReplacementChar = 0xFFFC;
    NSString *content = [NSString stringWithCharacters:&objectReplacementChar length:1];
    NSDictionary *attributes = config.attributes;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content attributes:attributes];
    
    // 给这个attributedString设置属性
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attributedString, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegateRef);
    CFRelease(delegateRef);
    
    RXCTImageFrame *rxctFrame = [[RXCTImageFrame alloc] init];
    rxctFrame.rxctData = self;
    *outRXCTFrame = rxctFrame;
    
    return attributedString;
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"class=%@, image: width=%.2f height=%.2f imageName=%@ imageUrl=%@", NSStringFromClass([self class]), self.width, self.height, self.imageName, self.imageUrl];
}


@end
