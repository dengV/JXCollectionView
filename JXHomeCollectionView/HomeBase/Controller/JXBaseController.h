//
//  JXBaseController.h
//  JXHomeCollectionView
//
//  Created by 灏月 on 16/9/21.
//  Copyright © 2016年 灏月. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXBaseController : UIViewController
/** 头部背景 */
@property (nonatomic,weak) UIView * headerViewBg;
/** 选项卡 */
@property (nonatomic,weak) UIView * selectViewBg;
/** 轮播 */
@property (nonatomic,weak) UIView * banerViewBg;

/** 是否悬停 */
@property (nonatomic,assign,getter=isStop) BOOL stop;

/** 便宜 */
@property (nonatomic,assign) CGPoint contentSet;

@end
