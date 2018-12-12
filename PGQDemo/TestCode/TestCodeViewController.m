//
//  TestCodeViewController.m
//  PGQDemo
//
//  Created by Lois_pan on 2018/1/12.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//

#import "TestCodeViewController.h"

@interface TestCodeViewController ()

@end

@implementation TestCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Test";
    [self testWeakSelf];
}

- (void)testWeakSelf {
    //内存地址是一样的，但是指针发生了变化，进行了弱引用
//    __weak typeof(self)weakSelf = self;
//    NSLog(@"%p", weakSelf);
//    NSLog(@"%p", self);
}

- (void)test2 {
    NSMethodSignature * signature = [TestCodeViewController instanceMethodSignatureForSelector:@selector(run:)];
    NSInvocation * invotion = [NSInvocation invocationWithMethodSignature: signature];
    invotion.target = self;
    invotion.selector = @selector(run:);
    NSString * way = @"";
    //这里的Index要从2开始，以为0跟1已经被占据了，分别是self（target）,selector(_cmd)
    [invotion setArgument:&way atIndex:2];

    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1 invocation:invotion repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)run:(NSString *)method {
    
}

- (void)test1 {
    BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
    BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
    NSLog(@"%@%@", res1, res2);
}


//创建了一个初使值为10的semaphore，每一次for循环都会创建一个新的线程，线程结束的时候会发送一个信号，线程创建之前会信号等待，所以当同时创建了10个线程之后，for循环就会阻塞，等待有线程结束之后会增加一个信号才继续执行，如此就形成了对并发的控制，如上就是一个并发数为10的一个线程队列。
- (void)kongZhiXiancheng {
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    for (int i = 0; i < 100; i++) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_group_async(group, queue, ^{
            NSLog(@"%d",i);
            sleep(5);
            dispatch_semaphore_signal(semaphore);
        });
    }
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
}

- (void)group_t {
    //方法一
    //    static dispatch_semaphore_t lock;
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //添加任务一
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //添加任务二
    });
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //任务全部完成时候的处理
    });
    
    //方法二
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 3; i ++) {
            dispatch_group_enter(group);
            // 任务代码i 假定任务 是异步执行block回调
            
            // block 回调执行
            dispatch_group_leave(group);
            // block 回调执行
        }
    });
    
    //因为dispatch_group_wait函数是阻塞的，for里面安排了三个任务，这三个任务都是加载，在任意任务开始前调用enter，任务完成时调用leave，wait函数一直阻塞，直到它发现group里面的任务全部leave，它才放弃阻塞（任务全部完成），然后我们在主线程更新UI告知用户
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    dispatch_async(dispatch_get_main_queue(), ^{
        // 主线程处理
    });
    
}

- (void)execute:(dispatch_block_t)block afterDelay:(int64_t)delta {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta), dispatch_get_main_queue(),block);
}

//计时器发送验证码
- (void)sentPhoneCodeTimeMethod {
    //倒计时时间 - 60秒
    __block NSInteger timeOut = 59;
    //执行队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //计时器 -》dispatch_source_set_timer自动生成
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (timeOut <= 0) {
            dispatch_source_cancel(timer);
            //主线程设置按钮样式-》
            dispatch_async(dispatch_get_main_queue(), ^{
                //时间到 UI
            });
        }else{
            //主线程设置按钮样式
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1.0];
                //在计时的时候的 UI 变化
            });
            
        }
    });
    dispatch_resume(timer);
}

- (void)dispatchAction {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        
    });
    
    dispatch_resume(timer);
}

//用户事件
- (void)addDataProgress2 {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t stDinSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_READ, STDIN_FILENO, 0, queue);
    
    dispatch_source_set_event_handler(stDinSource, ^{
        
        char buf[1024];
        long len = read(STDIN_FILENO, buf, sizeof(buf));
        if (len > 0) {
            NSLog(@"Get data from stdin: %.*s", (int)len, buf);
        }
    });
    dispatch_resume(stDinSource);
}


- (void)addDataProgress {
    
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, dispatch_get_main_queue());
    
    dispatch_source_set_event_handler(source, ^{
        
        //        dispatch_source_get_data(source); 进度
    });
    dispatch_resume(source);
    
    //调用单一block多次, 并且平行计算，然后等待所有运算结束，  可以针对数组进行处理
    dispatch_apply(11, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
        dispatch_source_merge_data(source, 1);
    });
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
