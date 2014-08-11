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

#define DBNAME @"userInfo.sqlite"

@interface ViewController ()
{
    UITableView *_tableView;
    NSMutableArray *_userInfoArray;
    NSMutableArray *_userAgeArray;
    NSMutableArray *_userNameArray;
    NSMutableDictionary *_userInfoDictionary;
    AddUserInfoViewController *_auivc;
    InfoViewController *_ivc;

    NSString *nsNameStr;
    int age;
    int totalDays;
    NSMutableArray *_totalDaysArray;
    
    int pValue;
    NSMutableArray *_pValueArray;
    int iValue;
    NSMutableArray *_iValueArray;
    int mValue;
    NSMutableArray *_mValueArray;
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
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *leftBBI = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(infoButtonClicked:)];
    self.navigationItem.leftBarButtonItem = leftBBI;

    UIBarButtonItem *infoButton = [[UIBarButtonItem alloc]initWithTitle:@"关于" style:UIBarButtonItemStylePlain target:self action:@selector(infoButtonClicked:)];
    self.navigationItem.leftBarButtonItem = infoButton;
    
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;

    _auivc = [[AddUserInfoViewController alloc]init];
    _ivc = [[InfoViewController alloc]init];
    
    _userInfoDictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
    _userNameArray = [[NSMutableArray alloc]initWithCapacity:0];
    _userInfoArray = [[NSMutableArray alloc]initWithCapacity:0];
    _userAgeArray = [[NSMutableArray alloc]initWithCapacity:0];
    _totalDaysArray = [[NSMutableArray alloc]initWithCapacity:0];
    _pValueArray = [[NSMutableArray alloc]initWithCapacity:0];
    _iValueArray = [[NSMutableArray alloc]initWithCapacity:0];
    _mValueArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
  
    [self openOrCreatDatabase];
}

- (void)infoButtonClicked:(UIButton *)sender{
    [self.navigationController presentViewController:_ivc animated:YES completion:^{
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库操作数据失败!");
    }
}
//查询数据库并打印数据
- (void)searchUserInfo
{
    NSString *sqlQuery = @"SELECT * FROM USERINFO";
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
            NSString *nsTotalDays = [[NSString alloc]initWithUTF8String:totalDaysChar];
            NSString *nsPValue = [[NSString alloc]initWithUTF8String:pValueChar];
            NSString *nsIValue = [[NSString alloc]initWithUTF8String:iValueChar];
            NSString *nsMValue = [[NSString alloc]initWithUTF8String:mValueChar];
            
            NSLog(@"查询得到的数据库中的数据为：name:%@  age:%d, totaldays:%@, pValue:%@, iValue:%@, mValue:%@",nsNameStr,age, nsTotalDays, nsPValue, nsIValue, nsMValue);
            
            [_userInfoDictionary setObject:nsNameStr forKey:@"name"];
            NSString *nsAge = [NSString stringWithFormat:@"%d",age];
            [_userInfoDictionary setObject:nsAge forKey:@"age"];
            [_userInfoDictionary setObject:nsTotalDays forKey:@"totaldays"];
            [_userInfoDictionary setObject:nsPValue forKey:@"pvalue"];
            [_userInfoDictionary setObject:nsIValue forKey:@"ivalue"];
            [_userInfoDictionary setObject:nsMValue forKey:@"mvlaue"];
            
            [_userAgeArray addObject:[_userInfoDictionary objectForKey:@"age"]];
            [_userNameArray addObject:[_userInfoDictionary objectForKey:@"name"]];
            [_totalDaysArray addObject:[_userInfoDictionary objectForKey:@"totaldays"]];
            [_pValueArray addObject:[_userInfoDictionary objectForKey:@"pvalue"]];
            [_iValueArray addObject:[_userInfoDictionary objectForKey:@"ivalue"]];
            [_mValueArray addObject:[_userInfoDictionary objectForKey:@"mvlaue"]];
        }
    }
    
//    NSLog(@"_userInfoDictionary %@",_userInfoDictionary);
//    NSLog(@"_userNameArray %@",_userNameArray);
//    NSLog(@"_totalDaysArray%@",_totalDaysArray);
//    NSLog(@"_pValueArray%@",_pValueArray);
//    NSLog(@"_iValueArray%@",_iValueArray);
//    NSLog(@"_mValueArray%@",_mValueArray);
    NSLog(@"用户数量为 %d",_userNameArray.count);
    [_tableView reloadData];
    sqlite3_close(database);
}

-(void)deleteAllUserInfo{
    const char *deleteAllSql="delete from userInfo where 1>0";
    char *err;
    if(sqlite3_exec(database, deleteAllSql, NULL, NULL, &err)==SQLITE_OK){
        NSLog(@"删除所有数据成功");
    }
    else NSLog(@"error !! 删除失败！");
}

-(void)deleteOneUserInfo{
    
    
    
    NSString *sqlQuery = @"SELECT * FROM USERINFO";
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
            NSString *nsTotalDays = [[NSString alloc]initWithUTF8String:totalDaysChar];
            NSString *nsPValue = [[NSString alloc]initWithUTF8String:pValueChar];
            NSString *nsIValue = [[NSString alloc]initWithUTF8String:iValueChar];
            NSString *nsMValue = [[NSString alloc]initWithUTF8String:mValueChar];
            
            NSLog(@"要删除的数据为：name:%@  age:%d, totaldays:%@, pValue:%@, iValue:%@, mValue:%@",nsNameStr,age, nsTotalDays, nsPValue, nsIValue, nsMValue);
            
            
            NSString *deleteOneUserInfo = [[NSString alloc] initWithFormat:@"delete from userInfor where name = %@ and age = %d and totaldays = %@ and pValue = %@ and iValue = %@ and mValue = %@",nsNameStr,age, nsTotalDays, nsPValue, nsIValue, nsMValue];
            char *err;
            if(sqlite3_exec(database, [deleteOneUserInfo UTF8String], NULL, NULL, &err)==SQLITE_OK){
                NSLog(@"删除个人数据成功");
            }
            else NSLog(@"error !! 删除个人数据失败！");
            NSLog(@"%s",err);
            
        }
    }
    sqlite3_close(database);

    //    NSLog(@"_userInfoDictionary %@",_userInfoDictionary);
    //    NSLog(@"_userNameArray %@",_userNameArray);
    //    NSLog(@"_totalDaysArray%@",_totalDaysArray);
    //    NSLog(@"_pValueArray%@",_pValueArray);
    //    NSLog(@"_iValueArray%@",_iValueArray);
    //    NSLog(@"_mValueArray%@",_mValueArray);
//    NSLog(@"用户数量为 %d",_userNameArray.count);
//    [_tableView reloadData];

}

/*
 
 sql="DELETE FROM SensorData WHERE SensorID=11";//把北京所对应的那一行数据删除掉
 sqlite3_exec(db,sql,0,0,&zErrMsg);

 */
- (void)insertNewObject:(id)sender {
    [self presentViewController:_auivc animated:YES completion:^{
    }];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
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
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"";
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, 113, 40)];
    nameLabel.text = @"";
    nameLabel.text = [NSString stringWithFormat:@"姓名: %@",[_userNameArray objectAtIndex:indexPath.row]];
    [cell addSubview:nameLabel];

    pValue = [[_pValueArray objectAtIndex:indexPath.row] intValue];
    iValue = [[_iValueArray objectAtIndex:indexPath.row] intValue];
    mValue = [[_mValueArray objectAtIndex:indexPath.row] intValue];
    totalDays = [[_totalDaysArray objectAtIndex:indexPath.row] intValue];
    
    UILabel *ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 65, 113, 40)];
    ageLabel.text = @"";
    ageLabel.text = [NSString stringWithFormat:@"年龄: %@ 岁",[_userAgeArray objectAtIndex:indexPath.row]];
    [cell addSubview:ageLabel];
    UILabel *allDaysLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 113, 40)];
    allDaysLabel.text = @"";
    allDaysLabel.text = [NSString stringWithFormat:@"总计: %d天",totalDays];
    [cell addSubview:allDaysLabel];
        
    UILabel *pLabel = [[UILabel alloc]initWithFrame:CGRectMake(125, 30, 40, 40)];
    pLabel.text = @"体力:";
    [cell addSubview:pLabel];
    
    UILabel *iLabel = [[UILabel alloc]initWithFrame:CGRectMake(125, 65, 40, 40)];
    iLabel.text = @"智力:";
    [cell addSubview:iLabel];
    
    UILabel *mLabel = [[UILabel alloc]initWithFrame:CGRectMake(125, 100, 40, 40)];
    mLabel.text = @"情绪:";
    [cell addSubview:mLabel];
    
    UIProgressView *pProgressView = [[UIProgressView alloc]initWithFrame:CGRectMake(175, 50, 80, 40)];
    pProgressView.progressViewStyle = UIProgressViewStyleDefault;
    if (((float)pValue/100) < 0.0) {
        pProgressView.progress =(-(float)pValue/100);
//        NSLog(@"pValue is %f",pProgressView.progress);
        pProgressView.progressTintColor = [UIColor colorWithRed:(255-pValue) green:0 blue:0 alpha:1];
    } else {
        pProgressView.progress = (float)pValue/100;
    }
    [cell addSubview:pProgressView];

    UIProgressView *iProgressView = [[UIProgressView alloc]initWithFrame:CGRectMake(175, 85, 80, 40)];
    iProgressView.progressViewStyle = UIProgressViewStyleDefault;
    iProgressView.progress = (float)iValue/100;
    if (((float)iValue/100) < 0.0) {
        iProgressView.progress =(-(float)iValue/100);
        iProgressView.progressTintColor = [UIColor colorWithRed:(255-iValue) green:0 blue:0 alpha:1];
    } else {
        iProgressView.progress = (float)iValue/100;
    }
    [cell addSubview:iProgressView];
    
    UIProgressView *mProgressView = [[UIProgressView alloc]initWithFrame:CGRectMake(175, 120, 80, 40)];
    mProgressView.progressViewStyle = UIProgressViewStyleDefault;
    mProgressView.progress = (float)mValue/100;
    if (((float)mValue/100) < 0.0) {
        mProgressView.progress =(-(float)mValue/100);
        mProgressView.progressTintColor = [UIColor colorWithRed:(255-mValue) green:0 blue:0 alpha:1];
    } else {
        mProgressView.progress = (float)mValue/100;
    }
    [cell addSubview:mProgressView];
    
    UILabel *pValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(260, 30, 50, 40)];
    pValueLabel.textAlignment = NSTextAlignmentRight;
    pValueLabel.text = [NSString stringWithFormat:@"%d%%",pValue];
    [cell addSubview:pValueLabel];
    
    UILabel *iValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(260, 65, 50, 40)];
    iValueLabel.textAlignment = NSTextAlignmentRight;
    iValueLabel.text = [NSString stringWithFormat:@"%d%%",iValue];
    [cell addSubview:iValueLabel];
    
    UILabel *mValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(260, 100, 50, 40)];
    mValueLabel.textAlignment = NSTextAlignmentRight;
    mValueLabel.text = [NSString stringWithFormat:@"%d%%",mValue];
    [cell addSubview:mValueLabel];

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self->_userNameArray removeObjectAtIndex:indexPath.row];
        [self->_userAgeArray removeObjectAtIndex:indexPath.row];
        [self deleteAllUserInfo];
//        [self deleteOneUserInfo];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSLog(@"%@",_userNameArray);
        NSLog(@"%@",_userAgeArray);
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
    NSLog(@"%ld indexPath choosed",(long)indexPath.row);
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
