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
@property (nonatomic, assign) NSInteger lineSpace;
@property (nonatomic, assign) NSInteger height;

@end

NS_ASSUME_NONNULL_END
