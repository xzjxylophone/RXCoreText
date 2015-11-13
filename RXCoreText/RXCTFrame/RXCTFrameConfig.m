//
//  RXCTFrameConfig.m
//  RXExample
//
//  Created by Rush.D.Xzj on 15/11/3.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import "RXCTFrameConfig.h"
@implementation RXCTFrameConfig
- (id)init
{
    if (self = [super init]) {
        self.width = 200;
        self.font = [UIFont systemFontOfSize:16];
        self.lineSpace = 8.0f;
        self.textColor = [UIColor redColor];
    }
    return self;
}


- (NSMutableDictionary *)attributes
{
    CGFloat fontSize = self.font.pointSize;
    NSString *fontName = self.font.fontName;
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)fontName, fontSize, NULL);
    CGFloat lineSpace = self.lineSpace;
    const CFIndex kNumbberOfSettings = 3;
    CTParagraphStyleSetting settings[kNumbberOfSettings] = {
        {kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpace},
        {kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(CGFloat), &lineSpace},
        {kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(CGFloat), &lineSpace},
    };
    
    CTParagraphStyleRef paragraphStyleRef = CTParagraphStyleCreate(settings, kNumbberOfSettings);
    
    UIColor *textColor = self.textColor;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
    dic[(id)kCTFontAttributeName] = (__bridge id)fontRef;
    dic[(id)kCTParagraphStyleAttributeName] = (__bridge id)paragraphStyleRef;
    
    CFRelease(paragraphStyleRef);
    CFRelease(fontRef);
    return dic;
    
}

@end
