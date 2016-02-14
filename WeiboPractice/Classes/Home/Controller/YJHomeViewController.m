//
//  YJHomeViewController.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/1/28.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJBaseNaviController.h"
#import "YJRepostViewController.h"

#import "YJHomeViewController.h"
#import "YJDropDownMenu.h"
#import "YJTitleButton.h"
#import "YJAccountTool.h"
#import "YJUserModel.h"
#import "YJStatusModel.h"
#import "YJStatusFrame.h"
#import "YJStatusCell.h"

#import "YJHttpTool.h"
#import "YJStatusTool.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "MJRefresh.h"

@interface YJHomeViewController ()<YJDropDownMenuDelegate>
/**
 *  带有frame的微博模型
 */
@property (nonatomic, strong) NSMutableArray *statusFrames;

@end

@implementation YJHomeViewController

- (NSMutableArray *)statusFrames {
    if (!_statusFrames) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavi];
    
    [self getUserInfo];
    
    [self setUpRefresh];
    
    [self setUpLoadMore];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(setUpUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = YJ_COLOR(211, 211, 211);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(repostBtnClick:) name:YJRepostButtonDidClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commentBtnClick:) name:YJCommentButtonDidClickNotification object:nil];

}
#pragma mark - 设置导航栏
- (void)setUpNavi {
    UIBarButtonItem *friend = [UIBarButtonItem barItemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highlightedImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.leftBarButtonItem = friend;
    
    UIBarButtonItem *pop = [UIBarButtonItem barItemWithTarget:self action:@selector(popOver) image:@"navigationbar_pop" highlightedImage:@"navigationbar_pop_highlighted"];
    self.navigationItem.rightBarButtonItem = pop;
    
    YJTitleButton *titleBtn = [[YJTitleButton alloc] init];
    NSString *username = [YJAccountTool loadAccount].username;
    [titleBtn setTitle:(username ? username : @"首页") forState:UIControlStateNormal];
    [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleBtn;
}
#pragma mark - 获得用户数据
- (void)getUserInfo {
    
    YJAccountModel *account = [YJAccountTool loadAccount];
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"access_token"] = account.access_token;
    paras[@"uid"] = account.uid;
    
    [YJHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:paras success:^(id responseObject) {
        
        YJUserModel *user = [YJUserModel mj_objectWithKeyValues:responseObject];
        UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
        [titleBtn setTitle:user.name forState:UIControlStateNormal];
        
        account.username = user.name;
        [YJAccountTool saveAccount:account];
        
    } failure:^(NSError *error) {
        NSLog(@"get user info error : %@", error);
    }];
}
#pragma mark - 设置下拉刷新
- (void)setUpRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshStateChange)];
    [self.tableView.mj_header beginRefreshing];
}
/**
 *  下拉刷新时调用
 */
- (void)refreshStateChange {
    
    YJStatusFrame *firstStatusFrame = [self.statusFrames firstObject];
    YJStatusModel *firstStatus = firstStatusFrame.statusModel;
    
    YJAccountModel *account = [YJAccountTool loadAccount];
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"access_token"] = account.access_token;
    if (firstStatus) {
        paras[@"since_id"] = firstStatus.idstr;
    }
    
    //定义一个block处理新数据
    void (^dealingNewResult)(NSArray *) = ^(NSArray *newestStatus){
        NSArray *newest = [YJStatusModel mj_objectArrayWithKeyValuesArray:newestStatus];
        NSMutableArray *newFrames = [self statusFramesWithStatuses:newest];
        
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newFrames atIndexes:indexSet];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self showNewestStatusCount:newest.count];
    };
    
    //先尝试从数据库中加载数据
    NSArray *newest_sb = [YJStatusTool statusesWithParams:paras];
    if (newest_sb.count) {
        dealingNewResult(newest_sb);
    } else {
        [YJHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:paras success:^(id responseObject) {
            
            [YJStatusTool saveStatuses:responseObject[@"statuses"]];
            
            dealingNewResult(responseObject[@"statuses"]);
            
        } failure:^(NSError *error) {
            NSLog(@"refresh status error : %@", error);
            [self.tableView.mj_header endRefreshing];
        }];
    }
}
#pragma mark - 显示新数据数量
- (void)showNewestStatusCount:(NSInteger)count {
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    UILabel *newCountLabel = [[UILabel alloc] init];
    newCountLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    newCountLabel.textColor = [UIColor whiteColor];
    newCountLabel.font = [UIFont systemFontOfSize:16];
    newCountLabel.textAlignment = NSTextAlignmentCenter;
    newCountLabel.width = [UIScreen mainScreen].bounds.size.width;
    newCountLabel.height = 30;
    newCountLabel.y = 34;
    
    if (count) {
        newCountLabel.text = [NSString stringWithFormat:@"获得%ld条新的微博数据", count];
    } else {
        newCountLabel.text = @"暂时没有新的微博数据";
    }
    
    [self.navigationController.view insertSubview:newCountLabel belowSubview:self.navigationController.navigationBar];
    
    CGFloat animationDuration = 0.75;
    [UIView animateWithDuration:animationDuration animations:^{
        newCountLabel.transform = CGAffineTransformMakeTranslation(0, newCountLabel.height);
//        newCountLabel.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:animationDuration delay:animationDuration options:UIViewAnimationOptionCurveLinear animations:^{
            newCountLabel.transform = CGAffineTransformIdentity;
//            newCountLabel.alpha = 0;
        } completion:^(BOOL finished) {
            [newCountLabel removeFromSuperview];
        }];
    }];
}
#pragma mark - 设置上拉加载更多
- (void)setUpLoadMore {
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        YJStatusFrame *lastStatusFrame = [self.statusFrames lastObject];
        YJStatusModel *lastStatus = lastStatusFrame.statusModel;
        
        YJAccountModel *account = [YJAccountTool loadAccount];
        NSMutableDictionary *paras = [NSMutableDictionary dictionary];
        paras[@"access_token"] = account.access_token;
        paras[@"max_id"] = lastStatus.idstr;
        
        //定义一个block处理更多数据
        void (^dealingMoreResult)(NSArray *) = ^(NSArray *moreStatus){
            NSArray *more = [YJStatusModel mj_objectArrayWithKeyValuesArray:moreStatus];
            NSMutableArray *newFrames = [self statusFramesWithStatuses:more];
            
            [self.statusFrames removeLastObject];
            [self.statusFrames addObjectsFromArray:newFrames];
            
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        };
        
        //先尝试从沙盒中读取数据
        NSArray *more_sb = [YJStatusTool statusesWithParams:paras];
        if (more_sb.count) {
            dealingMoreResult(more_sb);
        } else {
            [YJHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:paras success:^(id responseObject) {
                
                [YJStatusTool saveStatuses:responseObject[@"statuses"]];
                
                dealingMoreResult(responseObject[@"statuses"]);
                
            } failure:^(NSError *error) {
                NSLog(@"load more error : %@", error);
            }];
        }
    }];
}
#pragma mark - 获得未读消息数
- (void)setUpUnreadCount {
    
    YJAccountModel *account = [YJAccountTool loadAccount];
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"access_token"] = account.access_token;
    paras[@"uid"] = account.uid;
    
    [YJHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:paras success:^(id responseObject) {
        
        NSInteger unreadCount = [responseObject[@"status"] integerValue];
        if (unreadCount) {
            self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld", unreadCount];
            [UIApplication sharedApplication].applicationIconBadgeNumber = unreadCount;
        }
        
    } failure:^(NSError *error) {
        NSLog(@"set up unread count error : %@", error);
    }];
}
#pragma mark - 将微博模型转换成带有frame的微博模型
- (NSMutableArray *)statusFramesWithStatuses:(NSArray *)statuses {
    NSMutableArray *newFrames = [[NSMutableArray alloc] init];
    for (YJStatusModel *oneStatus in statuses) {
        YJStatusFrame *oneFrame = [[YJStatusFrame alloc] init];
        oneFrame.statusModel = oneStatus;
        [newFrames addObject:oneFrame];
    }
    return newFrames;
}

- (void)repostBtnClick:(NSNotification *)notification {
    YJStatusModel *oneStatus = notification.object;
    
    YJRepostViewController *repost = [[YJRepostViewController alloc] initWithStatusModel:oneStatus];
    YJBaseNaviController *vc = [[YJBaseNaviController alloc] initWithRootViewController:repost];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)commentBtnClick:(NSNotification *)notification {
    NSLog(@"home通知--评论");
}

- (void)friendSearch {
    
}

- (void)titleClick:(UIView *)titleBtn {
    
    YJDropDownMenu *menu = [YJDropDownMenu menu];
    menu.delegate = self;
    UITableView *tableview = [[UITableView alloc] init];
    tableview.height = 200;
    tableview.width = 200;
    menu.contentView = tableview;
    [menu showFrom:titleBtn];
}

- (void)popOver {
    
}

- (void)dropDownMenuDidDisMiss:(YJDropDownMenu *)dropDownMenu {
    UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
    titleBtn.selected = NO;
}

- (void)dropDownMenuDidShow:(YJDropDownMenu *)dropDownMenu {
    UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
    titleBtn.selected = YES;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJStatusCell *cell = [YJStatusCell statusCellWithTableView:tableView];
    
    cell.statusCellFrame = self.statusFrames[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJStatusFrame *oneFrame = self.statusFrames[indexPath.row];
    return oneFrame.cellHeight;
}

@end
