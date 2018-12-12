//
//  UIViewController+HUD.m
//  PGQDemo
//
//  Created by Lois_pan on 2017/12/28.
//  Copyright © 2017年 Lois_pan. All rights reserved.
//

#import "UIViewController+HUD.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;

@implementation UIViewController (HUD)

- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    for ( UIView * mb  in  view.subviews ) {
        if([mb isKindOfClass:[MBProgressHUD class]]){
            [mb removeFromSuperview];
        }
    }
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    [self setHUD:HUD];
    HUD.label.text = hint;
}

- (void)showHint:(NSString *)hint {
    UIView *view = [[UIApplication sharedApplication].delegate window];
    
    for (UIView * huded in view.subviews) {
        if ([huded isKindOfClass:[MBProgressHUD class]]) {
            [huded removeFromSuperview];
        }
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.margin = 10.f;
    [hud setOffset:CGPointMake(0, 180)];
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}

-(void)showHint:(NSString *)hint inView:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.margin = 10.f;
    [hud setOffset:CGPointMake(0, CGRectGetMidY(view.frame)/2.0)];
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}
-(void)showProgressImageViewInView:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    NSArray *arr = @[[UIImage imageNamed:@"01"],
                     [UIImage imageNamed:@"02"],
                     [UIImage imageNamed:@"03"],
                     [UIImage imageNamed:@"04"],
                     [UIImage imageNamed:@"05"],
                     [UIImage imageNamed:@"06"],
                     [UIImage imageNamed:@"07"],
                     [UIImage imageNamed:@"08"],
                     [UIImage imageNamed:@"09"],
                     [UIImage imageNamed:@"10"],
                     [UIImage imageNamed:@"11"],
                     [UIImage imageNamed:@"12"]];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    imageV.animationImages = arr;
    imageV.animationDuration = 2;
    [imageV startAnimating];
    hud.customView = imageV;
    hud.square = YES;
    hud.bezelView.color = [UIColor clearColor];
    [self setHUD:hud];//有了这一句可以保证[self hideHUD];正常执行
    
}
- (void)showHint:(NSString *)hint yOffset:(float)yOffset
{
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.margin = 10.f;
    [hud setOffset:CGPointMake(0, CGRectGetMidY(view.frame)/2.0+yOffset)];
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}

- (void)hideHud{
    [[self HUD] hideAnimated:YES];
}

- (void)ShowNoDataViewWithStr:(NSString *) ShowStr yOffset:(float)yOffset{
    UIView * showViews =[self.view viewWithTag:101];
    [showViews removeFromSuperview];
    
    UIView * ShowView =[[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 50,0,100 , 60)];
    ShowView.tag = 101;
    ShowView.center = CGPointMake(kScreenWidth/2 - 50, self.view.center.y/2  + yOffset);
    ShowView.backgroundColor =[UIColor clearColor];
    
    UIImageView * ima =[[UIImageView alloc]initWithFrame:CGRectMake(35, 0, 30, 30)];
    ima.image =[UIImage imageNamed:@"wjl"];
    [ShowView addSubview:ima];
    
    
    UILabel  * showLabel =[[UILabel alloc]initWithFrame:CGRectMake(0,40 , 100 , 20)];
    showLabel.text = ShowStr ;
    showLabel.textAlignment = NSTextAlignmentCenter;
    showLabel.font =  [UIFont systemFontOfSize:14];
    showLabel.textColor =  [UIColor lightGrayColor];
    [ShowView addSubview:showLabel];
    
    //    UIView *view = [[UIApplication sharedApplication].delegate window];
    [ self.view addSubview:ShowView];
    
}
-(void)hintNodataView{
    UIView * showView =[self.view viewWithTag:101];
    [showView removeFromSuperview];
    
}
-(void)showBlackView{
    UIView *blackV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    blackV.tag = 1000;
    blackV.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:blackV];
}
-(void)hideBlackView{
    UIView *view = (UIView *)[[UIApplication sharedApplication].keyWindow viewWithTag:1000];
    [view removeFromSuperview];
}
@end
