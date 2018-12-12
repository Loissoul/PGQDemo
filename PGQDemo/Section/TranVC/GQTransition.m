//
//  GQTransition.m
//  PGQDemo
//
//  Created by Lois_pan on 2018/7/3.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//

#import "GQTransition.h"

@implementation GQTransition

+ (instancetype)enlargeTransitionWithType:(GQTransitionType)type {
    return [[GQTransition alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(GQTransitionType)type {
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    switch (self.type) {
        case GQTransitionTypePresent:
            [self presentTransition:transitionContext];
            break;
            
        case GQTransitionTypeDismiss:
            [self dismissTransition:transitionContext];
            break;
        default:
            break;
    }
}

- (void)presentTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    fromVC.view.hidden = YES;
    
    UIView *coverView = [[UIView alloc] init];
    coverView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 0;
    
    toVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    toVC.view.alpha = 0;
    
    UIView *containerVier = [transitionContext containerView];
    [containerVier addSubview:tempView];
    [containerVier addSubview:coverView];
    [containerVier addSubview:toVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        coverView.alpha = 0.4;
        toVC.view.alpha = 1;
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        
    }];
    
}

- (void)dismissTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerVier = [transitionContext containerView];
    
    UIView *tempView = containerVier.subviews[0];
    tempView.hidden = NO;
    
    UIView *coverView = containerVier.subviews[1];
    coverView.hidden = NO;
    toVC.view.hidden = YES;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        coverView.alpha = 0;
        fromVC.view.alpha = 0;
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        
        toVC.view.hidden = NO;
        
        coverView.hidden = YES;
        [coverView removeFromSuperview];
        
        tempView.hidden = YES;
        [tempView removeFromSuperview];
        
    }];
}



@end
