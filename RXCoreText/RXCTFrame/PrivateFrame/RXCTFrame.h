//
//  RXCTFrame.h
//  RXExample
//
//  Created by Rush.D.Xzj on 15/11/3.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RXCTData;


/*
 描述数据源Frame信息的基类
 */


@interface RXCTFrame : NSObject

@property (nonatomic, strong) RXCTData *data;  // 对应的数据


@property (nonatomic, assign) NSRange range; // 内容所占的区域


@end
