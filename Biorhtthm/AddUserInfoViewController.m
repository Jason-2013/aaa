//
//  AddUserInfoViewController.m
//  Biorhythm
//
//  Created by Jianhai Yu on 14/7/22.
//  Copyright (c) 2014年 JianhaiYu. All rights reserved.
//

#import "AddUserInfoViewController.h"

#define DBNAME       @"userInfo.sqlite"
#define NAME         @"name"
#define USERBIRTHDAY @"userbirthday"
#define AGE          @"age"
#define TOTALDAYS    @"totaldays"
#define PVALUE       @"pvalue"
#define IVALUE       @"ivalue"
#define MVALUE       @"mvalue"
#define TABLENAME    @"USERINFO"

@interface AddUserInfoViewController ()
{
    UITableView *_tableView;
    NSString *birthdayDateString;
    NSString *userBirthday;
    
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
    
}
@end

@implementation AddUserInfoViewController
@synthesize dataPicker,userNameTextField;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, 320, 0.5)];
    //    titleLabel.backgroundColor = [UIColor colorWithRed:20 green:20 blue:20 alpha:0.6];
    titleLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:titleLabel];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
 
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 170, 320, 40)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    userNameTextField.delegate = self;
    
    userNameTextField.text = nil;
    birthdayDateString = nil;
    
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
    NSString *sqlCreateTable2 = @"CREATE TABLE IF NOT EXISTS USERINFO (ID INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, totalDays TEXT, pValue TEXT, iValue TEXT, mValue TEXT,userbirthday TEXT)";
    [self execSql:sqlCreateTable2];
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
//                                       @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
//                                       TABLENAME, NAME, AGE, TOTALDAYS, userNameTextField.text, [NSString stringWithFormat:@"%d",currentYearMinsBirthYear], userNameTextField.text];
//    NSString *insertNameAndBirthday = [NSString stringWithFormat:
//                                       @"INSERT INTO '%@' ('%@', '%@') VALUES ('%@', '%@')",
//                                       TABLENAME, NAME, AGE, userNameTextField.text, [NSString stringWithFormat:@"%d",currentYearMinsBirthYear]];

//    NSLog(@"name:%@, age:%@, total days:%@, p value:%@, i value:%@, m value%@",userNameTextField.text, [NSString stringWithFormat:@"%d",currentYearMinsBirthYear], [NSString stringWithFormat:@"%d",totalDays], [NSString stringWithFormat:@"%d",pValue], [NSString stringWithFormat:@"%d",iValue], [NSString stringWithFormat:@"%d",mValue]);
    
    
    NSString *insertTotalDaysAndBiorhythmValues = [NSString stringWithFormat:
                                       @"INSERT INTO '%@' ('%@', '%@', '%@','%@','%@', '%@', '%@') VALUES ('%@', '%@','%@', '%@','%@', '%@', '%@')",
                                       TABLENAME, NAME, AGE,TOTALDAYS, PVALUE, IVALUE, MVALUE, USERBIRTHDAY, userNameTextField.text, [NSString stringWithFormat:@"%d",currentYearMinsBirthYear], [NSString stringWithFormat:@"%d",totalDays], [NSString stringWithFormat:@"%d",pValue], [NSString stringWithFormat:@"%d",iValue], [NSString stringWithFormat:@"%d",mValue],userBirthday];

    [self execSql:insertTotalDaysAndBiorhythmValues];
}


//查询数据库并打印数据
- (void)searchUserInfo
{
    NSString *sqlQuery = @"SELECT * FROM USERINFO";
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

- (IBAction)saveButtonClicked:(id)sender {

    if ( userNameTextField.text == nil || birthdayDateString == nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您输入的信息不完整，请重新输入！" message: birthdayDateString delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil, nil];
        [alert show];
    } else {
        [self openOrCreatDatabase];
        [self insertUserInfo];
        [_tableView reloadData];
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
}

- (IBAction)cancleButtonClicked:(id)sender {
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
        cell.detailTextLabel.text = @"选择日期后点击来输入生日！";
    } else {
        cell.detailTextLabel.text = birthdayDateString;
    }
    cell.detailTextLabel.textColor = [UIColor blueColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDate *selectedYear = [dataPicker date];
    NSDateFormatter *dateFormatterYear = [[NSDateFormatter alloc] init];
    [dateFormatterYear setDateFormat:@"yyyy"];
    BirthYear = [[dateFormatterYear stringFromDate:selectedYear] intValue];
    NSLog(@"BirthYear is %d",BirthYear);
    
    NSDate *selectedMonth = [dataPicker date];
    NSDateFormatter *dateFormatterMonth = [[NSDateFormatter alloc] init];
    [dateFormatterMonth setDateFormat:@"MM"];
    BirthMonth = [[dateFormatterMonth stringFromDate:selectedMonth] intValue];
    NSLog(@"BirthMonth is %d",BirthMonth);
    
    NSDate *selectedDay = [dataPicker date];
    NSDateFormatter *dateFormatterDay = [[NSDateFormatter alloc] init];
    [dateFormatterDay setDateFormat:@"dd"];
    BirthDay = [[dateFormatterDay stringFromDate:selectedDay] intValue];
    NSLog(@"BirthDay is %d",BirthDay);
    
    NSDate *selected = [dataPicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    birthdayDateString = [dateFormatter stringFromDate:selected];
    NSLog(@"birthdayDateString is %@",birthdayDateString);
 
    [tableView reloadData];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [userNameTextField resignFirstResponder];
}

@end
