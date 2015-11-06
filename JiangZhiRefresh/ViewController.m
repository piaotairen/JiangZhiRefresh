//
//  ViewController.m
//  JiangZhiRefresh
//
//  Created by Cobb on 15/10/15.
//  Copyright © 2015年 Hu Zhiyuan. All rights reserved.
//

#import "ViewController.h"

// 自定义的header
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"

static const CGFloat MJDuration = 2.0;//刷新的时间

@interface ViewController () <UITableViewDataSource,UITableViewDataSource>
{
    __weak IBOutlet UITableView *myTable;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    myTable.backgroundColor = [UIColor colorWithRed:235.0f/255.0f green:235.0f/255.0f blue:235.0f/255.0f alpha:1];
    
    [self example04];
    
    [self example13];
}

#pragma mark UITableView + 下拉刷新 隐藏状态和时间
- (void)example04
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJChiBaoZiHeader *header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置header
    myTable.header = header;
}

#pragma mark UITableView + 上拉刷新 隐藏刷新状态的文字
- (void)example13
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJChiBaoZiFooter *footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    //当上拉刷新控件出现50%时（出现一半），就会自动刷新。这个值默认是1.0（也就是上拉刷新100%出现时，才会自动刷新）
    footer.triggerAutomaticallyRefreshPercent = 0.5;
    
    // 隐藏刷新状态的文字
    footer.refreshingTitleHidden = YES;
    
    // 设置footer
    myTable.footer = footer;
}

#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [myTable reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [myTable.header endRefreshing];
    });
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData
{
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [myTable reloadData];
        
        // 拿到当前的上拉刷新控件，结束刷新状态
        [myTable.footer endRefreshing];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *myCell = [myTable dequeueReusableCellWithIdentifier:@"myCell"];
    
    if (myCell == nil) {
        myCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    
    myCell.textLabel.text = [NSString stringWithFormat:@"this is test demo %lu",indexPath.row];
    
    return myCell;
}
@end
