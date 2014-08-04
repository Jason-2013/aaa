//
//  DetailViewController.h
//  Biorhtthm
//
//  Created by Jianhai Yu on 14/7/26.
//  Copyright (c) 2014年 JianhaiYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController < UIScrollViewDelegate >
{
    NSString *userName;
    int age;
    int totalDays;
    int pValue;
    int iValue;
    int mValue;
}
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,assign) int age;
@property (nonatomic,assign) int totalDays;
@property (nonatomic,assign) int pValue;
@property (nonatomic,assign) int iValue;
@property (nonatomic,assign) int mValue;
@end
