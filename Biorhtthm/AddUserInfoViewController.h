//
//  AddUserInfoViewController.h
//  Biorhythm
//
//  Created by Jianhai Yu on 14/7/22.
//  Copyright (c) 2014年 JianhaiYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface AddUserInfoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate ,UITextFieldDelegate >
{
    sqlite3 *datebase;
//    UIDatePicker *dataPicker;
}
- (IBAction)saveButtonClicked:(id)sender;
- (IBAction)cancleButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *dataPicker;
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;

@end
