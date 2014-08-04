//
//  SinView.m
//  Biorhythm
//
//  Created by Jianhai Yu on 14/8/1.
//  Copyright (c) 2014年 JianhaiYu. All rights reserved.
//

#import "SinView.h"

@implementation SinView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
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
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
