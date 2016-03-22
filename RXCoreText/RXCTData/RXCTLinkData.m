//
//  RXCTLinkData.m
//  RXExample
//
//  Created by Rush.D.Xzj on 15/11/3.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import "RXCTLinkData.h"
#import "RXCTFrameConfig.h"
#import "RXCTLinkFrame.h"
@implementation RXCTLinkData



- (id)init
{
    if (self = [super init]) {
        self.haveUnderLine = YES;
    }
    return self;
}

#pragma mark - Override
- (NSAttributedString *)attributedStringWithConfig:(RXCTFrameConfig *)config outRXCTFrame:(RXCTFrame **)outRXCTFrame
{
    NSMutableDictionary *attributes = config.attributes;
    UIColor *textColor = self.textColor;
    if (textColor != nil) {
        attributes[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
    }
    if (self.font != nil) {
        CGFloat fontSize = self.font.pointSize;
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)self.font.fontName, fontSize, NULL);
        attributes[(id)kCTFontAttributeName] = (__bridge id)fontRef;
        CFRelease(fontRef);
    }
    if (self.haveUnderLine) {
        // 添加一条线
        attributes[(id)kCTUnderlineStyleAttributeName] = [NSNumber numberWithInt:kCTUnderlineStyleSingle];
    }
    NSString *content = self.content;
    NSAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content attributes:attributes];
    RXCTLinkFrame *rxctFrame = [[RXCTLinkFrame alloc] init];
    rxctFrame.rxctData = self;
    *outRXCTFrame = rxctFrame;
    return attributedString;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"class=%@, link text: content=%@", NSStringFromClass([self class]), self.content];
}
- (BOOL)isValid
{
    return self.content.length > 0;
}



@end
