//
//  ViewController.m
//  Biorhtthm
//
//  Created by Jianhai Yu on 14/7/25.
//  Copyright (c) 2014年 JianhaiYu. All rights reserved.
//

#import "ViewController.h"
#import "AddUserInfoViewController.h"
#import "DetailViewController.h"
#import "InfoViewController.h"

#define DBNAME @"userInform.sqlite"

@interface ViewController ()
{
    UITableView *_tableView;
    NSMutableArray *_userInfoArray;
    NSMutableArray *_userAgeArray;
    NSMutableArray *_userNameArray;
    NSMutableDictionary *_userInfoDictionary;
    AddUserInfoViewController *_auivc;
    UINavigationController *_aunaivc;
    InfoViewController *_ivc;
    UINavigationController *_naivc;

    NSString *nsNameStr;
    int age;
    int totalDays;
    NSMutableArray *_totalDaysArray;
    NSMutableArray *_deleteArray;
    
    int pValue;
    NSMutableArray *_pValueArray;
    int iValue;
    NSMutableArray *_iValueArray;
    int mValue;
    NSMutableArray *_mValueArray;
    
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

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;

    [super viewWillAppear:animated];
    [_userNameArray removeAllObjects];
    [_userAgeArray removeAllObjects];
    [_totalDaysArray removeAllObjects];
    [_pValueArray removeAllObjects];
    [_iValueArray removeAllObjects];
    [_mValueArray removeAllObjects];
    [self searchUserInfo];
   [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"生物节律";
//    self.view.backgroundColor = [UIColor blackColor];
    
    UIBarButtonItem *leftBBI = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(infoButtonClicked:)];
    self.navigationItem.leftBarButtonItem = leftBBI;

    UIBarButtonItem *infoButton = [[UIBarButtonItem alloc]initWithTitle:@"关于" style:UIBarButtonItemStylePlain target:self action:@selector(infoButtonClicked:)];
    self.navigationItem.leftBarButtonItem = infoButton;
    
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;

    _auivc = [[AddUserInfoViewController alloc]init];
    _aunaivc = [[UINavigationController alloc]initWithRootViewController:_auivc];
    _ivc = [[InfoViewController alloc]init];
    _naivc = [[UINavigationController alloc]initWithRootViewController:_ivc];
    
    
    _userInfoDictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
    _userNameArray = [[NSMutableArray alloc]initWithCapacity:0];
    _userInfoArray = [[NSMutableArray alloc]initWithCapacity:0];
    _userAgeArray = [[NSMutableArray alloc]initWithCapacity:0];
    _totalDaysArray = [[NSMutableArray alloc]initWithCapacity:0];
    _pValueArray = [[NSMutableArray alloc]initWithCapacity:0];
    _iValueArray = [[NSMutableArray alloc]initWithCapacity:0];
    _mValueArray = [[NSMutableArray alloc]initWithCapacity:0];
    _deleteArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"image.png"]];
//    _tableView.backgroundView = imageView;
    [self.view addSubview:_tableView];
    [self openOrCreatDatabase];
    
 
}
- (void) calculateBiorhythmValue{
    
    NSDate *selectedYear = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    currentYear = [[dateFormatter stringFromDate:selectedYear] intValue];
//    NSLog(@"current year:%d",currentYear);
    
    NSDate *selectedMonth = [NSDate date];
    NSDateFormatter *dateFormatterMonth = [[NSDateFormatter alloc] init];
    [dateFormatterMonth setDateFormat:@"MM"];
    currentMonth = [[dateFormatterMonth stringFromDate:selectedMonth] intValue];
//    NSLog(@"current month:%d",currentMonth);
    
    NSDate *selectedDay = [NSDate date];
    NSDateFormatter *dateFormatterDay = [[NSDateFormatter alloc] init];
    [dateFormatterDay setDateFormat:@"dd"];
    currentDay = [[dateFormatterDay stringFromDate:selectedDay] intValue];
//    NSLog(@"current day:%d",currentDay);
    
    currentYearMinsBirthYear = currentYear - BirthYear;
    currentDayMinsBirthDay = [self calculateDaysOfMonth:currentMonth days:currentDay] - [self calculateDaysOfMonth:BirthMonth days:BirthDay];
    totalDays = 365.25*(double)currentYearMinsBirthYear + currentDayMinsBirthDay;
    
    
    
//    NSLog(@"birth year:%d",BirthYear);

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 跳转按钮

- (void)infoButtonClicked:(UIButton *)sender{
        [self.navigationController presentViewController:_naivc animated:YES completion:^{
    }];
}

#pragma mark - 不允许横屏

//-(NSUInteger)supportedInterfaceOrientations
//
//{
//    return UIInterfaceOrientationMaskPortrait;
//}
#pragma mark - SQLite3 data

- (void) openOrCreatDatabase
{
    //获取沙盒目录，并创建或打开数据库。
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
    
    if (sqlite3_open([database_path UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"ViewController: 数据库打开失败");
    }
    //创建数据表PERSONINFO的语句
    NSString *sqlCreateTable2 = @"CREATE TABLE IF NOT EXISTS USERINFORM (ID INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, totalDays TEXT, pValue TEXT, iValue TEXT, mValue TEXT,userbirthday TEXT)";
    [self execSql:sqlCreateTable2];
}
//创建数据表  创建一个独立的执行sql语句的方法，传入sql语句，就执行sql语句
-(void)execSql:(NSString *)sql
{
    char *err;
    if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"ViewController: 数据库操作数据失败!");
    }
}
//查询数据库并打印数据
- (void)searchUserInfo
{
    NSString *sqlQuery = @"SELECT * FROM USERINFORM";
    sqlite3_stmt * statement;
    char *name;
    
    if (sqlite3_prepare_v2(database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            name = (char*)sqlite3_column_text(statement, 1);
            nsNameStr = [[NSString alloc]initWithUTF8String:name];
            age = sqlite3_column_int(statement, 2);
            
            char *totalDaysChar = (char*)sqlite3_column_text(statement, 3);
            char *pValueChar = (char*)sqlite3_column_text(statement, 4);
            char *iValueChar = (char*)sqlite3_column_text(statement, 5);
            char *mValueChar = (char*)sqlite3_column_text(statement, 6);
            char *birthday = (char*)sqlite3_column_text(statement, 7);
            NSString *nsTotalDays = [[NSString alloc]initWithUTF8String:totalDaysChar];
            NSString *nsPValue = [[NSString alloc]initWithUTF8String:pValueChar];
            NSString *nsIValue = [[NSString alloc]initWithUTF8String:iValueChar];
            NSString *nsMValue = [[NSString alloc]initWithUTF8String:mValueChar];
            NSString *nsBirthday = [[NSString alloc]initWithUTF8String:birthday];
            
            BirthYear = [nsBirthday intValue];
            NSArray *birthdayArray = [nsBirthday componentsSeparatedByString:@"-"];
            BirthYear = [[birthdayArray objectAtIndex:0]intValue];
            BirthMonth = [[birthdayArray objectAtIndex:1]intValue];
            BirthDay = [[birthdayArray objectAtIndex:2]intValue];
            
            NSLog(@"birthYear from nsBirthday %d,birth month %d, birth day %d",BirthYear, BirthMonth, BirthDay);
            
            NSLog(@"ViewController: 查询得到的数据库中的数据为：name:%@  age:%d, totaldays:%@, pValue:%@, iValue:%@, mValue:%@, birthday:%@",nsNameStr,age, nsTotalDays, nsPValue, nsIValue, nsMValue,nsBirthday);
            [self calculateBiorhythmValue];
//            NSLog(@" calcu totalDays %d",totalDays);

            [_userInfoDictionary setObject:nsNameStr forKey:@"name"];
            NSString *nsAge = [NSString stringWithFormat:@"%d",age];
            [_userInfoDictionary setObject:nsAge forKey:@"age"];
//            [_userInfoDictionary setObject:nsTotalDays forKey:@"totaldays"];
//            [_userInfoDictionary setObject:nsPValue forKey:@"pvalue"];
//            [_userInfoDictionary setObject:nsIValue forKey:@"ivalue"];
//            [_userInfoDictionary setObject:nsMValue forKey:@"mvlaue"];
            
            [_userAgeArray addObject:[_userInfoDictionary objectForKey:@"age"]];
            [_userNameArray addObject:[_userInfoDictionary objectForKey:@"name"]];
            [_totalDaysArray addObject:[NSString stringWithFormat:@"%d",totalDays]];
            [_pValueArray addObject:[NSString stringWithFormat:@"%d",pValue]];
            [_iValueArray addObject:[NSString stringWithFormat:@"%d",iValue]];
            [_mValueArray addObject:[NSString stringWithFormat:@"%d",mValue]];
        }
    }
    NSLog(@"ViewController: 用户数量为 %d",_userNameArray.count);
    [_tableView reloadData];
    sqlite3_close(database);
}

//-(void)deleteAllUserInfo{
//    const char *deleteAllSql="delete from USERINFORM where 1>0";
//    char *err;
//    if(sqlite3_exec(database, deleteAllSql, NULL, NULL, &err)==SQLITE_OK){
//        NSLog(@"删除所有数据成功");
//    }
//    else NSLog(@"error !! 删除失败！");
//}
- (void) deleteUserInformation{
        sqlite3_stmt *statement;
        //组织SQL语句
        static char *sql = "delete from USERINFORM  where name = ? and age = ?";
        //将SQL语句放入sqlite3_stmt中
        int success = sqlite3_prepare_v2(database, sql, -1, &statement, NULL);
        if (success != SQLITE_OK) {
            NSLog(@"ViewController: Error: failed to delete:testTable");
            sqlite3_close(database);
        }
        //这里的数字1，2，3代表第几个问号。这里只有1个问号，这是一个相对比较简单的数据库操作，真正的项目中会远远比这个复杂
        sqlite3_bind_text(statement, 1, [[_deleteArray objectAtIndex:0] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [[_deleteArray objectAtIndex:1] UTF8String], -1, SQLITE_TRANSIENT);
        //执行SQL语句。这里是更新数据库
        success = sqlite3_step(statement);
        //释放statement
        sqlite3_finalize(statement);
        
        //如果执行失败
        if (success == SQLITE_ERROR) {
            NSLog(@"ViewController: Error: failed to delete the database with message.");
            //关闭数据库
            sqlite3_close(database);
        }
        //执行成功后依然要关闭数据库
        NSLog(@"ViewController: Delete user information success!");
        sqlite3_close(database);
}

#pragma mark - 跳转到添加用户界面
- (void)insertNewObject:(id)sender {
    [self presentViewController:_aunaivc animated:YES completion:^{
    }];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_userNameArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    此种写法是解决cell重用问题
    NSString *cellID = [NSString stringWithFormat:@"cellid%d%d",[indexPath section],[indexPath row]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell = nil;// 解决重用问题，简单暴力！！ 
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor clearColor];//cell 设置为透明
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = @"";
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 113, 40)];
    nameLabel.text = @"";
    nameLabel.text = [NSString stringWithFormat:@"姓名: %@",[_userNameArray objectAtIndex:indexPath.row]];
    [cell addSubview:nameLabel];

    pValue = [[_pValueArray objectAtIndex:indexPath.row] intValue];
    iValue = [[_iValueArray objectAtIndex:indexPath.row] intValue];
    mValue = [[_mValueArray objectAtIndex:indexPath.row] intValue];
    totalDays = [[_totalDaysArray objectAtIndex:indexPath.row] intValue];
    
    UILabel *ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, 113, 40)];
    ageLabel.text = @"";
    ageLabel.text = [NSString stringWithFormat:@"年龄: %@ 岁",[_userAgeArray objectAtIndex:indexPath.row]];
    [cell addSubview:ageLabel];
    UILabel *allDaysLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 113, 40)];
    allDaysLabel.text = @"";
    allDaysLabel.text = [NSString stringWithFormat:@"总计: %d天",totalDays];
    [cell addSubview:allDaysLabel];
        
    UILabel *pLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 10, 40, 40)];
    pLabel.text = @"体力:";
    [cell addSubview:pLabel];
    
    UILabel *iLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 45, 40, 40)];
    iLabel.text = @"智力:";
    [cell addSubview:iLabel];
    
    UILabel *mLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 80, 40, 40)];
    mLabel.text = @"情绪:";
    [cell addSubview:mLabel];
    
    UIProgressView *pProgressView = [[UIProgressView alloc]initWithFrame:CGRectMake(160, 30, 80, 40)];
    pProgressView.progressViewStyle = UIProgressViewStyleDefault;
    if (((float)pValue/100) < 0.0) {
        pProgressView.progress =(-(float)pValue/100);
//        NSLog(@"pValue is %f",pProgressView.progress);
        pProgressView.progressTintColor = [UIColor colorWithRed:(255-pValue) green:0 blue:0 alpha:1];
    } else {
        pProgressView.progress = (float)pValue/100;
    }
    [cell addSubview:pProgressView];

    UIProgressView *iProgressView = [[UIProgressView alloc]initWithFrame:CGRectMake(160, 65, 80, 40)];
    iProgressView.progressViewStyle = UIProgressViewStyleDefault;
    iProgressView.progress = (float)iValue/100;
    if (((float)iValue/100) < 0.0) {
        iProgressView.progress =(-(float)iValue/100);
        iProgressView.progressTintColor = [UIColor colorWithRed:(255-iValue) green:0 blue:0 alpha:1];
    } else {
        iProgressView.progress = (float)iValue/100;
    }
    [cell addSubview:iProgressView];
    
    UIProgressView *mProgressView = [[UIProgressView alloc]initWithFrame:CGRectMake(160, 100, 80, 40)];
    mProgressView.progressViewStyle = UIProgressViewStyleDefault;
    mProgressView.progress = (float)mValue/100;
    if (((float)mValue/100) < 0.0) {
        mProgressView.progress =(-(float)mValue/100);
        mProgressView.progressTintColor = [UIColor colorWithRed:(255-mValue) green:0 blue:0 alpha:1];
    } else {
        mProgressView.progress = (float)mValue/100;
    }
    [cell addSubview:mProgressView];
    
    UILabel *pValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(240, 10, 50, 40)];
    pValueLabel.textAlignment = NSTextAlignmentRight;
    pValueLabel.text = [NSString stringWithFormat:@"%d%%",pValue];
    [cell addSubview:pValueLabel];
    
    UILabel *iValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(240, 45, 50, 40)];
    iValueLabel.textAlignment = NSTextAlignmentRight;
    iValueLabel.text = [NSString stringWithFormat:@"%d%%",iValue];
    [cell addSubview:iValueLabel];
    
    UILabel *mValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(240, 80, 50, 40)];
    mValueLabel.textAlignment = NSTextAlignmentRight;
    mValueLabel.text = [NSString stringWithFormat:@"%d%%",mValue];
    [cell addSubview:mValueLabel];

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_deleteArray addObject:[_userNameArray objectAtIndex:indexPath.row]];
        [_deleteArray addObject:[_userAgeArray objectAtIndex:indexPath.row]];
        
        [self->_userNameArray removeObjectAtIndex:indexPath.row];
        [self->_userAgeArray removeObjectAtIndex:indexPath.row];
        
        [self deleteUserInformation];
//        [self deleteAllUserInfo];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSLog(@"ViewController:_deleteArray%@",_deleteArray);
        NSLog(@"ViewController:_userNameArray%@",_userNameArray);
        NSLog(@"ViewController:_userAgeArray%@",_userAgeArray);
        [tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        NSDate *object = self.objects[indexPath.row];
//        self.detailViewController.detailItem = object;
    }
    NSLog(@"ViewController: %ld indexPath choosed",(long)indexPath.row);
    DetailViewController *dvc = [[DetailViewController alloc]init];
    dvc.userName = [_userNameArray objectAtIndex:indexPath.row];
    dvc.age = [[_userAgeArray objectAtIndex:indexPath.row]intValue];
    dvc.totalDays = [[_totalDaysArray objectAtIndex:indexPath.row] intValue];
    dvc.pValue = [[_pValueArray objectAtIndex:indexPath.row]intValue];
    dvc.iValue = [[_iValueArray objectAtIndex:indexPath.row]intValue];
    dvc.mValue = [[_mValueArray objectAtIndex:indexPath.row]intValue];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:dvc animated:YES];
}


@end
