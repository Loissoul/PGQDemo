//
//  UIImageView+Radius.h
//  PGQDemo
//
//  Created by Lois_pan on 2017/12/28.
//  Copyright © 2017年 Lois_pan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Radius)

- (UIImageView *)roundedRectImageViewWithCornerRadius:(CGFloat)cornerRadius;

+ (UIImage * )createRadiusImageWithSize:(CGSize)size color:(UIColor *)color cornRadius:(CGFloat)cornRadius;

/**
 *  调整图片尺寸和大小
 *
 *  @param sourceImage  原始图片
 *  @param maxImageSize 新图片最大尺寸
 *  @param maxSize      新图片最大存储大小
 *
 *  @return 新图片imageData
 */
+ (NSData *)Limit_reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize;

@end
