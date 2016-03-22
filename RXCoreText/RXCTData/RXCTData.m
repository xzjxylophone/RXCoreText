//
//  RXCTData.m
//  RXExample
//
//  Created by Rush.D.Xzj on 15/11/3.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import "RXCTData.h"
#import "RXCTFrameConfig.h"
@implementation RXCTData


- (NSAttributedString *)attributedStringWithConfig:(RXCTFrameConfig *)config outRXCTFrame:(RXCTFrame **)outRXCTFrame
{
    // Need to override
    // Do Nothing
    NSLog(@"如果到这里就表示有错误了!!!");
    return nil;
}


- (BOOL)isValid
{
    // Need to override
    // Do Nothing
    NSLog(@"如果到这里就表示有错误了!!!");
    return NO;
}
@end
