//
//  NSProxyViewController.h
//  PGQDemo
//
//  Created by Lois_pan on 2018/8/20.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//
/**
消息转发（Message Forwarding）
 
 Fast Forwarding
 
 如果目标对象实现- forwardingTargetForSelector:方法，系统就会在运行时调用这个方法，只要这个方法返回的不是nil或self，也会重启消息发送的过程，把这消息转发给其他对象来处理。否则，就会继续Normal Fowarding。
 
 Normal Forwarding
 
 如果没有使用Fast Forwarding来消息转发，最后只有使用Normal Forwarding来进行消息转发。它首先调用methodSignatureForSelector:方法来获取函数的参数和返回值，如果返回为nil，程序会 crash 掉，并抛出unrecognized selector sent to instance异常信息。如果返回一个函数签名，系统就会创建一个NSInvocation对象并调用-forwardInvocation:方法。
 
 在一个函数找不到时，Objective-C提供了三种方式去补救：
 
 调用resolveInstanceMethod给个机会让类添加这个实现这个函数
 
 调用forwardingTargetForSelector让别的对象去执行这个函数
 
 调用methodSignatureForSelector（函数符号制造器）和forwardInvocation（函数执行器）灵活的将目标函数以其他形式执行。 获取函数的参数和防止
 
 如果都不中，调用doesNotRecognizeSelector抛出异常。


 **/



#import "BaseViewController.h"

@interface NSProxyViewController : BaseViewController

@end
