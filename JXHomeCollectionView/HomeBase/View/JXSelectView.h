//
//  JXSelectView.h
//  JXHomeCollectionView
//
//  Created by 灏月 on 16/9/21.
//  Copyright © 2016年 灏月. All rights reserved.
//  选项卡

#import <UIKit/UIKit.h>

@class JXSelectView;
@protocol JXSelectViewDelegate <NSObject>

@optional
- (void)selectView:(JXSelectView *)selectView buttonDidSelect:(UIButton *)button;

@end

@interface JXSelectView : UIView
/** 代理 */
@property (nonatomic,weak) id<JXSelectViewDelegate> delegate;
@end
