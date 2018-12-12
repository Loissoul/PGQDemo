//
//  NSTimer+GQBlockSupport.h
//  PGQDemo
//
//  Created by Lois_pan on 2018/1/10.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (GQBlockSupport)
+ (NSTimer *)gq_scheduleTimerWithTimeInterval:(NSTimeInterval)interval
                                        block:(void(^)())block
                                      repeats:(BOOL)repeats;
@end
