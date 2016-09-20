//
//  UIView+JXExtension.h
//  JXWeiBo
//
//  Created by 王加祥 on 16/6/16.
//  Copyright © 2016年 Wangjiaxiang. All rights reserved.
//  分类，快速设置尺寸

#import <UIKit/UIKit.h>

@interface UIView (JXExtension)
/** x值 */
@property (nonatomic,assign) CGFloat x;
/** y值 */
@property (nonatomic,assign) CGFloat y;
/** 宽度 */
@property (nonatomic,assign) CGFloat w;
/** 高度 */
@property (nonatomic,assign) CGFloat h;
/** 大小size */
@property (nonatomic,assign) CGSize size;
/** 中心点Y值 */
@property (nonatomic,assign) CGFloat centerY;
/** 中心点X值 */
@property (nonatomic,assign) CGFloat centerX;
@end
