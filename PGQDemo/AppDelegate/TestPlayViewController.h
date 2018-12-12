//
//  TestPlayViewController.h
//  PGQDemo
//
//  Created by Lois_pan on 2018/6/11.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PLPlayerKit/PLPlayerKit.h>

@interface TestPlayViewController : UIViewController<
PLPlayerDelegate
>

@property (nonatomic, strong) PLPlayer      *player;
@property (nonatomic, strong) NSURL *url;


@end
