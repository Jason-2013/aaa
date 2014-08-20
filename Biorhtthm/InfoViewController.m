//
//  InfoViewController.m
//  Biorhtthm
//
//  Created by Jianhai Yu on 14/7/30.
//  Copyright (c) 2014年 JianhaiYu. All rights reserved.
//

#import "InfoViewController.h"
#import "PDFView.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"关于生物节律";
    UIBarButtonItem *leftBBI = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(backToRootView:)];
    self.navigationItem.leftBarButtonItem = leftBBI;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(10, 15, 60, 30);
    [button setTitle:@"<<关于" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backToRootView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
//    CGRect frame = CGRectMake(0, 45, 320, 523);
//    PDFView *pdfView = [[PDFView alloc]initWithFrame:frame];
//    pdfView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:pdfView];
    
    
    // 文本视图
    UITextView *textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(10, 65, 300, 500);
//    textView.backgroundColor = [UIColor redColor];
    textView.text = @"    生物节律是生物钟的一种，生物钟给人的直观感觉就是体现人的作息周期，生物节律体现的是人的智力、情绪、体力的变化周期。\n一个人从出生之日起，到离开世界为止，这个规律自始至终不会有丝毫变化，不受任何后天影响，这个规律就是人的“生物节律”，即：“体力节律、情绪节律、智力节律”。它们按正弦曲线规律变化，可分为“高潮期”、“低潮期”、“临界点”、“临界期”。\n高潮期内人的心情舒畅，精力充沛，工作效率高；\n低潮期内人的心情不佳，容易疲劳、健忘，工作效率低；\n临界期内，人的体力、情绪和智力极不稳定，做事非常容易出现失误。\n利用方法\n处于高潮期的时候，就应充分利用自己良好的“竟技”状态，努力学习，勤奋工作，多作贡献。这时如果盲目乐观，也会给工作和学习带来影响。\n处于低潮期和临界期的时候，也不必过分紧张。因为紧张的心理状态，会影响人的体力和大脑的机能，使工作和学习效率进一步下降。在这一时期，适当注意休息、锻炼和营养，注意用脑的卫生，如变换大脑活动的方式，轮流学习不同的内容，使大脑的各个区域交替活动、劳逸结合，就可以使大脑仍然有条不紊地工作，有利于提高工作和学习的效率。“事在人为”。\n掌握人体生物节奏的规律，是为了扬长避短，使人们更好地工作、生活和学习。忧心忡忡是不必要的，盲目乐观也是十分有害的。";
    textView.font = [UIFont boldSystemFontOfSize:17];
    // 设置不可编辑
    textView.editable = NO;
    [self.view addSubview:textView];
}

- (void)backToRootView:(UIButton *)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)drawRect:(CGRect)rect {
//    
//    CGContextRef cgctx=UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(cgctx, 1.00f);
//    CGContextSetStrokeColorWithColor(cgctx, [UIColor redColor].CGColor);
//    float x=0.0;
//    float y=240.0;
//    CGContextMoveToPoint(cgctx, x, y);
//    for(float x=0;x<320;x++){
//        y=sin(x/180*3.14)*100+240.0;
//        CGContextAddLineToPoint(cgctx,x,y);
//        CGContextStrokePath(cgctx);
//        CGContextMoveToPoint(cgctx,x, y);
//    }
//    
//    CGContextRef cgcty=UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(cgcty, 1.00f);
//    CGContextSetStrokeColorWithColor(cgcty, [UIColor blackColor].CGColor);
//    float xy=0.0;
//    float yy=260.0;
//    CGContextMoveToPoint(cgcty, xy, yy);
//    for(float xy=0;xy<320;xy++){
//        yy=sin(xy/180*3.14)*100+260.0;
//        CGContextAddLineToPoint(cgcty,xy,yy);
//        CGContextStrokePath(cgcty);
//        CGContextMoveToPoint(cgcty,xy, yy);
//    }
//    
//    CGContextRef cgctyz=UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(cgctyz, 1.00f);
//    CGContextSetStrokeColorWithColor(cgctyz, [UIColor yellowColor].CGColor);
//    float xyz=0.0;
//    float yyz=280.0;
//    CGContextMoveToPoint(cgctyz, xyz, yyz);
//    for(float xyz=0;xyz<320;xyz++){
//        yyz=sin(xyz/180*3.14)*100+280.0;
//        CGContextAddLineToPoint(cgctyz,xyz,yyz);
//        CGContextStrokePath(cgctyz);
//        CGContextMoveToPoint(cgctyz,xyz, yyz);
//    }
//}
//

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
