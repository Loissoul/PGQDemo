//
//  GCDViewController.m
//  PGQDemo
//
//  Created by Lois_pan on 2018/8/20.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//

#import "GCDViewController.h"
#import "MyOperation.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"GCDViewController.h");
    
    [self testGroup];
//    [self interview];
    
    //  UITrackingRunMode UIScrollView滑动的时候
    //  [NSRunLoop currentRunLoop] runMode:UITrackingRunLoopMode beforeDate:[NSDate distantFuture]];
}

- (void)testGroup {
    //    static dispatch_semaphore_t lock;
    
    dispatch_queue_t disqueue =  dispatch_queue_create("com.shidaiyinuo.NetWorkStudy", DISPATCH_QUEUE_CONCURRENT);
    
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
//    __weak typeof(self) weakSelf = self;
    @weakify(self)

    dispatch_group_async(group, disqueue, ^{
        //添加任务一
//        __strong typeof(weakSelf) strongSelf = weakSelf;
        @strongify(self);
        [self adctionComplete:^{
            dispatch_group_leave(group);
        }];
    });

    dispatch_group_notify(group, disqueue, ^{
        //任务全部完成时候的处理
        NSLog(@"完成了");
    });

}

- (void)adctionComplete:(void(^)())complete {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(3);
        complete();
    });
}

/**GCD (Grand Central Dispatch) ：iOS4 开始引入，使用更加方便，程序员只需要将任务添加到Dispatch Queues 中即可。

Dispatch  Queues 中的任务按照FIFO的顺序进行处理，并且，由于加入任务的方式不同，执行分为同步／异步。

Dispatch Groups 可以帮助我们处理如何判断多线程全部执行结束的问题

Dispatch Semaphores 帮助我们控制多任务对有限数量资源的访问

Dispatch Objects 帮助我们对线程队列进行更加细致的控制（挂起、恢复、取消、激活等操作）

Dispatch Once 可以帮助我们确保某个函数只执行一次，可用于单例的实现

下面针对以上内容给出示例代码

1.串行队列,每次只执行一个任务，无论用什么方式加入任务。

//为了清楚表示可以写为DISPATCH_QUEUE_SERIAL，iOS官方文档定义的DISPATCH_QUEUE_SERIAL就是NULL

使用串行队列，任务都是挨个执行，每次只运行一个。

2.并行队列,每次执行多个任务 DISPATCH_QUEUE_CONCURRENT

**/
//线程堵塞
- (void)interview01 {
    NSLog(@"执行任务1");
    dispatch_queue_t queue = dispatch_queue_create("myqueu", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{ // 0
        NSLog(@"执行任务2");
        dispatch_sync(queue, ^{ // 1
            NSLog(@"执行任务3");
        });
        NSLog(@"执行任务4");
    });
    NSLog(@"执行任务5");
}

- (void)interview {
    NSLog(@"1");
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        NSLog(@"3");
        [self performSelector:@selector(test) withObject:nil afterDelay:0.0f];
        NSLog(@"4");
    });
    
    NSLog(@"2");
}

- (void)test {
    NSLog(@"5");
}


//创建了一个初使值为10的semaphore，每一次for循环都会创建一个新的线程，线程结束的时候会发送一个信号，线程创建之前会信号等待，所以当同时创建了10个线程之后，for循环就会阻塞，等待有线程结束之后会增加一个信号才继续执行，如此就形成了对并发的控制，如下就是一个并发数为10的一个线程队列。
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
    dispatch_queue_t disqueue =  dispatch_queue_create("com.shidaiyinuo.NetWorkStudy", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, disqueue, ^{
        //添加任务一
    });
    dispatch_group_async(group, disqueue, ^{
        //添加任务二
    });
    dispatch_group_notify(group, disqueue, ^{
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

- (void)addNSoperationQueue {
    MyOperation * operation_1 = [[MyOperation alloc] initWithUrl:@"operation_1"];
    MyOperation * operation_2 = [[MyOperation alloc] initWithUrl:@"operation_2"];
    
    NSOperationQueue * myQueue = [[NSOperationQueue alloc] init];
    myQueue.name = @"Lois_soul下载队列";
    
    [myQueue setMaxConcurrentOperationCount:4];
    
    [myQueue addOperation:operation_1];
    [myQueue addOperation:operation_2];
    
    [self execute:^{
        [operation_1 cancel];
    } afterDelay:1.0];
    
    [myQueue addOperationWithBlock:^{
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"ssssss"]];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //UI更新操作 显示图片
            self.view.layer.contents = (__bridge id)([UIImage imageWithData:data].CGImage);
        }];
    }];
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

- (void)explainWithCN {
    
    
}
@end
