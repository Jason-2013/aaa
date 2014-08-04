//
//  InfoViewController.m
//  Biorhtthm
//
//  Created by Jianhai Yu on 14/7/30.
//  Copyright (c) 2014年 JianhaiYu. All rights reserved.
//

#import "InfoViewController.h"
#import "SinView.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    UIBarButtonItem *leftBBI = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(backToRootView:)];
    self.navigationItem.leftBarButtonItem = leftBBI;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(10, 15, 60, 30);
    [button setTitle:@"<<关于" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backToRootView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:imageView];
    
    self.view.backgroundColor=[UIColor blueColor];
    
    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 15.0);  //线宽
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 0.0, 1.0);  //颜色
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 100, 100);  //起点坐标
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 200, 100);   //终点坐标
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    imageView.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
///*
//
// CGContextRef cgctx=UIGraphicsGetCurrentContext();
// CGContextSetLineWidth(cgctx, 1.00f);
// CGContextSetStrokeColorWithColor(cgctx, [UIColor redColor].CGColor);
// float x=0.0;
// float y=240.0;
// CGContextMoveToPoint(cgctx, x, y);
// for(float x=0;x<1;x++){
// y=sin(x/180*3.14)*100+240.0;
// CGContextAddLineToPoint(cgctx,x,y);
// CGContextStrokePath(cgctx);
// CGContextMoveToPoint(cgctx,x, y);
// }

 
 //*/


}

- (void)backToRootView:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef cgctx=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(cgctx, 1.00f);
    CGContextSetStrokeColorWithColor(cgctx, [UIColor redColor].CGColor);
    float x=0.0;
    float y=240.0;
    CGContextMoveToPoint(cgctx, x, y);
    for(float x=0;x<320;x++){
        y=sin(x/180*3.14)*100+240.0;
        CGContextAddLineToPoint(cgctx,x,y);
        CGContextStrokePath(cgctx);
        CGContextMoveToPoint(cgctx,x, y);
    }
    
    CGContextRef cgcty=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(cgcty, 1.00f);
    CGContextSetStrokeColorWithColor(cgcty, [UIColor blackColor].CGColor);
    float xy=0.0;
    float yy=260.0;
    CGContextMoveToPoint(cgcty, xy, yy);
    for(float xy=0;xy<320;xy++){
        yy=sin(xy/180*3.14)*100+260.0;
        CGContextAddLineToPoint(cgcty,xy,yy);
        CGContextStrokePath(cgcty);
        CGContextMoveToPoint(cgcty,xy, yy);
    }
    
    CGContextRef cgctyz=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(cgctyz, 1.00f);
    CGContextSetStrokeColorWithColor(cgctyz, [UIColor yellowColor].CGColor);
    float xyz=0.0;
    float yyz=280.0;
    CGContextMoveToPoint(cgctyz, xyz, yyz);
    for(float xyz=0;xyz<320;xyz++){
        yyz=sin(xyz/180*3.14)*100+280.0;
        CGContextAddLineToPoint(cgctyz,xyz,yyz);
        CGContextStrokePath(cgctyz);
        CGContextMoveToPoint(cgctyz,xyz, yyz);
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
