//
//  ViewController.m
//  JXHomeCollectionView
//
//  Created by 王加祥 on 16/9/20.
//  Copyright © 2016年 王加祥. All rights reserved.
//

#import "ViewController.h"
#import "UIView+JXExtension.h"

// 重用表格标识
static NSString * const reuseIdentifier = @"Cell";
// 重用表格标识
static NSString * const reuseIdentifierRight = @"CellRight";
// 重用头部标识
static NSString * const reuseHeaderIdentifier = @"reusableView";

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/** collectionView */
@property (nonatomic,weak) UICollectionView * collectionView;
/** 选项卡 */
@property (nonatomic,weak) UIView * scrollView;
/** 选项卡头部视图 */
@property (nonatomic,weak) UIView * headView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 提前注册cell
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:reuseIdentifier];
    
    
    // 注册headerView
    [self.collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:reuseHeaderIdentifier];
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    self.scrollView.frame = CGRectMake(0, 120, w, 40);
    
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    return 15;
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
    CGFloat x = headerView.bounds.origin.x;
    CGFloat y = headerView.bounds.origin.y ;
    CGFloat w = headerView.bounds.size.width;
    CGFloat h = headerView.bounds.size.height - 10;
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor cyanColor];
    view.frame = CGRectMake(x, y, w, h);
    [headerView addSubview:view];
    self.headView = view;
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
    
    // 监听scrollView的滚动，当滚动偏移量大于headView的高度的时候悬停scrollView(将之父控件设置为控制器view即可)
    if (scrollView.contentOffset.y >= self.headView.frame.size.height - 50) { // 当到达顶部的时候设置悬停
        // 取出frame，将之y坐标设置为0
        CGRect hoverRect = self.scrollView.frame;
        hoverRect.origin.y = 20;
        self.scrollView.frame = hoverRect;
        [self.view addSubview:self.scrollView];
        
    } else { // 如果没有达到悬停位置，父控件就设置为headView
        // 取出frame，将之y坐标设置为0
        CGRect hoverRect = self.scrollView.frame;
        NSLog(@"%@",NSStringFromCGRect(self.scrollView.frame));
        hoverRect.origin.y = CGRectGetMaxY(self.headView.frame) - 40;
        self.scrollView.frame = hoverRect;
        [self.headView addSubview:self.scrollView];
    }
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
        CGRect rect = CGRectMake(0, 20, w, h);
        UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (UIView *)scrollView{
    if (_scrollView == nil) {
        // 下面选项框
        UIView * scrollView = [[UIView alloc] init];
        scrollView.backgroundColor = [UIColor lightGrayColor];
        [self.collectionView addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}
@end
