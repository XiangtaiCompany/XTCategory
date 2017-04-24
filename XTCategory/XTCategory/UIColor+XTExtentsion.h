//
//  UIColor+Switch16ToColor.h
//  XiangTaiHealth
//
//  Created by xiangtai on 15/3/25.
//  Copyright (c) 2015年 xiangtai. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef XTUIColorHex
#define XTUIColorHex(_hex_)   [UIColor xt_colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]
#endif

@interface UIColor (XTExtentsion)

/**
 通过rgb设置color

 @param rgbValue rgb值
 @return UIColor
 */
+ (UIColor *)xt_colorWithRGB:(uint32_t)rgbValue;

/**
 通过rgba设置color

 @param rgbaValue rgba值
 @return UIColor
 */
+ (UIColor *)xt_colorWithRGBA:(uint32_t)rgbaValue;

/**
 通过rgb设置color,并设置透明度

 @param rgbValue rgb值
 @param alpha 透明度
 @return UIColor
 */
+ (UIColor *)xt_colorWithRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha;

/**
 通过16进制设置color

 @param hexStr 16进制字符串
 @return UIColor
 */
+ (UIColor *)xt_colorWithHexString:(NSString *)hexStr;

@end
