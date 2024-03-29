//
//  AddUserInfoViewController.m
//  Biorhythm
//
//  Created by Jianhai Yu on 14/7/22.
//  Copyright (c) 2014年 JianhaiYu. All rights reserved.
//

#import "AddUserInfoViewController.h"

#define DBNAME       @"userInform.sqlite"

#define NAME         @"name"
#define NAME         @"name"
#define USERBIRTHDAY @"userbirthday"
#define AGE          @"age"
#define TOTALDAYS    @"totaldays"
#define PVALUE       @"pvalue"
#define IVALUE       @"ivalue"
#define MVALUE       @"mvalue"
#define USERBIRTHDAY @"userbirthday"

#define TABLENAME    @"USERINFORM"

@interface AddUserInfoViewController ()
{
    UITableView *_tableView;
    NSString *birthdayDateString;
    
    // 封进去
    int totalDays;
    int pValue;
    int iValue;
    int mValue;
    
    // 计算使用
    int currentYearMinsBirthYear;
    int currentDayMinsBirthDay;
    int currentYear;
    int currentMonth;
    int currentDay;
    int BirthYear;
    int BirthMonth;
    int BirthDay;
    
    BOOL isTabSelected;
}
@end

@implementation AddUserInfoViewController
@synthesize dataPicker,userNameTextField;
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    userNameTextField.text = @"";
    birthdayDateString = nil;
//    dataPicker = nil;
    self.dataPicker.hidden = YES;
    isTabSelected = YES;
    [_tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"添加用户";
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonClicked:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    UIBarButtonItem *cancleButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancleButtonClicked:)];
    self.navigationItem.leftBarButtonItem = cancleButton;
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 320, 0.5)];
//    //    titleLabel.backgroundColor = [UIColor colorWithRed:20 green:20 blue:20 alpha:0.6];
//    titleLabel.backgroundColor = [UIColor lightGrayColor];
//    [self.view addSubview:titleLabel];
//    self.view.backgroundColor = [UIColor whiteColor];
   
    self.dataPicker.frame = CGRectMake(0, 480, 320, 260);
    self.dataPicker.hidden = YES;
    isTabSelected = YES;

    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 170, 320, 40)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    userNameTextField.delegate = self;
    
    [self openOrCreatDatabase];
    [self searchUserInfo];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - SQLite3 data

- (void) openOrCreatDatabase
{
    //获取沙盒目录，并创建或打开数据库。
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
    
    if (sqlite3_open([database_path UTF8String], &datebase) != SQLITE_OK) {
        sqlite3_close(datebase);
        NSLog(@"数据库打开失败");
    }
    
    //创建数据表PERSONINFO的语句
//    NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS USERINFOR (ID INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, birthdayDate TEXT, birthYear INTEGER, birthMonth INTEGER, birthDay INTEGER)";
    NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS USERINFORM (ID INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, totalDays TEXT, pValue TEXT, iValue TEXT, mValue TEXT,userbirthday TEXT)";
    [self execSql:sqlCreateTable];
}


//创建数据表  创建一个独立的执行sql语句的方法，传入sql语句，就执行sql语句
-(void)execSql:(NSString *)sql
{
    char *err;
    if (sqlite3_exec(datebase, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(datebase);
        NSLog(@"添加用户信息时，数据库操作数据失败!");
        NSLog(@"%s",err);
    }
}


//插入数据
- (void) insertUserInfo
{
    [self calculateBiorhythmValue];
    
//    NSString *insertNameAndBirthday = [NSString stringWithFormat:
//                                       @"INSERT INTO '%@' ('%@', '%@', '%@', '%@', '%@') VALUES ('%@', '%@', '%d', '%d', '%d')",
//                                       TABLENAME, NAME, USERBIRTHDAY, BIRTHYEAR, BIRTHMONTH, BIRTHDAY, USERBIRTHDAY, userNameTextField.text, birthdayDateString, BirthYear, BirthMonth, BirthDay];
//    NSString *insertNameAndBirthday = [NSString stringWithFormat:
//                                       @"INSERT INTO '%@' ('%@', '%@') VALUES ('%@', '%@')",
//                                       TABLENAME, NAME, AGE, userNameTextField.text, [NSString stringWithFormat:@"%d",currentYearMinsBirthYear]];

//    NSLog(@"要存入的信息为：name:%@, birthdayDateString:%@, BirthYear:%d, BirthMonth:%d, BirthDay:%d",userNameTextField.text, birthdayDateString, BirthYear, BirthMonth, BirthDay);
    
    
    NSString *insertTotalDaysAndBiorhythmValues = [NSString stringWithFormat:
                                       @"INSERT INTO '%@' ('%@', '%@', '%@','%@','%@', '%@', '%@') VALUES ('%@', '%@','%@', '%@','%@', '%@', '%@')",
                                       TABLENAME, NAME, AGE,TOTALDAYS, PVALUE, IVALUE, MVALUE, USERBIRTHDAY, userNameTextField.text, [NSString stringWithFormat:@"%d",currentYearMinsBirthYear], [NSString stringWithFormat:@"%d",totalDays], [NSString stringWithFormat:@"%d",pValue], [NSString stringWithFormat:@"%d",iValue], [NSString stringWithFormat:@"%d",mValue],birthdayDateString];
    NSLog(@"要插入的数据为：name:%@  age:%d, totaldays:%@, pValue:%@, iValue:%@, mValue:%@, user birthday:%@",userNameTextField.text, currentYearMinsBirthYear, [NSString stringWithFormat:@"%d",totalDays], [NSString stringWithFormat:@"%d",pValue], [NSString stringWithFormat:@"%d",iValue], [NSString stringWithFormat:@"%d",mValue], birthdayDateString);

    [self execSql:insertTotalDaysAndBiorhythmValues];
}


//查询数据库并打印数据
- (void)searchUserInfo
{
    NSString *sqlQuery = @"SELECT * FROM USERINFORM";
    sqlite3_stmt * statement;
    
    if (sqlite3_prepare_v2(datebase, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *name = (char*)sqlite3_column_text(statement, 1);
            NSString *nsNameStr = [[NSString alloc]initWithUTF8String:name];
            int age = sqlite3_column_int(statement, 2);
            
            char *totalDaysChar = (char*)sqlite3_column_text(statement, 3);
            char *pValueChar = (char*)sqlite3_column_text(statement, 4);
            char *iValueChar = (char*)sqlite3_column_text(statement, 5);
            char *mValueChar = (char*)sqlite3_column_text(statement, 6);
            char *userBirthdayChar = (char*)sqlite3_column_text(statement, 7);
            NSString *nsTotalDays = [[NSString alloc]initWithUTF8String:totalDaysChar];
            NSString *nsPValue = [[NSString alloc]initWithUTF8String:pValueChar];
            NSString *nsIValue = [[NSString alloc]initWithUTF8String:iValueChar];
            NSString *nsMValue = [[NSString alloc]initWithUTF8String:mValueChar];
            NSString *nsUserBirthday = [[NSString alloc]initWithUTF8String:userBirthdayChar];
            
            NSLog(@"数据库中的数据为：name:%@  age:%d, totaldays:%@, pValue:%@, iValue:%@, mValue:%@, user birthday:%@",nsNameStr,age, nsTotalDays, nsPValue, nsIValue, nsMValue, nsUserBirthday);
        }
    }
    sqlite3_close(datebase);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Calculate Biorhythm Value

- (void) calculateBiorhythmValue{
    
    NSDate *selectedYear = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    currentYear = [[dateFormatter stringFromDate:selectedYear] intValue];
    
    NSDate *selectedMonth = [NSDate date];
    NSDateFormatter *dateFormatterMonth = [[NSDateFormatter alloc] init];
    [dateFormatterMonth setDateFormat:@"MM"];
    currentMonth = [[dateFormatterMonth stringFromDate:selectedMonth] intValue];
    
    NSDate *selectedDay = [NSDate date];
    NSDateFormatter *dateFormatterDay = [[NSDateFormatter alloc] init];
    [dateFormatterDay setDateFormat:@"dd"];
    currentDay = [[dateFormatterDay stringFromDate:selectedDay] intValue];

    currentYearMinsBirthYear = currentYear - BirthYear;
    currentDayMinsBirthDay = [self calculateDaysOfMonth:currentMonth days:currentDay] - [self calculateDaysOfMonth:BirthMonth days:BirthDay];
    totalDays = 365.25*(double)currentYearMinsBirthYear + currentDayMinsBirthDay;

    pValue = (int)100*sin((((360*totalDays)/23)*3.14)/180);
    iValue = (int)100*sin((((360*totalDays)/33)*3.14)/180);
    mValue = (int)100*sin((((360*totalDays)/28)*3.14)/180);
    NSLog(@"totalDays %d",totalDays);
}

- (int)calculateDaysOfMonth:(int)month days:(int)day{
    switch (month)
    {
        case 12:
            day += 30;
        case 11:
            day += 31;
        case 10:
            day += 30;
        case 9:
            day += 31;
        case 8:
            day += 31;
        case 7:
            day += 30;
        case 6:
            day += 31;
        case 5:
            day += 30;
        case 4:
            day += 31;
        case 3:
            day += 28;
        case 2:
            day += 31;
    }
   return day;
}

#pragma mark - Button clicked cancle or save

- (void)saveButtonClicked:(id)sender {
 
    [userNameTextField resignFirstResponder];

    if ( [userNameTextField.text  isEqual: @""] || birthdayDateString == nil) {
        NSString *message = [[NSString alloc]init];
        if ([userNameTextField.text  isEqual: @""] && birthdayDateString == nil) {
            message = @"您没有输入任何信息！";
        }else if (birthdayDateString == nil){
            message = @"您没有输入生日，请选择生日后点击！";
        }else {
            message = @"您没有输入用户名！";
       }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil, nil];
        [alert show];
    } else {
        [self openOrCreatDatabase];
        [self insertUserInfo];
        [_tableView reloadData];
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
}

- (void)cancleButtonClicked:(id)sender {
    [userNameTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:^{
        userNameTextField.text = nil;
        birthdayDateString = nil;
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = @" 生日:";
    if (birthdayDateString == nil) {
        cell.detailTextLabel.text = @"请点击以便选择您的生日！     ";
        cell.detailTextLabel.textColor = [UIColor grayColor];
        cell.detailTextLabel.textAlignment = NSTextAlignmentLeft;
   } else {
        cell.detailTextLabel.text = birthdayDateString;
       cell.detailTextLabel.textColor = [UIColor blueColor];
       cell.detailTextLabel.textAlignment = NSTextAlignmentLeft;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [userNameTextField resignFirstResponder];
    if (isTabSelected == YES) {
        
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.1];//动画时间长度，单位秒，浮点数
        [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
        self.dataPicker.frame = CGRectMake(0, 245, 320, 260);
        
        [UIView setAnimationDelegate:self];
        [UIView commitAnimations];
        
        [self ViewAnimation:self.dataPicker willHidden:NO];
        
        
        
        NSDate *selectedYear = [dataPicker date];
        NSDateFormatter *dateFormatterYear = [[NSDateFormatter alloc] init];
        [dateFormatterYear setDateFormat:@"yyyy"];
        BirthYear = [[dateFormatterYear stringFromDate:selectedYear] intValue];
        
        NSDate *selectedMonth = [dataPicker date];
        NSDateFormatter *dateFormatterMonth = [[NSDateFormatter alloc] init];
        [dateFormatterMonth setDateFormat:@"MM"];
        BirthMonth = [[dateFormatterMonth stringFromDate:selectedMonth] intValue];
        
        NSDate *selectedDay = [dataPicker date];
        NSDateFormatter *dateFormatterDay = [[NSDateFormatter alloc] init];
        [dateFormatterDay setDateFormat:@"dd"];
        BirthDay = [[dateFormatterDay stringFromDate:selectedDay] intValue];
        
        NSDate *selected = [dataPicker date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        birthdayDateString = [dateFormatter stringFromDate:selected];
        
        [tableView reloadData];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];

        isTabSelected = NO;
    } else {
        
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.1];//动画时间长度，单位秒，浮点数
        [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
        self.dataPicker.frame = CGRectMake(0, 245, 320, 260);
        
        [UIView setAnimationDelegate:self];
        [UIView commitAnimations];
        [self ViewAnimation:self.dataPicker willHidden:YES];
        
        NSDate *selectedYear = [dataPicker date];
        NSDateFormatter *dateFormatterYear = [[NSDateFormatter alloc] init];
        [dateFormatterYear setDateFormat:@"yyyy"];
        BirthYear = [[dateFormatterYear stringFromDate:selectedYear] intValue];
        
        NSDate *selectedMonth = [dataPicker date];
        NSDateFormatter *dateFormatterMonth = [[NSDateFormatter alloc] init];
        [dateFormatterMonth setDateFormat:@"MM"];
        BirthMonth = [[dateFormatterMonth stringFromDate:selectedMonth] intValue];
        
        NSDate *selectedDay = [dataPicker date];
        NSDateFormatter *dateFormatterDay = [[NSDateFormatter alloc] init];
        [dateFormatterDay setDateFormat:@"dd"];
        BirthDay = [[dateFormatterDay stringFromDate:selectedDay] intValue];
        
        NSDate *selected = [dataPicker date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        birthdayDateString = [dateFormatter stringFromDate:selected];
        
        [tableView reloadData];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];

        self.dataPicker.hidden = YES;
        isTabSelected = YES;
    }
}

- (void)ViewAnimation:(UIView*)view willHidden:(BOOL)hidden {
    
    [UIView animateWithDuration:0.3 animations:^{
        if (hidden) {
            view.frame = CGRectMake(0, 480, 320, 260);
        } else {
            [view setHidden:hidden];
            view.frame = CGRectMake(0, 245, 320, 260);
        }
    } completion:^(BOOL finished) {
        [view setHidden:hidden];
    }];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [userNameTextField resignFirstResponder];
    self.dataPicker.hidden = YES;
    isTabSelected = YES;
}

@end
