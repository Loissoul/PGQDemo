//
//  TimerProxyViewController.m
//  PGQDemo
//
//  Created by Lois_pan on 2018/8/22.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//

#import "TimerProxyViewController.h"
#import <objc/runtime.h>
#import "GQProxy.h"

@interface TimerProxyViewController ()

@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, strong) id timerTarget;

@property (nonatomic, strong) GQProxy * gqProxy;


@end

static const void * timerKey = @"Timerkey";
static const void * weakKey = @"weakKey";

@implementation TimerProxyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self solveTimerWithProxy];
}

//
- (void)solveTimerWithProxy {
    self.gqProxy = [GQProxy alloc];
    self.gqProxy.obj = self;
    self.timer = [NSTimer timerWithTimeInterval:1 target:self.gqProxy selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}


//思路很简单，初始化NSTimer时把触发事件的target替换成一个单独的对象，然后这个对象中NSTimer的SEL方法触发时让这个方法在当前的视图self中实现。
//利用RunTime在target对象中动态的创建SEL方法，然后target对象关联当前的视图self，当target对象执行SEL方法时，取出关联对象self，然后让self执行该方法。

- (void)solveTimerWithRuntime {
    
    _timerTarget = [NSObject new];
    class_addMethod([_timerTarget class], @selector(timerEvent), (IMP)timeMethod, "v@:");
    
    self.timer = [NSTimer timerWithTimeInterval:1 target:_timerTarget selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

    objc_setAssociatedObject(_timerTarget, timerKey, self.timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(_timerTarget, weakKey, self, OBJC_ASSOCIATION_ASSIGN);
    //将self对象与NSTimer对象与_timerTarget对象关联

}

void timeMethod(id self, SEL _cmd) {
    TimerProxyViewController *vc = objc_getAssociatedObject(self, weakKey);
    IMP imp = [vc methodForSelector:_cmd];
    void (*func)(id, SEL) = (void *)imp;
    func(vc, _cmd);
    
//    [vc performSelector: _cmd];
}

- (void)timerEvent {
    NSLog(@"%@",NSStringFromClass([self class]));
}

- (void)dealloc {
//    NSTimer * timer = objc_getAssociatedObject(_timerTarget, timerKey);
//    [timer invalidate];
//    timer = nil;
    
    [self.timer invalidate];
    self.timer = nil;

}

@end
