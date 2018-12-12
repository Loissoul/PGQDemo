//
//  CatAnimate.m
//  PGQDemo
//
//  Created by Lois_pan on 2018/8/20.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//

#import "CatAnimate.h"
@interface CatAnimate ()<CatAnimateProtocol>

@end

@implementation CatAnimate
- (void)entWithContent:(NSString *)content {
    NSLog(@"cat is eat : %@", content);
}

@end
