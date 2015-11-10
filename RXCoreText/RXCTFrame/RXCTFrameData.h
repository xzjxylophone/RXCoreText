//
//  RXCTFrameData.h
//  RXExample
//
//  Created by Rush.D.Xzj on 15/11/3.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@class RXCTFrameParserConfig;

@interface RXCTFrameData : NSObject


// view drawRect 需要用到的
@property (nonatomic, assign) CTFrameRef frameRef;
// 整个attributed
@property (strong, nonatomic) NSAttributedString *content;
// 整个所需要的高度
@property (nonatomic, assign) CGFloat height;
// 全部数据的Array
@property (nonatomic, strong) NSArray *attributedArray;


// 具体的Array
@property (nonatomic, readonly) NSArray *imageAry;
@property (nonatomic, readonly) NSArray *linkAry;
@property (nonatomic, readonly) NSArray *textAry;


// 解析数据
+ (RXCTFrameData *)parseWithArray:(NSArray *)ary config:(RXCTFrameParserConfig *)config;




@end
