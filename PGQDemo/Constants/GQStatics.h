//
//  GQStatics.h
//  PGQDemo
//
//  Created by Lois_pan on 2017/12/25.
//  Copyright © 2017年 Lois_pan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GQStatics : NSObject
//MARK: - 沙盒
+ (id)sandboxGet:(NSString *)key;
+ (void)sandboxSave:(id)aValue forKey:(NSString *)key;
+ (void)sandboxSaveValues:(NSDictionary *)aValues;
+ (void)sandboxRemove:(NSString *)key;
+ (void)sandboxRemoveValues:(NSArray *)keys;


+ (NSString*) md5:(NSString*) input;
/**
 *  时区差(秒)
 */
+ (NSInteger)getTimeZone;
+ (CGSize)boundingRectWithSize:(CGSize)size label:(UILabel*)label;

//验证邮箱
+ (BOOL)validateEmail:(NSString *)candidate;

+ (UIViewController *)currentViewController;

+ (UIImageView *)findHairlineImageViewUnder:(UIView *)view;

+ (BOOL)includeChineseWithString:(NSString *)string;//是否包含中文汉字

+ (BOOL) isEmpty:(NSString *) str;//判断是否全是空

+ (NSDictionary *)parseDic:(NSDictionary *)dic;

//隐藏所有键盘
+ (BOOL)dismissAllKeyBoardInView:(UIView *)view;

//MARK: - 将时间转换为字符串
+ (NSString *)dateToString:(NSDate *)date;
@end
