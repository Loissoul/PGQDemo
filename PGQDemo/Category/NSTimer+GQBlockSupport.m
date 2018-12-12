//
//  NSTimer+GQBlockSupport.m
//  PGQDemo
//
//  Created by Lois_pan on 2018/1/10.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//

#import "NSTimer+GQBlockSupport.h"

@implementation NSTimer (GQBlockSupport)

+ (NSTimer *)gq_scheduleTimerWithTimeInterval:(NSTimeInterval)interval
                                        block:(void(^)())block
                                      repeats:(BOOL)repeats {
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(gq_blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
    
}

- (void)gq_blockInvoke:(NSTimer *)timer {
    void (^block)() = timer.userInfo;
    if (block) {
        block();
    }
}

@end
