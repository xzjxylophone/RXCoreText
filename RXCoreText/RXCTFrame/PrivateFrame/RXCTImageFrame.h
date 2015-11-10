//
//  RXCTImageFrame.h
//  RXExample
//
//  Created by Rush.D.Xzj on 15/11/3.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RXCTFrame.h"
#import <UIKit/UIKit.h>


/*
 描述图片Frame类
 */
@interface RXCTImageFrame : RXCTFrame





// 此坐标是 CoreText 的坐标系，而不是UIKit的坐标系
@property (nonatomic, assign) CGRect imagePosition;


@end
