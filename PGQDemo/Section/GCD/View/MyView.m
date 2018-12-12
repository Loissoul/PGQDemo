//
//  MyView.m
//  PGQAFNDemo
//
//  Created by Lois_pan on 16/6/28.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

//点击一个view的具体响应实现

#import "MyView.h"

@implementation MyView
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    // 1.判断自己能否接收触摸事件
    if (self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.01) return nil;
    // 2.判断触摸点在不在自己范围内
    if (![self pointInside:point withEvent:event]) return nil;
    // 3.从后往前遍历自己的子控件，看是否有子控件更适合响应此事件
    int count = (int)self.subviews.count;
    for (int i = count - 1; i >= 0; i--) {
        UIView *childView = self.subviews[i];
        CGPoint childPoint = [self convertPoint:point toView:childView];
        UIView *fitView = [childView hitTest:childPoint withEvent:event];
        if (fitView) {
            return fitView;
        }
    }
    // 没有找到比自己更合适的view
    return self;
}

//事件传递和响应者链条
//响应者链条和响应事件的 传递顺序是相反的！  事件传递是从application开始的 UIApplication -> UIWindow -> ViewController -> view   链条恰恰相反是从触摸事件的view开始的


//响应者链条其实还包括视图控制器、UIWindow和UIApplication，
/*通过事件传递找到最合适的处理触摸事件的view后（就是最后一个pointInside返回YES的view，它是第一响应者），如果该view是控制器view，那么上一个响应者就是控制器。如果它不是控制器view，那么上一个响应者就是前面一个pointInside返回YES的view（其实就是它的父控件）。 最后这些所有pointInside返回YES的view加上它们的控制器、UIWindow和UIApplication共同构成响应者链条。响应者链条是自上而下的（我把window上最外面的那个view称为上），前面的事件传递是自下而上的。
*/

//每个能执行hitTest:方法的view都属于事件传递的一部分，但是，只有pointInside返回YES的view才属于响应者链条。
//响应者:继承UIResponder的对象称之为响应者对象，能够处理touchesBegan等触摸事件。响应者链条:由很多响应者链接在一起组合起来的一个链条称之为响应者链条
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    //判断点击区域然后进行返回判断
    return NO;
}

@end
