//
//  RVRichTextView.m
//  RXCTExample
//
//  Created by xuzhijun on 2020/4/1.
//  Copyright © 2020 Rush.D.Xzj. All rights reserved.
//

#import "RVRichTextView.h"
#import <CoreText/CoreText.h>
#import "Masonry.h"

@interface RVRichTextView ()

@end

@implementation RVRichTextView
#pragma mark - init And dealloc
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        NSDictionary *dict = [self _foramtSDKStringWithFileName:@"rv_core_text"];
        NSLog(@"dict:%@", dict);
        
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 1.0f;
    }
    return self;
}

- (NSDictionary *)_foramtSDKStringWithFileName:(NSString *)fileName {
    NSURL *testJsonURL = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    // 读取文件内容
    NSData *testData = [NSData dataWithContentsOfURL:testJsonURL];
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:testData options:NSJSONReadingMutableContainers error:nil];
    return result;
}


#pragma mark - Override
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    //获取当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //翻转坐标系步骤
    //设置当前文本矩阵
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    //文本沿y轴移动
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    //文本翻转成为CoreText坐标系
    CGContextScaleCTM(context, 1, -1);
    
    
    CTFrameRef frame = NULL;
    frame = [self vvv1];
//    frame = [self vvv2];
    
    CTFrameDraw(frame, context);
    
    
}


- (void)addViewIfNecessaryWithRect:(CGRect)rect tag:(NSInteger)tag {
    UIView *tmp = [self viewWithTag:tag];
    if (tmp == nil) {
        tmp = [[UIView alloc] initWithFrame:rect];
        tmp.layer.borderColor = [UIColor blackColor].CGColor;
        tmp.layer.masksToBounds = YES;
        tmp.layer.borderWidth = 1.0;
        tmp.tag = tag;
        tmp.backgroundColor = [UIColor greenColor];
        [self addSubview:tmp];
    }
}


// https://www.cnblogs.com/purple-sweet-pottoes/p/5109413.html
- (CTFrameRef)vvv1 {
    
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, 40);
    [self addViewIfNecessaryWithRect:rect tag:11111];
    
    //1.创建绘制区域,显示的区域可以用CGMUtablePathRef生成任意的形状
   CGMutablePathRef path = CGPathCreateMutable();
   CGPathAddRect(path, NULL, rect);
   //2.创建需要绘制的文字
   NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"\tWhen I will learn CoreText, i think it will hard for me.But it is easy.\n\tIn fact,if you bengin learn, you can know that every thing is easy when you start.you just need some knowledge"];
   //3.根据AttString生成CTFramesetterRef
   CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
   CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, [attString length]), path, NULL);
    return frame;
}

// https://www.jianshu.com/p/ed6cd560e38e
- (CTFrameRef)vvv2 {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(20, 50, self.bounds.size.width - 40, self.bounds.size.height - 100));
    // 图文混排
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    // 1 - 你好
    NSAttributedString *first = [[NSAttributedString alloc] initWithString:@"你好"];
    [attributedText appendAttributedString:first];

    // 2 - 图片
    // 带有图片的附件对象
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"coretext-image-1"];
    attachment.bounds = CGRectMake(0, 0, 20, 20);
    // 将附件对象包装成一个属性文字
    NSAttributedString *second = [NSAttributedString attributedStringWithAttachment:attachment];
    [attributedText appendAttributedString:second];

    // 3 - 哈哈哈
    NSAttributedString *third = [[NSAttributedString alloc] initWithString:@"哈哈哈"];
    [attributedText appendAttributedString:third];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedText);
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, [attributedText length]), path, NULL);
     return frame;
}



#pragma mark - UIGetter


@end
