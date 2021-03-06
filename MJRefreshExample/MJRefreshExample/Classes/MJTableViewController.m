//
//  MJTableViewController.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MJTableViewController.h"
#import "MJRefresh.h"
#import "UIView+MJExtension.h"
#import "MJTestViewController.h"

static const CGFloat MJDuration = 2.0;
/**
 * 随机数据
 */
#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]

@interface MJTableViewController()
/** 用来显示的假数据 */
@property (strong, nonatomic) NSMutableArray *data;
@end

@implementation MJTableViewController
#pragma mark - 示例代码
/**
 * UITableView + 下拉刷新 传统
 */
- (void)example01
{
    __weak typeof(self) weakSelf = self;
    
    // 添加传统的下拉刷新
    [self.tableView addLegendHeader];
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.legendHeader.refreshingBlock = ^{
        [weakSelf loadNewData];
    };
    
    // 马上进入刷新状态
    [self.tableView.legendHeader beginRefreshing];
    
    /**
     也可以这样使用
     self.tableView.header.refreshingBlock = ^{
     
     };
     [self.tableView.header beginRefreshing];
     
     此时self.tableView.header == self.tableView.legendHeader
     */
}

/**
 * UITableView + 下拉刷新 动画图片
 */
- (void)example02
{
    // 添加动画图片的下拉刷新
    [self.tableView addGifHeader];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    [self.tableView.gifHeader setRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [self.tableView.gifHeader setImages:idleImages forState:MJRefreshHeaderStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self.tableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self.tableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStateRefreshing];
    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    
    // 马上进入刷新状态
    [self.tableView.gifHeader beginRefreshing];
    
    // 此时self.tableView.header == self.tableView.gifHeader
}

/**
 * UITableView + 下拉刷新 隐藏时间
 */
- (void)example03
{
    // 添加传统的下拉刷新
    [self.tableView addLegendHeader];
    
    // 隐藏时间
    self.tableView.header.updatedTimeHidden = YES;
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    [self.tableView.header setRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
    
    // 此时self.tableView.header == self.tableView.legendHeader
}

/**
 * UITableView + 下拉刷新 隐藏状态和时间01
 */
- (void)example04
{
    // 添加动画图片的下拉刷新
    [self.tableView addGifHeader];
    
    // 隐藏时间
    self.tableView.header.updatedTimeHidden = YES;
    
    // 隐藏状态
    self.tableView.header.stateHidden = YES;
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    [self.tableView.header setRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 0; i<=72; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"PullToRefresh_%03zd", i]];
        [idleImages addObject:image];
    }
    [self.tableView.gifHeader setImages:idleImages forState:MJRefreshHeaderStateIdle];
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 73; i<=140; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"PullToRefresh_%03zd", i]];
        [refreshingImages addObject:image];
    }
    [self.tableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStateRefreshing];
    
    // 在这个例子中，即将刷新时没有动画图片
    
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
    
    // 此时self.tableView.header == self.tableView.gifHeader
    
    // 由于动画图片是黑色的，所以故意设置tableView底色为黑色
    self.tableView.backgroundColor = [UIColor blackColor];
}

/**
 * UITableView + 下拉刷新 隐藏状态和时间02
 */
- (void)example05
{
    // 添加动画图片的下拉刷新
    [self.tableView addGifHeader];
    
    // 隐藏时间
    self.tableView.header.updatedTimeHidden = YES;
    
    // 隐藏状态
    self.tableView.header.stateHidden = YES;
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    [self.tableView.header setRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [self.tableView.gifHeader setImages:idleImages forState:MJRefreshHeaderStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self.tableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self.tableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStateRefreshing];
    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
    
    // 此时self.tableView.header == self.tableView.gifHeader
}

/**
 * UITableView + 下拉刷新 自定义文字
 */
- (void)example06
{
    // 添加传统的下拉刷新
    [self.tableView addLegendHeader];
    
    // 设置文字
    [self.tableView.header setTitle:@"下拉can刷新噻" forState:MJRefreshHeaderStateIdle];
    [self.tableView.header setTitle:@"一放手马上刷新咯" forState:MJRefreshHeaderStatePulling];
    [self.tableView.header setTitle:@"MJ哥正在帮你刷新..." forState:MJRefreshHeaderStateRefreshing];
    
    // 设置字体
    self.tableView.header.font = [UIFont systemFontOfSize:15];
    
    // 设置颜色
    self.tableView.header.textColor = [UIColor redColor];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    [self.tableView.header setRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
    
    // 此时self.tableView.header == self.tableView.legendHeader
}

/**
 * UITableView + 上拉刷新 传统
 */
- (void)example11
{
    __weak typeof(self) weakSelf = self;
    
    // 添加传统的上拉刷新
    [self.tableView addLegendFooter];
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.legendFooter.refreshingBlock = ^{
        [weakSelf loadMoreData];
    };
    
    /**
     也可以这样使用
     self.tableView.footer.refreshingBlock = ^{
     
     };
     [self.tableView.footer beginRefreshing];
     
     此时self.tableView.footer == self.tableView.legendFooter
     */
}

/**
 * UITableView + 上拉刷新 动画图片
 */
- (void)example12
{
    // 添加动画图片的上拉刷新
    [self.tableView addGifFooter];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    [self.tableView.footer setRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    self.tableView.gifFooter.refreshingImages = refreshingImages;
    
    // 此时self.tableView.footer == self.tableView.gifFooter
}

/**
 * UITableView + 上拉刷新 隐藏状态01
 */
- (void)example13
{
    // 添加动画图片的上拉刷新
    [self.tableView addGifFooter];
    
    // 当上拉刷新控件出现50%时（出现一半），就会自动刷新。这个值默认是1.0（也就是上拉刷新100%出现时，才会自动刷新）
//    self.tableView.footer.appearencePercentTriggerAutoRefresh = 0.5;
    
    // 隐藏状态
    self.tableView.footer.stateHidden = YES;
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    [self.tableView.footer setRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 73; i<=140; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"PullToRefresh_%03zd", i]];
        [refreshingImages addObject:image];
    }
    self.tableView.gifFooter.refreshingImages = refreshingImages;
    
    // 此时self.tableView.footer == self.tableView.gifFooter
    
    // 由于动画图片是黑色的，所以故意设置tableView底色为黑色
    self.tableView.backgroundColor = [UIColor blackColor];
}

/**
 * UITableView + 上拉刷新 隐藏状态02
 */
- (void)example14
{
    // 添加动画图片的上拉刷新
    [self.tableView addGifFooter];
    
    // 隐藏状态
    self.tableView.footer.stateHidden = YES;
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    [self.tableView.footer setRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    self.tableView.gifFooter.refreshingImages = refreshingImages;
    
    // 此时self.tableView.footer == self.tableView.gifFooter
}

/**
 * UITableView + 上拉刷新 全部加载完毕
 */
- (void)example15
{
    // 添加传统的上拉刷新
    [self.tableView addLegendFooter];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadLastData方法）
    [self.tableView.footer setRefreshingTarget:self refreshingAction:@selector(loadLastData)];
    
    // 此时self.tableView.footer == self.tableView.legendFooter
    
    // 其他
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"恢复数据加载" style:UIBarButtonItemStyleDone target:self action:@selector(recover)];
}

- (void)recover
{
    [self.tableView.footer setRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    [self.tableView.footer beginRefreshing];
    self.tableView.footer.state = MJRefreshFooterStateIdle;
    
    // 此时self.tableView.footer == self.tableView.legendFooter
}

/**
 * UITableView + 上拉刷新 禁止自动加载
 */
- (void)example16
{
    // 添加传统的上拉刷新
    [self.tableView addLegendFooter];
    
    // 禁止自动加载
    self.tableView.footer.automaticallyRefresh = NO;
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    [self.tableView.footer setRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 此时self.tableView.footer == self.tableView.legendFooter
}

/**
 * UITableView + 上拉刷新 自定义文字
 */
- (void)example17
{
    // 添加传统的上拉刷新
    [self.tableView addLegendFooter];
    
    // 设置文字
    [self.tableView.footer setTitle:@"轻点或者轻拽可加载更多" forState:MJRefreshFooterStateIdle];
    [self.tableView.footer setTitle:@"MJ哥正在帮你加载..." forState:MJRefreshFooterStateRefreshing];
    [self.tableView.footer setTitle:@"没有再多的数据了" forState:MJRefreshFooterStateNoMoreData];
    
    // 设置字体
    self.tableView.footer.font = [UIFont systemFontOfSize:17];
    
    // 设置颜色
    self.tableView.footer.textColor = [UIColor blueColor];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    [self.tableView.footer setRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 此时self.tableView.footer == self.tableView.legendFooter
}

/**
 * UITableView + 上拉刷新 加载后隐藏
 */
- (void)example18
{
    // 添加传统的上拉刷新
    [self.tableView addLegendFooter];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadOnceData方法）
    [self.tableView.footer setRefreshingTarget:self refreshingAction:@selector(loadOnceData)];
    
    // 此时self.tableView.footer == self.tableView.legendFooter
}

#pragma mark - 数据处理相关
/**
 * 下拉刷新数据
 */
- (void)loadNewData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.data insertObject:MJRandomData atIndex:0];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.header endRefreshing];
    });
}

/**
 * 上拉加载更多数据
 */
- (void)loadMoreData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.data addObject:MJRandomData];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 拿到当前的上拉刷新控件，结束刷新状态
        [self.tableView.footer endRefreshing];
    });
}

/**
 * 加载最后一份数据
 */
- (void)loadLastData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.data addObject:MJRandomData];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 拿到当前的上拉刷新控件，变为没有更多数据的状态
        [self.tableView.footer noticeNoMoreData];
    });
}

/**
 * 只加载一次数据
 */
- (void)loadOnceData
{
    // 1.添加假数据
    for (int i = 0; i<25; i++) {
        [self.data addObject:MJRandomData];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 隐藏当前的上拉刷新控件
        self.tableView.footer.hidden = YES;
    });
}

- (NSMutableArray *)data
{
    if (!_data) {
        self.data = [NSMutableArray array];
    }
    return _data;
}

#pragma mark - 其他
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self performSelector:NSSelectorFromString(self.method) withObject:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.data[indexPath.row];;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MJTestViewController *test = [[MJTestViewController alloc] init];
    if (indexPath.row % 2) {
        [self.navigationController pushViewController:test animated:YES];
    } else {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:test];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

- (void)dealloc
{
    MJLog(@"%@销毁了", [self class]);
}

@end
