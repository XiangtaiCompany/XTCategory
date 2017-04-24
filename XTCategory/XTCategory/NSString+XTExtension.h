//
//  NSString+size.h
//  MeiTuan
//
//  Created by 何凯楠 on 16/6/20.
//  Copyright © 2016年 HeXiaoBa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (XTExtension)

#pragma mark - Size
///=============================================================================
/// @name Size
///=============================================================================

/**
 *  根据字体算出字符串的size，默认size为最大
 *
 *  @param font 字体
 *
 *  @return 字体size
 */
- (CGSize)xt_getSizeWithFont:(UIFont *)font;

/**
 根据字体算出字符串的width，默认size为最大

 @param font 字体
 @return 字体width
 */
- (CGFloat)xt_getWidthWithFont:(UIFont *)font;

/**
 根据字体算出字符串的height

 @param font 字体
 @param width 设定宽度
 @return 字体高度
 */
- (CGFloat)xt_getHeightWithFont:(UIFont *)font width:(CGFloat)width;

/**
 根据字体算出字符串的size，默认段落样式为 NSLineBreakByWordWrapping

 @param font  字体
 @param size  设定宽高

 @return 字体size
 */
- (CGSize)xt_getSizeWithFont:(UIFont *)font size:(CGSize)size;

/**
 根据字体和宽度算出字符串的size

 @param font 字体
 @param size 设定宽高
 @param lineBreakMode 段落样式
 @return 字体size
 */
- (CGSize)xt_getSizeWithFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

#pragma mark - Hash
///=============================================================================
/// @name Hash
///=============================================================================

/**
 md5

 @return md5加密后的字符串
 */
- (NSString *)xt_md5String;

#pragma mark - Attributed
///=============================================================================
/// @name Attributed
///=============================================================================

/**
 给部分文字设置样式

 @param text 整个字符串
 @param effectiveText 要设置样式的字符串
 @param attrs 样式dictionary
 @return 设置样式后的字符串
 */
+ (NSAttributedString *)xt_addAttributesWithText:(NSString *)text effectiveText:(NSString *)effectiveText attrs:(NSDictionary<NSString *, id> *)attrs;

/**
 给部分文字设置颜色

 @param text  整个字符串
 @param effectiveText 要设置颜色的字符串
 @param effectiveColor 要变的颜色
 @return 变后的字符串
 */
+ (NSAttributedString *)xt_addAttributesColorWithText:(NSString *)text effectiveText:(NSString *)effectiveText effectiveColor:(UIColor *)effectiveColor;

/**
 给部分文字设置中划线

 @param text 整个字符串
 @param effectiveText 要设置中华线的字符串
 @return 变后的整个字符串
 */
+ (NSAttributedString *)xt_addAttributesMiddleLineWithText:(NSString *)text effectiveText:(NSString *)effectiveText;

#pragma mark - Utilities
///=============================================================================
/// @name Utilities
///=============================================================================
/**
 去除空格和换行
 
 @return 去除空格和换行后的字符串
 */
- (NSString *)xt_stringByTrim;

@end
