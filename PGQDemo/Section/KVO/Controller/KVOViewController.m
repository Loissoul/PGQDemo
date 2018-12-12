//
//  KVOViewController.m
//  PGQDemo
//
//  Created by Lois_pan on 2018/8/20.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//

/**KVO的原理
 当设置一个类为观察对象的时候，系统会动态的创建一个新的类，这个新的类继承自被观察对象的类，还重写了基类被观察属性的setter的方法。派生类在被重写的setter方法中实现真正的通知机制 。最后系统将这个对象的isa指针指向这个新创建的派生类，这样被观察对象就变成了新创建的派生类的实例。
 **/

#import "KVOViewController.h"

@interface KVOViewController ()

@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


@end
