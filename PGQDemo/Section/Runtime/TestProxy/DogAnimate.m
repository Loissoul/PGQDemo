//
//  DogAnimate.m
//  PGQDemo
//
//  Created by Lois_pan on 2018/8/20.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//

#import "DogAnimate.h"
@interface DogAnimate() <DogAnimateProtocol>

@end

@implementation DogAnimate

- (void)singWithContent:(NSString *)content {
    NSLog(@"wang wang wang \"%@\"", content);
}

@end
