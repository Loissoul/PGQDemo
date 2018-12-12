//
//  UIViewController+UIKitMainThreadGuard.m
//  PGQDemo
//
//  Created by Lois_pan on 2018/1/15.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//

//检测UI绘制是否在主线程

#import "UIViewController+UIKitMainThreadGuard.h"
#import "GQHookUtilis.h"

@implementation UIViewController (UIKitMainThreadGuard)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        SEL needLayoutOriginalSelector = @selector(setNeedsLayout);
        SEL needLayoutSwizzleSelector = @selector(guard_setNeedsLayout);
        
        [GQHookUtilis swizzlingInClass:self originalSelector:needLayoutOriginalSelector swizzledSelector:needLayoutSwizzleSelector];
        
        SEL needDisplayOriginalSelector = @selector(setNeedsDisplay);
        SEL needDisplaySwizzleSelector = @selector(guard_setNeedsDisplay);
        
        [GQHookUtilis swizzlingInClass:self originalSelector:needDisplayOriginalSelector swizzledSelector:needDisplaySwizzleSelector];
        
        SEL needDisplayInRectOriginalSelector = @selector(setNeedsDisplayInRect:);
        SEL needDisplayInRectSwizzleSelector = @selector(guard_setNeedsDisplayInRect:);
        [GQHookUtilis swizzlingInClass:self originalSelector:needDisplayInRectOriginalSelector swizzledSelector:needDisplayInRectSwizzleSelector];
    });
}

- (void)guard_setNeedsLayout {
    [self UIMainThreadCheck];
    [self guard_setNeedsLayout];
}

- (void)guard_setNeedsDisplay {
    [self UIMainThreadCheck];
    [self guard_setNeedsDisplay];
}

- (void)guard_setNeedsDisplayInRect:(CGRect)rect {
    [self UIMainThreadCheck];
    [self guard_setNeedsDisplayInRect:rect];
}

- (void)UIMainThreadCheck {
    NSString * desc = [NSString stringWithFormat:@"%@", self.class];
    NSAssert([NSThread isMainThread], desc);
}
@end
