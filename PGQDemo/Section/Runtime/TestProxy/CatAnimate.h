//
//  CatAnimate.h
//  PGQDemo
//
//  Created by Lois_pan on 2018/8/20.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CatAnimateProtocol <NSObject>
- (void)entWithContent:(NSString *)content;
@end

@interface CatAnimate : NSObject

@end
