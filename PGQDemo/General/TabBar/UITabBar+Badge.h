//
//  UITabBar+Badge.h
//  PGQDemo
//
//  Created by Lois_pan on 2017/12/25.
//  Copyright © 2017年 Lois_pan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Badge)
- (void)showBadgeOnItmIndex:(NSInteger)index;

- (void)hideBadgeOnItemIndex:(NSInteger)index;

@end
