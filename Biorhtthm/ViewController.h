//
//  ViewController.h
//  Biorhtthm
//
//  Created by Jianhai Yu on 14/7/25.
//  Copyright (c) 2014年 JianhaiYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface ViewController : UIViewController < UITableViewDataSource, UITableViewDelegate >
{
    sqlite3 *database;
}
@end

