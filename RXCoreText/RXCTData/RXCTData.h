//
//  RXCTData.h
//  RXExample
//
//  Created by Rush.D.Xzj on 15/11/3.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@class RXCTFrame;
@class RXCTFrameConfig;


/*
 输入数据的基类
 */
@interface RXCTData : NSObject



/*
 此函数的作用是
 */
- (NSAttributedString *)attributedStringWithConfig:(RXCTFrameConfig *)config outRXCTFrame:(RXCTFrame **)outRXCTFrame;


@end
