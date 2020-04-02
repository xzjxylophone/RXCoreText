//
//  RVRichTextBaseData.h
//  RXCTExample
//
//  Created by xuzhijun on 2020/4/2.
//  Copyright © 2020 Rush.D.Xzj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RVRichTextType) {
    RVRichTextTypeText      =           1,
    RVRichTextTypeImage     =           2,
    RVRichTextTypeLinkText  =           3,
    RVRichTextTypeRichText  =           4,
};

@interface RVRichTextBaseData : NSObject

@end

NS_ASSUME_NONNULL_END
