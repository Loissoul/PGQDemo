//
//  NSDateFormatterSinleton.m
//  PGQDemo
//
//  Created by Lois_pan on 2018/8/23.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//

#import "NSDateFormatterSinleton.h"

static NSDateFormatter * formatter = nil;
static NSDateFormatter * shortFormatter = nil;
static NSDateFormatter * clockFormatter = nil;


@implementation NSDateFormatterSinleton

+ (void)load {

    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle: NSDateFormatterMediumStyle];
    [formatter setTimeStyle: NSDateFormatterShortStyle];
    [formatter setDateFormat: @"YYYY-MM-dd"];
    

    shortFormatter = [[NSDateFormatter alloc] init];
    [shortFormatter setDateStyle: NSDateFormatterMediumStyle];
    [shortFormatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat: @"YYYY-MM"];

    
    clockFormatter = [[NSDateFormatter alloc] init];
    [clockFormatter setDateStyle: NSDateFormatterMediumStyle];
    [clockFormatter setTimeStyle:NSDateFormatterShortStyle];
    [clockFormatter setDateFormat: @"hh:mm"];

    NSTimeZone * timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    [shortFormatter setTimeZone:timeZone];
    
}

@end
