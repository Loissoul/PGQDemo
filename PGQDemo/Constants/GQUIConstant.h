//
//  GQUIConstant.h
//  PGQDemo
//
//  Created by Lois_pan on 2017/12/25.
//  Copyright © 2017年 Lois_pan. All rights reserved.
//

#ifndef GQUIConstant_h
#define GQUIConstant_h

//MARK: - iOS11 - iphoneX
#define wd_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define wd_iOS11 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11 ? YES : NO)
#define wd_iOS10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10 ? YES : NO)
#define wd_iOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9 ? YES : NO)


//MARK: - 屏幕尺寸
#define kScreenWidth            [UIScreen mainScreen].bounds.size.width
#define kScreenHeight           [UIScreen mainScreen].bounds.size.height
#define kScreenBounds           [UIScreen mainScreen].bounds
#define kFitWidthScale          kScreenWidth/375.0
#define kFitHeightScale         (wd_iPhoneX ? 736 : kScreenHeight)/667.0


#define kTableViewDefaultFrame     CGRectMake(0, \
0,\
kScreenWidth, \
kScreenHeight - kNavigationBarHeight) \
//MARK: -
#define kUserDefaults           [NSUserDefaults standardUserDefaults]
#define kApplication            [UIApplication sharedApplication]
#define kNotificationCenter     [NSNotificationCenter defaultCenter]
#define kNavigationBarHeight  (wd_iPhoneX ? 88 : 64)
#define kTabBarHeight         (wd_iPhoneX ? 64 : 44)

#endif /* GQUIConstant_h */
