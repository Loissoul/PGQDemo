//
//  TestProxy.h
//  PGQDemo
//
//  Created by Lois_pan on 2018/8/20.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CatAnimate.h"
#import "DogAnimate.h"

@interface TestProxy : NSProxy <DogAnimateProtocol, CatAnimateProtocol>



@end
