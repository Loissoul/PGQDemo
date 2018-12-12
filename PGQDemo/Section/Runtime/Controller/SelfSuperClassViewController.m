//
//  SelfSuperClassViewController.m
//  PGQDemo
//
//  Created by Lois_pan on 2018/8/20.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//

/**
 self class 和 super class
 self class  id objc_msgSend(receiver, @selector())
 super class id objc_msgSendSuper(struct objc_super* super, SEL)  struct objc_super{ id receiver, Class superClass;};
 可以看到这个结构体包含了两个成员，一个是receiver，这个类似上面objc_msgSend的第一个参数receiver，第二个成员是记 录写super这个类的父类是什么，拿上面的代码为例，当编译器遇到Son里 setName:andAge方法里的[super setName:]时，开始做这几个事：
 
 1，构建objc_super的结构体，此时这个结构体的第一个成员变量receiver就是son，和self相同。而第二个成员变量superClass就是指类Father，因为Son的超类就是这个Father。
 
 2，调用objc_msgSendSuper的方法，将这个结构体和setName的sel传递过去。函数里面在做的事情类似这样：从 objc_super结构体指向的superClass的方法列表开始找setName的selector，找到后再 以 objc_super->receiver去调用这个selector，可能也会使用objc_msgSend这个函数，不过此时的第一个参数 theReceiver就是objc_super->receiver，第二个参数是从objc_super->superClass中找 到 的selector
 
 **/

#import "SelfSuperClassViewController.h"

@interface SelfSuperClassViewController ()

@end

@implementation SelfSuperClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
