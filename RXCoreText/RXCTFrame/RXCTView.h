//
//  RXCTView.h
//  RXExample
//
//  Created by Rush.D.Xzj on 15/11/3.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import "RXCTFrameData.h"
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@class RXCTData;
@class RXCTView;


typedef enum E_RXCT_TapType {
    kE_RXCT_TapType_None          =       0,  // 当点击文本的行间距的时候,不做任何处理
    kE_RXCT_TapType_Pre           =       1,  // 当点击文本的行间距的时候,默认的是向上一行点击
    kE_RXCT_TapType_Next          =       2,  // 当点击文本的行间距的时候,默认的是向下一行点击
}E_RXCT_TapType;


@protocol RXCTViewDelegate <NSObject>


@optional
- (void)tapInRXCTView:(RXCTView *)rxctView rxctData:(RXCTData *)rxctData;



@end



@interface RXCTView : UIView

@property (nonatomic, strong) RXCTFrameData *rxctFrameData;

@property (nonatomic, weak) id<RXCTViewDelegate> delegate;

// Default is kE_RXCT_TapType_None
@property (nonatomic, assign) E_RXCT_TapType e_RXCT_TapType;


@end
