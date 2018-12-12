//
//  GQProxy.m
//  PGQDemo
//
//  Created by Lois_pan on 2018/8/22.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//

#import "GQProxy.h"

@interface GQProxy ()
@end

@implementation GQProxy

//函数签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    NSMethodSignature * sig = nil;
    sig = [self.obj methodSignatureForSelector:sel];
    return sig;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget: self.obj];
}

@end
