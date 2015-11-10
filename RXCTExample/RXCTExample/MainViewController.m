//
//  MainViewController.m
//  RXCTExample
//
//  Created by Rush.D.Xzj on 15/11/10.
//  Copyright © 2015年 Rush.D.Xzj. All rights reserved.
//

#import "MainViewController.h"
#import "RXCTHeader.h"

@interface MainViewController ()

@end

@implementation MainViewController


- (void)testMyContent1
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    RXCTFrameParserConfig *config = [[RXCTFrameParserConfig alloc] init];
    config.width = width;
    config.lineSpace = 10;
    config.font = [UIFont systemFontOfSize:22];
    config.textColor = [UIColor greenColor];
    
    // 普通文本
    RXCTTextData *textData = [[RXCTTextData alloc] init];
    textData.textColor = [UIColor redColor];
    textData.font = [UIFont boldSystemFontOfSize:15];
    textData.content = @"此段文本是一个普通文本,可以设置文字的字体,颜色等其他样式";
    
    
    // 普通文本,用config的信息
    RXCTTextData *textData2 = [[RXCTTextData alloc] init];
    textData2.content = @"此段文本是一个普通文本,使用默认的配置字体颜色";
    
    // 图片
    RXCTImageData *imageData = [[RXCTImageData alloc] init];
    imageData.imageName = @"coretext-image-1.jpg";
    imageData.imageUrl = @"";
    imageData.width = 340;
    imageData.height = 160;
    
    
    // 可点击文本
    RXCTLinkData *linkData = [[RXCTLinkData alloc] init];
    linkData.textColor = [UIColor blueColor];
    linkData.font = [UIFont boldSystemFontOfSize:15];
    linkData.content = @"此段文字是一个类似于超链接文本,跟普通文本有点类似,只是多了一个下划线和点击事件";
    
    
    NSArray *ary = @[textData, textData2, imageData, linkData];
    
    RXCTFrameData *data = [RXCTFrameData parseWithArray:ary config:config];
    RXCTView *rxctView = [[RXCTView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    rxctView.rxctFrameData = data;
    CGRect frame = rxctView.frame;
    frame.size.height = data.height;
    rxctView.frame = frame;
    rxctView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:rxctView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"首页";
    
    
    [self testMyContent1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Override
#ifdef __IPHONE_7_0
- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}
#endif

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
