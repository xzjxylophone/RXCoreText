//
//  RVRichTextView.m
//  RXCTExample
//
//  Created by xuzhijun on 2020/4/1.
//  Copyright © 2020 Rush.D.Xzj. All rights reserved.
//

#import "RVRichTextView.h"
#import <CoreText/CoreText.h>

@implementation RVRichTextView
- (NSDictionary *)_foramtSDKStringWithFileName:(NSString *)fileName {
    NSURL *testJsonURL = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    // 读取文件内容
    NSData *testData = [NSData dataWithContentsOfURL:testJsonURL];
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:testData options:NSJSONReadingMutableContainers error:nil];
    return result;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        NSDictionary *dict = [self _foramtSDKStringWithFileName:@"rv_core_text"];
        NSLog(@"dict:%@", dict);
    }
    return self;
}


#pragma mark - Override
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self vvv1];
    
    
    
    
    
}

// https://www.cnblogs.com/purple-sweet-pottoes/p/5109413.html
- (void)vvv1 {
    //获取当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //翻转坐标系步骤
    //设置当前文本矩阵
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    //文本沿y轴移动
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    //文本翻转成为CoreText坐标系
    CGContextScaleCTM(context, 1, -1);
    
    
    //1.创建绘制区域,显示的区域可以用CGMUtablePathRef生成任意的形状
   CGMutablePathRef path = CGPathCreateMutable();
   CGPathAddRect(path, NULL, CGRectMake(20, 50, self.bounds.size.width - 40, self.bounds.size.height - 100));
   //2.创建需要绘制的文字
   NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"\tWhen I will learn CoreText, i think it will hard for me.But it is easy.\n\tIn fact,if you bengin learn, you can know that every thing is easy when you start.you just need some knowlages"];
   //3.根据AttString生成CTFramesetterRef
   CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
   CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, [attString length]), path, NULL);
    
    CTFrameDraw(frame, context);
}

@end
