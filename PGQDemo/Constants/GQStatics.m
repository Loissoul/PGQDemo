//
//  GQStatics.m
//  PGQDemo
//
//  Created by Lois_pan on 2017/12/25.
//  Copyright © 2017年 Lois_pan. All rights reserved.
//

#import "GQStatics.h"
#import <CommonCrypto/CommonDigest.h>
#include <sys/param.h>
#include <sys/mount.h>

@implementation GQStatics

+ (id)sandboxGet:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)sandboxSave:(id)aValue forKey:(NSString *)key {
    [self sandboxSaveValues:@{key:aValue}];
}

+ (void)sandboxSaveValues:(NSDictionary *)aValues {
    for (NSString * key in aValues.allKeys) {
        [[NSUserDefaults standardUserDefaults] setObject:aValues[key] forKey:key];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)sandboxRemove:(NSString *)key {
    [self sandboxRemoveValues:@[key]];
}

+ (void)sandboxRemoveValues:(NSArray *)keys {
    for (NSString * key in keys) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString*) md5:(NSString*) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}


//MARK: - 时区差(秒)
+ (NSInteger)getTimeZone {
    NSTimeInterval timeZoneOffset=[[NSTimeZone systemTimeZone] secondsFromGMT];
    int  n = timeZoneOffset;
    return n;
}

//MARK: - 计算字符串的长度
+ (CGSize)boundingRectWithSize:(CGSize)size label:(UILabel*)label{
    if (label.text.length == 0) {
        return CGSizeMake(0, 0);
    }
    
    NSDictionary *attribute = @{NSFontAttributeName: label.font};
    CGSize retSize = [label.text boundingRectWithSize:size
                                              options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                           attributes:attribute
                                              context:nil].size;
    return retSize;
}

+ (BOOL)validateEmail:(NSString *)candidate {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)currentViewController {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

//找到导航栏或者工具栏的线
+ (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

//判断是否包含中文汉字
+ (BOOL)includeChineseWithString:(NSString *)string
{
    for(int i=0; i< [string length];i++)
    {
        int a =[string characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}

//判断是否全是空格
+ (BOOL) isEmpty:(NSString *) str {
    if (!str) {
        return true;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}

//替换dic中NULL
+ (NSDictionary *)parseDic:(NSDictionary *)dic {
    
    NSMutableDictionary * mutableDic = [[NSMutableDictionary alloc] init];
    for (NSString * key in [dic allKeys]) {
        if ([[dic valueForKey:key] isEqual: [NSNull null]]) {
            [mutableDic setObject:@"" forKey: key];
        } else {
            [mutableDic setObject:[dic valueForKey:key] forKey: key];
        }
    }
    return [mutableDic copy];
}


//隐藏所有键盘
+ (BOOL)dismissAllKeyBoardInView:(UIView *)view{
    if([view isFirstResponder]){
        [view resignFirstResponder];
        return YES;
    }
    for (UIView *subView in view.subviews) {
        if([self dismissAllKeyBoardInView:subView]){
            return YES;
        }
    }
    return NO;
}

//MARK: - 将时间转换为字符串
+ (NSString *)dateToString:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

//MARK: - 获取当前的页面
- (UIViewController *)currentViewController {
    __block UIViewController *currentVC = nil;
    if ([NSThread isMainThread]) {
        @try {
            UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
            if (rootViewController != nil) {
                currentVC = [self getCurrentVCFrom:rootViewController];
            }
        } @catch (NSException *exception) {
            NSLog(@"获取当前页面失败1");
        }
        return currentVC;
    } else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            @try {
                UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
                if (rootViewController != nil) {
                    currentVC = [self getCurrentVCFrom:rootViewController];
                }
            } @catch (NSException *exception) {
                NSLog(@"获取当前页面失败2");
            }
        });
        return currentVC;
    }
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    @try {
        UIViewController *currentVC;
        if ([rootVC presentedViewController]) {
            // 视图是被presented出来的
            rootVC = [rootVC presentedViewController];
        }
        
        if ([rootVC isKindOfClass:[UITabBarController class]]) {
            // 根视图为UITabBarController
            currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        } else if ([rootVC isKindOfClass:[UINavigationController class]]){
            // 根视图为UINavigationController
            currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        } else {
            // 根视图为非导航类
            currentVC = rootVC;
        }
        
        return currentVC;
    } @catch (NSException *exception) {
        NSLog(@"获取当前页面失败3");
    }
}



@end
