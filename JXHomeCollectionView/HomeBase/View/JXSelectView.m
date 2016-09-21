//
//  JXSelectView.m
//  JXHomeCollectionView
//
//  Created by 灏月 on 16/9/21.
//  Copyright © 2016年 灏月. All rights reserved.
//

#import "JXSelectView.h"
#import "UIView+JXExtension.h"
@interface JXSelectView ()
/** 选项卡一 */
@property (nonatomic,weak) UIButton * selectOne;
/** 选项卡二 */
@property (nonatomic,weak) UIButton * selectTwo;
@end

@implementation JXSelectView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    // 按钮一
    self.selectOne.h = self.h;
    self.selectOne.frame = CGRectMake(0, 0, self.selectOne.w, self.selectOne.h);
    
    // 按钮二
    self.selectTwo.h = self.h;
    self.selectTwo.frame = CGRectMake(self.w - self.selectTwo.w, 0, self.selectTwo.w , self.selectTwo.h);
}

- (void)drawRect:(CGRect)rect {
    
    UILabel * label = [[UILabel alloc] init];
    label.text = @"我是选项卡，但是我不能选";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:20];
    label.frame = self.bounds;
    [label drawRect:self.bounds];
}

#pragma mark - 懒加载
- (UIButton *)selectOne{
    if (_selectOne == nil) {
        UIButton * selectOne = [UIButton buttonWithType:UIButtonTypeCustom];
        selectOne.backgroundColor = [UIColor cyanColor];
        selectOne.tag = 0;
        [selectOne setTitle:@"按钮一" forState:UIControlStateNormal];
        [selectOne addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [selectOne sizeToFit];
        selectOne.w += 30;
        [self addSubview:selectOne];
        _selectOne = selectOne;
    }
    return _selectOne;
}


- (UIButton *)selectTwo{
    if (_selectTwo == nil) {
        UIButton * selectTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        selectTwo.backgroundColor = [UIColor cyanColor];
        selectTwo.tag = 1;
        [selectTwo setTitle:@"按钮二" forState:UIControlStateNormal];
        [selectTwo addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [selectTwo sizeToFit];
        selectTwo.w += 30;
        [self addSubview:selectTwo];
        _selectTwo = selectTwo;
    }
    return _selectTwo;
}

#pragma mark - 点击事件
- (void)btnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(selectView:buttonDidSelect:)]) {
        [self.delegate selectView:self buttonDidSelect:sender];
    }
}
@end
