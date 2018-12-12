//
//  GQFPSLabel.m
//  PGQDemo
//
//  Created by Lois_pan on 2018/1/10.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//

#import "GQFPSLabel.h"
#import "GQWeakProxy.h"

@implementation GQFPSLabel {
    CADisplayLink * _displayLink;
    NSTimeInterval _scheduleTimes;
    NSTimeInterval _timestamp;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size = CGSizeMake(50, 20);
    }
    self = [super initWithFrame:frame];
    
    [self createView];
    [self setupDisPlayLink];
    
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self createView];
        [self setupDisPlayLink];
    }
    return self;
}

- (void)createView {
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    self.textAlignment = NSTextAlignmentCenter;
    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.700];
}

- (void)setupDisPlayLink {
    // 如果直接用 self 或者 weakSelf，都不能解决循环引用问题
    // 将 timer 的 target 从 self ，变成了中间人 NSProxy
    // timer 调用 target 的 selector 时，会被 NSProxy 内部转调用 self 的 selector
    _displayLink = [CADisplayLink displayLinkWithTarget:[GQWeakProxy proxyWithTarget:self] selector:@selector(linkTicks:)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}

//每秒统计linkTicks方法的执行次数打印出对应的FPS
- (void)linkTicks: (CADisplayLink *)link {
    _scheduleTimes++;
    if (_timestamp == 0) {
        _timestamp = link.timestamp;
        return;
    }
    CFTimeInterval timePassed = link.timestamp - _timestamp;
    if (timePassed < 1.f) return;
    
    //fps
    CGFloat fps = _scheduleTimes/timePassed;
    //reset
    _timestamp = link.timestamp;
    _scheduleTimes = 0;

    CGFloat progress = fps / 60.0;

    UIColor *color = [UIColor colorWithHue:0.27 * (progress - 0.2) saturation:1 brightness:0.9 alpha:1];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d FPS",(int)round(fps)]];
    [text addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, text.length - 3)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(text.length - 3, 3)];
    [text addAttribute:NSFontAttributeName value: [UIFont fontWithName:@"Menlo" size:14] range:NSMakeRange(0, text.length)];
    [text addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Courier" size:4] range:NSMakeRange(text.length - 4, 1)];
    self.attributedText = text;
}

- (void)dealloc {
    [_displayLink invalidate];
    NSLog(@"timer release");
}


@end
