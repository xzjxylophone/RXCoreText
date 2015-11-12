# RXCoreText




```objective-c

#pragma mark - RXCTViewDelegate
- (void)tapInRXCTView:(RXCTView *)rxctView rxctData:(RXCTData *)rxctData
{
    NSLog(@"rxctData:%@", rxctData);
}

#pragma mark - Private
- (void)testRXCTView
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
    // 本地图片地址
    imageData.imageName = @"coretext-image-1.jpg";
    imageData.width = width - 100;
    imageData.height = 100;
    
    
    // 可点击文本
    RXCTLinkData *linkData = [[RXCTLinkData alloc] init];
    linkData.textColor = [UIColor blueColor];
    linkData.font = [UIFont boldSystemFontOfSize:15];
    linkData.content = @"此段文字是一个类似于超链接文本,跟普通文本有点类似,只是多了一个下划线和点击事件";
    
    // 网络图片
    RXCTImageData *imageData2 = [[RXCTImageData alloc] init];
    // 本地图片地址
    imageData2.imageName = @"";
    imageData2.imageUrl = @"http://cloud.yiyizuche.cn/img/1234/56/123456789/201510/20151014_164938_992996-4-3-1.jpg-0.jpg";
    imageData2.imagePlacholder = [UIImage imageNamed:@"coretext-image-2.jpg"];
    imageData2.width = width - 40;
    imageData2.height = 50;
    
    // 图片
    RXCTImageData *imageData3 = [[RXCTImageData alloc] init];
    // 本地图片地址
    imageData3.imageName = @"coretext-image-2.jpg";
    imageData3.width = width;
    imageData3.height = 60;
    
    
    NSArray *ary = @[textData, textData2, imageData, linkData, imageData2, imageData3];
    
    RXCTFrameData *data = [RXCTFrameData parseWithArray:ary config:config];
    RXCTView *rxctView = [[RXCTView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    rxctView.rxctFrameData = data;
    CGRect frame = rxctView.frame;
    frame.size.height = data.height;
    rxctView.frame = frame;
    rxctView.e_RXCT_TapType = kE_RXCT_TapType_Next;
    rxctView.backgroundColor = [UIColor yellowColor];
    rxctView.delegate = self;
    [self.view addSubview:rxctView];
}
```










