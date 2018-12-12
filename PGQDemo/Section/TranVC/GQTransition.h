//
//  GQTransition.h
//  PGQDemo
//
//  Created by Lois_pan on 2018/7/3.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//

#import <Foundation/Foundation.h>

//转场方式
typedef NS_ENUM(NSInteger, GQTransitionType)
{
    GQTransitionTypePresent = 0,
    GQTransitionTypeDismiss,
    GQTransitionTypePush,
    GQTransitionTypePop
};



@interface GQTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) GQTransitionType type;

+ (instancetype)enlargeTransitionWithType:(GQTransitionType)type;

- (instancetype)initWithTransitionType:(GQTransitionType)type;

@end
