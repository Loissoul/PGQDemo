//
//  MyOperation.h
//  PGQAFNDemo
//
//  Created by Lois_pan on 16/6/28.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOperation : NSOperation

@property (nonatomic, strong) NSString * url;
-(instancetype)initWithUrl:(NSString *)url;
@end
