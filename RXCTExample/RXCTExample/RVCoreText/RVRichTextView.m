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
#import "RVRichTextTextData.h"
#import "MJExtension.h"
#import "UIColor+RXUtility.h"


@interface RVRichTextView ()

@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation RVRichTextView
#pragma mark - init And dealloc
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        NSDictionary *dict = [self _foramtSDKStringWithFileName:@"rv_core_text"];
        NSArray *dataDictArray = dict[@"data"];
        NSMutableArray *dataArray = [NSMutableArray new];
        if (dataDictArray.count > 0) {
            RVRichTextTextData *textData  = [RVRichTextTextData mj_objectWithKeyValues:dataDictArray.firstObject];
            [dataArray addObject:textData];
        }
        self.dataArray = dataArray;
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
    
    if (self.dataArray.count == 0) {
        return;
    }
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
    
    frame = [self vvv_custom];
//    frame = [self vvv1];
//    frame = [self vvv1_1];
    
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
        tmp.backgroundColor = [UIColor clearColor];
        [self addSubview:tmp];
    }
}



- (CTFrameRef)vvv_custom {
    
    

    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    /*for (NSInteger i = 0; i < self.dataArray.count; i++)*/
    {
        
        
        
        RVRichTextTextData *textData = self.dataArray.firstObject;
        
        
        [self addViewIfNecessaryWithRect:CGRectMake(textData.left, textData.top, width - textData.left - textData.right, textData.height) tag:11111];
        
        CGRect rect = CGRectMake(textData.left, height - textData.height - textData.top, width - textData.left - textData.right, textData.height);
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, rect);
        
        NSInteger strLength = textData.value.length;
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:textData.value];
        
        UIColor *textColor = [UIColor rx_colorWithString:[NSString stringWithFormat:@"#%@", textData.color]];
//        textColor = [UIColor redColor];
        NSRange range = NSMakeRange(0 , strLength);
        //设置文本内容的属性
        //1设置部分文字颜色
        [attString addAttribute:(id)kCTForegroundColorAttributeName value:textColor range:range];
        //2设置部分文字字体
        CGFloat fontSize = textData.font;
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
        [attString addAttribute:(id)kCTFontAttributeName value:(__bridge id)fontRef range:range];
        
        //3设置斜体
//        CTFontRef italicFontRef = CTFontCreateWithName((CFStringRef)[UIFont italicSystemFontOfSize:20].fontName, 16, NULL);
//        [attString addAttribute:(id)kCTFontAttributeName value:(__bridge id)italicFontRef range:NSMakeRange(27, 9)];
//        // xzj_todo
//        [attString addAttribute:(id)kCTForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(27 , 9)];
        
        //4设置下划线
//        [attString addAttribute:(id)kCTUnderlineStyleAttributeName value:(id)[NSNumber numberWithInteger:kCTUnderlineStyleDouble] range:NSMakeRange(36, 10)];
//        //5设置下划线颜色
//        [attString addAttribute:(id)kCTUnderlineColorAttributeName value:(id)[UIColor greenColor].CGColor range:NSMakeRange(36, 10)];
//        // xzj_todo
//        [attString addAttribute:(id)kCTForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(36 , 10)];
        
        //6设置空心字
//        long number1 = 2;
//        CFNumberRef numRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number1);
//        [attString addAttribute:(id)kCTStrokeWidthAttributeName value:(__bridge id)numRef range:NSMakeRange(56, 10)];
//        // xzj_todo
//        [attString addAttribute:(id)kCTForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(56 , 10)];
        
        
        
        //7设置字体间距
        long number = textData.numberSpace;
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number);
        [attString addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:range];
        // xzj_todo
//        [attString addAttribute:(id)kCTForegroundColorAttributeName value:[UIColor purpleColor] range:range];
        
        //8设置行间距
        CGFloat lineSpacing = textData.lineSpace;
        const CFIndex kNumberOfSettings = 3;
        CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
            {kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpacing},
            {kCTParagraphStyleSpecifierMaximumLineHeight, sizeof(CGFloat), &lineSpacing},
            {kCTParagraphStyleSpecifierMinimumLineHeight, sizeof(CGFloat), &lineSpacing}
        };
        CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
        [attString addAttribute:(id)kCTParagraphStyleAttributeName value:(__bridge id)theParagraphRef range:NSMakeRange(0, [attString length])];
        
        CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
        CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, [attString length]), path, NULL);
        return frame;
    }
    
    return nil;
    
//    CGRect rect = CGRectMake(0, 0, self.frame.size.width, 300);
////     [self addViewIfNecessaryWithRect:rect tag:11111];
//
//     //1.创建绘制区域,显示的区域可以用CGMUtablePathRef生成任意的形状
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathAddRect(path, NULL, rect);
//
//    //设置绘制的文本内容
//     NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"\tWhen I will learn CoreText, i think it will hard for me.But it is easy.\n\tIn fact,if you bengin learn, you can know that every thing is easy when you start.you just need some knowledge"];
//    //设置文本内容的属性
//    //1设置部分文字颜色
//    [attString addAttribute:(id)kCTForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0 , 27)];
//    //2设置部分文字字体
//    CGFloat fontSize = 20;
//    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
//    [attString addAttribute:(id)kCTFontAttributeName value:(__bridge id)fontRef range:NSMakeRange(0, 27)];
//
//    //3设置斜体
//    CTFontRef italicFontRef = CTFontCreateWithName((CFStringRef)[UIFont italicSystemFontOfSize:20].fontName, 16, NULL);
//    [attString addAttribute:(id)kCTFontAttributeName value:(__bridge id)italicFontRef range:NSMakeRange(27, 9)];
//    // xzj_todo
//    [attString addAttribute:(id)kCTForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(27 , 9)];
//
//    //4设置下划线
//    [attString addAttribute:(id)kCTUnderlineStyleAttributeName value:(id)[NSNumber numberWithInteger:kCTUnderlineStyleDouble] range:NSMakeRange(36, 10)];
//    //5设置下划线颜色
//    [attString addAttribute:(id)kCTUnderlineColorAttributeName value:(id)[UIColor greenColor].CGColor range:NSMakeRange(36, 10)];
//    // xzj_todo
//    [attString addAttribute:(id)kCTForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(36 , 10)];
//
//    //6设置空心字
//    long number1 = 2;
//    CFNumberRef numRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number1);
//    [attString addAttribute:(id)kCTStrokeWidthAttributeName value:(__bridge id)numRef range:NSMakeRange(56, 10)];
//    // xzj_todo
//    [attString addAttribute:(id)kCTForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(56 , 10)];
//
//
//
//    //7设置字体间距
//    long number = 10;
//    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number);
//    [attString addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(40, 10)];
//    // xzj_todo
//    [attString addAttribute:(id)kCTForegroundColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(40 , 10)];
//
//    //8设置行间距
//    CGFloat lineSpacing = 10;
//    const CFIndex kNumberOfSettings = 3;
//    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
//        {kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpacing},
//        {kCTParagraphStyleSpecifierMaximumLineHeight, sizeof(CGFloat), &lineSpacing},
//        {kCTParagraphStyleSpecifierMinimumLineHeight, sizeof(CGFloat), &lineSpacing}
//    };
//    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
//    [attString addAttribute:(id)kCTParagraphStyleAttributeName value:(__bridge id)theParagraphRef range:NSMakeRange(0, [attString length])];
//
//    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
//    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, [attString length]), path, NULL);
//    return frame;
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

// 1和1_1的代码来源是同一个网址
- (CTFrameRef)vvv1_1 {

     CGRect rect = CGRectMake(0, 0, self.frame.size.width, 300);
//     [self addViewIfNecessaryWithRect:rect tag:11111];
     
     //1.创建绘制区域,显示的区域可以用CGMUtablePathRef生成任意的形状
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, rect);
    
    //设置绘制的文本内容
     NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"\tWhen I will learn CoreText, i think it will hard for me.But it is easy.\n\tIn fact,if you bengin learn, you can know that every thing is easy when you start.you just need some knowledge"];
    //设置文本内容的属性
    //1设置部分文字颜色
    [attString addAttribute:(id)kCTForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0 , 27)];
    //2设置部分文字字体
    CGFloat fontSize = 20;
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
    [attString addAttribute:(id)kCTFontAttributeName value:(__bridge id)fontRef range:NSMakeRange(0, 27)];
    
    //3设置斜体
    CTFontRef italicFontRef = CTFontCreateWithName((CFStringRef)[UIFont italicSystemFontOfSize:20].fontName, 16, NULL);
    [attString addAttribute:(id)kCTFontAttributeName value:(__bridge id)italicFontRef range:NSMakeRange(27, 9)];
    // xzj_todo
    [attString addAttribute:(id)kCTForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(27 , 9)];
    
    //4设置下划线
    [attString addAttribute:(id)kCTUnderlineStyleAttributeName value:(id)[NSNumber numberWithInteger:kCTUnderlineStyleDouble] range:NSMakeRange(36, 10)];
    //5设置下划线颜色
    [attString addAttribute:(id)kCTUnderlineColorAttributeName value:(id)[UIColor greenColor].CGColor range:NSMakeRange(36, 10)];
    // xzj_todo
    [attString addAttribute:(id)kCTForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(36 , 10)];
    
    //6设置空心字
    long number1 = 2;
    CFNumberRef numRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number1);
    [attString addAttribute:(id)kCTStrokeWidthAttributeName value:(__bridge id)numRef range:NSMakeRange(56, 10)];
    // xzj_todo
    [attString addAttribute:(id)kCTForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(56 , 10)];
    
    
    
    //7设置字体间距
    long number = 10;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number);
    [attString addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(40, 10)];
    // xzj_todo
    [attString addAttribute:(id)kCTForegroundColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(40 , 10)];
    
    //8设置行间距
    CGFloat lineSpacing = 10;
    const CFIndex kNumberOfSettings = 3;
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        {kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpacing},
        {kCTParagraphStyleSpecifierMaximumLineHeight, sizeof(CGFloat), &lineSpacing},
        {kCTParagraphStyleSpecifierMinimumLineHeight, sizeof(CGFloat), &lineSpacing}
    };
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    [attString addAttribute:(id)kCTParagraphStyleAttributeName value:(__bridge id)theParagraphRef range:NSMakeRange(0, [attString length])];
    
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
