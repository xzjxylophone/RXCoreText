//
//  RXCTFrameParserConfig.h
//  RXExample
//
//  Created by Rush.D.Xzj on 15/11/3.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
@interface RXCTFrameParserConfig : NSObject

@property (nonatomic, assign) CGFloat width;            // 宽度
@property (nonatomic, strong) UIFont *font;             // 字体
@property (nonatomic, assign) CGFloat lineSpace;        // 行距
@property (nonatomic, strong) UIColor *textColor;       // 文字颜色


// 次config 得到的Attributes 的 Dictionary
@property (nonatomic, readonly) NSMutableDictionary *attributes;


@end
