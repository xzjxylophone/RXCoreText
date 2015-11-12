//
//  RXCTImageData.h
//  RXExample
//
//  Created by Rush.D.Xzj on 15/11/3.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import "RXCTData.h"

/*
 图片类
 */

@interface RXCTImageData : RXCTData


@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;


// 优先判断是否是本地的
@property (nonatomic, copy) NSString *imageName;

// 这两个属性是表示是网络
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, strong) UIImage *imagePlacholder;



@end
