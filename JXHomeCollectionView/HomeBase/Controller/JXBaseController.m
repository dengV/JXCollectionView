//
//  JXBaseController.m
//  JXHomeCollectionView
//
//  Created by 灏月 on 16/9/21.
//  Copyright © 2016年 灏月. All rights reserved.
//

#import "JXBaseController.h"
/** 屏幕宽度 */
#define kWidth [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define kHeight [UIScreen mainScreen].bounds.size.height
/** 屏幕尺寸 */
#define kScreen [UIScreen mainScreen].bounds


// 重用表格标识
static NSString * const reuseIdentifier = @"Cell";
// 重用表格标识
static NSString * const reuseIdentifierRight = @"CellRight";
// 重用头部标识
static NSString * const reuseHeaderIdentifier = @"reusableView";

@interface JXBaseController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/** collectionView */
@property (nonatomic,weak) UICollectionView * collectionView;


@end

@implementation JXBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.headerViewBg addSubview:self.banerViewBg];
    [self.headerViewBg addSubview:self.selectViewBg];
    [self.collectionView addSubview:self.headerViewBg];
    
    [self.collectionView setContentOffset:self.contentSet];
    if (self.stop) { // 当已经是悬停效果之后设置
        // 取出frame，将之y坐标设置为0
        CGRect hoverRect = self.selectViewBg.frame;
        hoverRect.origin.y = 0;
        self.selectViewBg.frame = hoverRect;
        [self.view addSubview:self.selectViewBg];
        
    } else {
        CGRect hoverRect = self.headerViewBg.frame;
        hoverRect.origin.y = CGRectGetMaxY(self.headerViewBg.frame) - 40;
        hoverRect.size.height = 40;
        self.selectViewBg.frame = hoverRect;
        [self.collectionView addSubview:self.selectViewBg];
    }
}



#pragma mark - 初始化
- (void)setupView {
    
    // 提前注册cell
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:reuseIdentifier];
    
    // 注册headerView
    [self.collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:reuseHeaderIdentifier];
    
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    
}



#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    return 33;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    CGFloat r = arc4random_uniform(256) / 255.0 ;
    CGFloat g = arc4random_uniform(256) / 255.0 ;
    CGFloat b = arc4random_uniform(256) / 255.0 ;
    
    cell.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    return cell;
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                               withReuseIdentifier:reuseHeaderIdentifier
                                                                                      forIndexPath:indexPath];
    
    return headerView;
}



- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat w = ([UIScreen mainScreen].bounds.size.width - 20) / 2;
    return CGSizeMake(w, 100);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 170);
}


#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    self.contentSet = self.collectionView.contentOffset;
    
    // 监听scrollView的滚动，当滚动偏移量大于headView的高度的时候悬停scrollView(将之父控件设置为控制器view即可)
    if (scrollView.contentOffset.y >= self.headerViewBg.frame.size.height - 40) { // 当到达顶部的时候设置悬停
        // 取出frame，将之y坐标设置为0
        CGRect hoverRect = self.selectViewBg.frame;
        hoverRect.origin.y = 0;
        self.selectViewBg.frame = hoverRect;
        [self.view addSubview:self.selectViewBg];
        self.stop = YES;

    } else { // 如果没有达到悬停位置，父控件就设置为headView
        // 取出frame，将之y坐标设置为0
        CGRect hoverRect = self.headerViewBg.frame;
        hoverRect.origin.y = CGRectGetMaxY(self.headerViewBg.frame) - 40;
        hoverRect.size.height = 40;
        self.selectViewBg.frame = hoverRect;
        [self.collectionView addSubview:self.selectViewBg];
        self.stop = NO;
    }
    
    // 发送通知，用来记录当前移动位置，
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"offSet"] = @(self.contentSet.y);
    dict[@"stop"] = @(self.stop);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"POSTOFFSET" object:nil userInfo:dict];

}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.collectionView reloadData];
}
#pragma mark - 懒加载
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.estimatedItemSize = CGSizeMake(10, 10);
        flowLayout.minimumLineSpacing = 5;
        flowLayout.minimumInteritemSpacing = 10;
        
        CGFloat w = [UIScreen mainScreen].bounds.size.width;
        CGFloat h = [UIScreen mainScreen].bounds.size.height;
        CGRect rect = CGRectMake(0, 0, w, h);
        UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}

@end
