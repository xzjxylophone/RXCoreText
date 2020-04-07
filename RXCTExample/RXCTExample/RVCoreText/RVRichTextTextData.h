//
//  RVRichTextTextData.h
//  RXCTExample
//
//  Created by xuzhijun on 2020/4/2.
//  Copyright © 2020 Rush.D.Xzj. All rights reserved.
//

#import "RVRichTextBaseData.h"

NS_ASSUME_NONNULL_BEGIN

@interface RVRichTextTextData : RVRichTextBaseData

@property (nonatomic, assign) RVRichTextType type;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, assign) NSInteger font;
@property (nonatomic, assign) NSString *color;
@property (nonatomic, assign) NSInteger lineSpace;   // 行间距
@property (nonatomic, assign) NSInteger numberSpace; // 字间距
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger top;
@property (nonatomic, assign) NSInteger left;
@property (nonatomic, assign) NSInteger right;

@end

NS_ASSUME_NONNULL_END
