//
//  TestProxy.m
//  PGQDemo
//
//  Created by Lois_pan on 2018/8/20.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//

#import "TestProxy.h"
#import <objc/runtime.h>

@interface TestProxy () {
    DogAnimate * _dog;
    CatAnimate * _cat;
    
    NSMutableDictionary * _methodMap;
}

@end

@implementation TestProxy
+(instancetype)share {
    return [[TestProxy alloc] init];
}

- (instancetype)init {
    _methodMap = [NSMutableDictionary dictionary];
    _dog = [[DogAnimate alloc] init];
    _cat = [[CatAnimate alloc] init];
    [self registerMethodsWithTarget: _dog];
    [self registerMethodsWithTarget: _cat];
    return self;
}

#pragma mark - private method
- (void)registerMethodsWithTarget:(id )target{
    unsigned int numberOfMethods = 0;
    
    //获取target的方法列表
    Method * methodList = class_copyMethodList([target class], &numberOfMethods);
    for (int i = 0; i < numberOfMethods; i++) {
        Method temMethod = methodList[i];
        SEL sel = method_getName(temMethod);
        const char * temMethodName = sel_getName(sel);
        [_methodMap setObject:target forKey: [NSString stringWithUTF8String: temMethodName]];
    }
    free(methodList);
}

#pragma mark - NSProxy override methods
//函数执行器
- (void)forwardInvocation:(NSInvocation *)invocation {
    SEL sel = invocation.selector;
    
    NSString *methodName = NSStringFromSelector(sel);
    
    id target = _methodMap[methodName];
    
    if (target && [target respondsToSelector:sel]) {
        [invocation invokeWithTarget:target];
    } else {
        [super forwardInvocation: invocation];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    NSString *methodName = NSStringFromSelector(sel);

    id target = _methodMap[methodName];
    if (target && [target respondsToSelector:sel]) {
       return [target methodSignatureForSelector: sel];
    } else {
        return [super methodSignatureForSelector: sel];
    }
    
}



@end
