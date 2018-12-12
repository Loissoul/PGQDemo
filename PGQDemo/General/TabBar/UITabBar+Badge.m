//
//  UITabBar+Badge.m
//  PGQDemo
//
//  Created by Lois_pan on 2017/12/25.
//  Copyright © 2017年 Lois_pan. All rights reserved.
//

#import "UITabBar+Badge.h"
#define TabbarItemNums 5.0

@implementation UITabBar (Badge)

//显示红点
- (void)showBadgeOnItmIndex:(NSInteger)index{
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UIView *bview = [[UIView alloc]init];
    bview.tag = 888+index;
    bview.layer.cornerRadius = 5;
    bview.clipsToBounds = YES;
    bview.backgroundColor = UIColorFromRGB(0xFA6C6C);
    CGRect tabFram = self.frame;
    
    float percentX = (index+0.6)/TabbarItemNums;
    CGFloat x = ceilf(percentX*tabFram.size.width);
    CGFloat y = ceilf(0.1*tabFram.size.height);
    bview.frame = CGRectMake(x+2, y+2, 10, 10);
    [self addSubview:bview];
    [self bringSubviewToFront:bview];
}

//隐藏红点
-(void)hideBadgeOnItemIndex:(NSInteger)index{
    [self removeBadgeOnItemIndex:index];
}
//移除控件
- (void)removeBadgeOnItemIndex:(NSInteger)index{
    for (UIView*subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}

@end
