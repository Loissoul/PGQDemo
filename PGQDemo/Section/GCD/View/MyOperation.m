//
//  MyOperation.m
//  PGQAFNDemo
//
//  Created by Lois_pan on 16/6/28.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

#import "MyOperation.h"

@implementation MyOperation

-(instancetype)initWithUrl:(NSString *)url
{
    self = [super init];
    
    if (self) {
        self.url = url;
    }
    return  self;
}

-(void)main
{
    @autoreleasepool {
        
        if (self.isCancelled) {

            return;
        }
        
    }
}

@end
