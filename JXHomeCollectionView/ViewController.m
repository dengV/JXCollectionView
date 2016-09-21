//
//  ViewController.m
//  JXHomeCollectionView
//
//  Created by 王加祥 on 16/9/20.
//  Copyright © 2016年 王加祥. All rights reserved.
//

#import "ViewController.h"
#import "JXHeaderView.h"
#import "JXSelectView.h"
#import "JXOneController.h"
#import "JXTwoController.h"

/** 屏幕宽度 */
#define kWidth [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define kHeight [UIScreen mainScreen].bounds.size.height
/** 屏幕尺寸 */
#define kScreen [UIScreen mainScreen].bounds

@interface ViewController ()<JXSelectViewDelegate,UIScrollViewDelegate>
/** 轮播图 */
@property (nonatomic,weak) JXHeaderView * banerView;
/** 内容蓝 */
@property (nonatomic,weak) UIScrollView * contentVc;
/** 头部选项卡以及轮播图背景 */
@property (nonatomic,weak) UIView * headerView;
/** 选项卡 */
@property (nonatomic,weak) JXSelectView * selectView;

/** 是否悬停 */
@property (nonatomic,assign,getter=isStop) BOOL stop;

/** 便宜 */
@property (nonatomic,assign) CGPoint contentSet;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化
    [self setupView];
    
    // 添加控制器
    [self setupAddChilds];
    
    [self setupChildViewIndex:0];
    
    [self.view insertSubview:self.headerView atIndex:MAXFLOAT];
    
    // 用来接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotiFromBase:) name:@"POSTOFFSET" object:nil];
}

#pragma mark - 接收通知
- (void)receiveNotiFromBase:(NSNotification *)noti {
    NSDictionary * dict = noti.userInfo;
    CGFloat y = [dict[@"offSet"] floatValue];
    CGPoint offset = CGPointMake(0, y);
    self.contentSet = offset;
    
    BOOL stop = [dict[@"stop"] boolValue];
    self.stop = stop;
    
}
#pragma mark - 添加控制器
- (void)setupAddChilds {
    // 这里只是添加控制器，实际上控制器上的view并没有添加，因为控制器上的view是懒加载添加
    
    // 添加控制器
    JXOneController * oneController = [[JXOneController alloc] init];
    oneController.headerViewBg = self.headerView;
    oneController.selectViewBg = self.selectView;
    oneController.banerViewBg = self.banerView;
    [self addChildViewController:oneController];
    
    // 添加控制器
    JXTwoController * twoController = [[JXTwoController alloc] init];
    twoController.headerViewBg = self.headerView;
    twoController.selectViewBg = self.selectView;
    twoController.banerViewBg = self.banerView;
    [self addChildViewController:twoController];
    
}

#pragma mark - 初始化
- (void)setupView {
    self.headerView.frame = CGRectMake(0, 0, kWidth, 160);
    self.banerView.frame = CGRectMake(0, 0, kWidth, 120);
    self.selectView.frame = CGRectMake(0, 120, kWidth, 40);
    
}

#pragma mark - 懒加载

- (UIView *)headerView{
    if (_headerView == nil) {
        UIView * headerView = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor grayColor];
        // 添加到窗口上
        [self.view addSubview:headerView];
        _headerView = headerView;
    }
    return _headerView;
}

- (UIView *)banerView{
    if (_banerView == nil) {
        JXHeaderView * banerView = [[JXHeaderView alloc] init];
        // 添加到背景图上
        [self.headerView addSubview:banerView];
        _banerView = banerView;
    }
    return _banerView;
}

- (JXSelectView *)selectView{
    if (_selectView == nil) {
        JXSelectView * selectView= [[JXSelectView alloc] init];
        // 添加到背景图上
        [self.headerView addSubview:selectView];
        selectView.delegate = self;
        _selectView = selectView;
    }
    return _selectView;
}

- (UIScrollView *)contentVc {
    if (_contentVc == nil) {
        UIScrollView * contentScrollView = [[UIScrollView alloc] init];
        contentScrollView.frame = CGRectMake(0, 20, kWidth, kHeight - 20);
        [self.view addSubview:contentScrollView];
        contentScrollView.backgroundColor = [UIColor whiteColor];
        contentScrollView.pagingEnabled = YES;
        contentScrollView.delegate = self;
        _contentVc = contentScrollView;
    }
    return _contentVc;
}

#pragma mark - JXSelectViewDelegate
- (void)selectView:(JXSelectView *)selectView buttonDidSelect:(UIButton *)button {
    [self setupChildViewIndex:button.tag];
}


// 选中视图控制器
- (void)setupChildViewIndex:(NSInteger)index {
    
    for (UIView * subView in self.contentVc.subviews) {
        [subView removeFromSuperview];
    }
    
        if (index == 0) {
            // 当前需要显示的控制器索引
            // 取出当前控制器
            JXOneController * willShowVc = self.childViewControllers[index];
    
            willShowVc.headerViewBg = self.headerView;
            willShowVc.selectViewBg = self.selectView;
            willShowVc.banerViewBg = self.banerView;
            willShowVc.contentSet = self.contentSet;
            willShowVc.stop = self.stop;
            // 计算控制器view的frame
            willShowVc.view.frame = self.contentVc.bounds;
            [self.contentVc addSubview:willShowVc.view];
        } else {
            JXTwoController * willShowVc = self.childViewControllers[index];
    
            willShowVc.headerViewBg = self.headerView;
            willShowVc.selectViewBg = self.selectView;
            willShowVc.banerViewBg = self.banerView;
            willShowVc.contentSet = self.contentSet;
            willShowVc.stop = self.stop;
            // 计算控制器view的frame
            willShowVc.view.frame = self.contentVc.bounds;
            [self.contentVc addSubview:willShowVc.view];
        }
    
    
}

@end
