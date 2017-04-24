//
//  NSString+Regular.h
//  XiangTaiHealth
//
//  Created by 何凯楠 on 15/11/30.
//  Copyright © 2015年 xiangtai. All rights reserved.
//  正则表达式

#import <Foundation/Foundation.h>

@interface NSString (XTRegular)

/**
 *  判断手机号是否正确
 *
 *  @param mobile 手机号
 *
 *  @return 判断信息
 */
+ (NSString *)xt_verifyForMobile:(NSString *)mobile;

/**
 *  判断身份证号是否正确
 *
 *  @param identityCard 身份证号
 *
 *  @return 结果
 */
+ (BOOL)xt_verifyIdentityCard:(NSString *)identityCard;

/**
 *  判断是否是系统表情
 *
 *  @param string 输入字符串
 *
 *  @return 结果
 */
+ (BOOL)xt_verifyContainsEmoji:(NSString *)string;

/**
 *  判断是否是6~18位字符串
 *
 *  @param string 字符串
 *
 *  @return 结果
 */
+ (BOOL)xt_verifySixToEighteen:(NSString *)string;

/**
 *  判断是否是6位纯数字
 *
 *  @param string 字符串
 *
 *  @return 结果
 */
+ (BOOL)xt_verifySixNumber:(NSString *)string;

/**
 *  判断是否是 仅支持中文，字母，数字且不是纯数字，“_”, “-”的组合
 *
 *  @param string 字符串
 *
 *  @return 结果信息
 */
+ (NSString *)xt_verifyChineseOrAlphaOrNumberAndNoatallnumber:(NSString *)string;

/**
 *  检查字符串是否为字母，数字，下划线
 *
 *  @param string 要检查的字符串
 *
 *  @return 结果
 */
+ (BOOL)xt_verifyAlaphOrNumberOrUnderline:(NSString *)string;
/**
 *  检查字符串是否为正整数
 *
 *  @param string 要检查的字符串
 *
 *  @return 结果
 */
+ (BOOL)xt_verifyPositiveIntegerNumber:(NSString *)string;
/**
 *  检查字符串是否为非负浮点数
 *
 *  @param string 检查的字符串
 *
 *  @return 结果
 */
+ (BOOL)xt_verifyPositiveFloatNumber:(NSString *)string;
/**
 *  由数字和字母组成， 并且不能为纯字母或纯数字
 *
 *  @param string 要检查的字符串
 *
 *  @return 结果
 */
+ (BOOL)xt_verifyAlaphAndNumberButNotatallSingleAlaphOrNumber:(NSString *)string;
/**
 护照的验证
 */
+ (BOOL)xt_verifyPassportWithNo:(NSString *)carNO;
/**
 港澳通行证的验证
 */
+ (BOOL)xt_verifyHKAndMacaoTrafficPermitWithNo:(NSString *)carNO;
/**
 军官证的验证
 */
+ (BOOL)xt_verifyCertificateOfOfficersWithNo:(NSString *)carNO;

/**
 判断是否包含中文
 
 @param text 输入内容
 @return 结果
 */
+ (BOOL)xt_verifyContainChinese:(NSString *)text;

#pragma mark - Utilities
///=============================================================================
/// @name Utilities
///=============================================================================
/**
 通过身份证获取性别
 
 @param carNO 身份证号
 @return 性别
 */
+ (NSString *)xt_getSexWithCardNo:(NSString *)carNO;

@end
