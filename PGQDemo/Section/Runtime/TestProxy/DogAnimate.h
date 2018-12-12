//
//  DogAnimate.h
//  PGQDemo
//
//  Created by Lois_pan on 2018/8/20.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DogAnimateProtocol <NSObject>

- (void)singWithContent:(NSString *)content;
@end


@interface DogAnimate : NSObject

@end
