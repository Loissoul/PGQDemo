//
//  GQTabBarViewController.m
//  PGQDemo
//
//  Created by Lois_pan on 2017/12/25.
//  Copyright © 2017年 Lois_pan. All rights reserved.
//

#import "GQTabBarViewController.h"
#import "OtherFunctionListViewController.h"
#import "AnimationListViewController.h"
#import "BaseNavigationViewController.h"

@interface GQTabBarViewController () {
    OtherFunctionListViewController * _otherListVC;
    AnimationListViewController     * _animationListVC;
}

@end

@implementation GQTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)setUp {
    _animationListVC = [[AnimationListViewController alloc] init];
    _otherListVC = [[OtherFunctionListViewController alloc] init];
    BaseNavigationViewController * animationNav =
    [[BaseNavigationViewController alloc] initWithRootViewController: _animationListVC];
    
    BaseNavigationViewController * otherNav =
    [[BaseNavigationViewController alloc] initWithRootViewController: _otherListVC];
    
    animationNav.tabBarItem =
    [self tabBarItemWithImageName:@""
           selectedImageImageName:@"" title: @"动画"];
    
    otherNav.tabBarItem =
    [self tabBarItemWithImageName:@""
           selectedImageImageName:@"" title: @"其他"];

    [self setViewControllers:@[animationNav, otherNav]];
}

- (UITabBarItem *)tabBarItemWithImageName:(NSString *)imageName selectedImageImageName:(NSString *)selectedImageName title:(NSString *)title {
    UIImage * image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage * selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem * item = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectedImage];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: UIColorFromRGB(0x00BCD3), NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    //    item.imageInsets = UIEdgeInsetsMake(4.5, 0, -4.5, 0);
    //    item.titlePositionAdjustment = UIOffsetMake(0, MAXFLOAT);
    return item;
}


@end
