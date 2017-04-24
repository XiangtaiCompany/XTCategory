//
//  UIImage+Extension.h
//  NavigationBar
//
//  Created by 何凯楠 on 2017/4/14.
//  Copyright © 2017年 HeXiaoBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XTExtension)

#pragma mark - Create image
///=============================================================================
/// @name Create image
///=============================================================================

/**
 通过color生成一个image，默认size(1, 1)

 @param color 颜色
 @return 图片
 */
+ (UIImage *)xt_imageWithColor:(UIColor *)color;

/**
 通过color和size生成一个image

 @param color 颜色
 @param size 大小
 @return 图片
 */
+ (UIImage *)xt_imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 设置image和透明度

 @param alpha 透明度
 @return 图片
 */
- (UIImage *)xt_imageByApplyingAlpha:(CGFloat)alpha;

@end
