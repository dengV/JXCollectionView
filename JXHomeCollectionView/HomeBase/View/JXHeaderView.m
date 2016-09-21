//
//  JXHeaderView.m
//  JXHomeCollectionView
//
//  Created by 灏月 on 16/9/21.
//  Copyright © 2016年 灏月. All rights reserved.
//

#import "JXHeaderView.h"

@implementation JXHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    
    UILabel * label = [[UILabel alloc] init];
    label.text = @"我是模拟轮播图，但是我不能动";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:20];
    label.frame = self.bounds;
    [label drawRect:self.bounds];
}
@end
