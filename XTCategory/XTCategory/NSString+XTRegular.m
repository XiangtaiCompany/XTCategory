//
//  NSString+Regular.m
//  XiangTaiHealth
//
//  Created by 何凯楠 on 15/11/30.
//  Copyright © 2015年 xiangtai. All rights reserved.
//

#import "NSString+XTRegular.h"

@implementation NSString (XTRegular)


+ (NSString *)xt_verifyForMobile:(NSString *)mobile
{
    if(mobile.length == 0){
        return @"请填写电话号码";
    }
    else if (mobile.length < 11)
    {
        return @"电话号码长度只能是11位";
    }else{
//        /**
//         * 移动号段正则表达式
//         */
//        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
//        /**
//         * 联通号段正则表达式
//         */
//        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
//        /**
//         * 电信号段正则表达式
//         */
//        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
//
//        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
//        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
//        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
//        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
//        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
//        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
//        
//        if (isMatch1 || isMatch2 || isMatch3) {
//            return nil;
//        }else{
//            return @"请输入正确的电话号码";
//        }
        
        NSString *reg = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[0-9]|18[0-9]|14[57])[0-9]{8}$";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
        BOOL match = [predicate evaluateWithObject:mobile];
        if (match) {
            return nil;
        } else {
            return @"请输入正确的电话号码";
        }
    }
    return nil;
}

+ (BOOL)xt_verifyIdentityCard: (NSString *)identityCard
{
    //判断是否为空
    if (identityCard==nil||identityCard.length <= 0) {
        return NO;
    }
    //判断是否是18位，末尾是否是x
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    if(![identityCardPredicate evaluateWithObject:identityCard]){
        return NO;
    }
    //判断生日是否合法
    NSRange range = NSMakeRange(6,8);
    NSString *datestr = [identityCard substringWithRange:range];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat : @"yyyyMMdd"];
    if([formatter dateFromString:datestr]==nil){
        return NO;
    }
    
    //判断校验位
    if(identityCard.length==18)
    {
        NSArray *idCardWi= @[ @"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2" ]; //将前17位加权因子保存在数组里
        NSArray * idCardY=@[ @"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2" ]; //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        int idCardWiSum=0; //用来保存前17位各自乖以加权因子后的总和
        for(int i=0;i<17;i++){
            idCardWiSum+=[[identityCard substringWithRange:NSMakeRange(i,1)] intValue]*[idCardWi[i] intValue];
        }
        
        int idCardMod=idCardWiSum%11;//计算出校验码所在数组的位置
        NSString *idCardLast=[identityCard substringWithRange:NSMakeRange(17,1)];//得到最后一位身份证号码
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2){
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]){
                return YES;
            }else{
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast intValue]==[idCardY[idCardMod] intValue]){
                return YES;
            }else{
                return NO;
            }
        }
    }
    return NO;
}

//判断是否是系统表情

+ (BOOL)xt_verifyContainsEmoji:(NSString *)string {
    
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop)
     {
         const unichar hs = [substring characterAtIndex:0];
         
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff)
             
         {
             if (substring.length > 1)
             {
                 const unichar ls = [substring characterAtIndex:1];
                 
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 
                 if (0x1d000 <= uc && uc <= 0x1f77f)
                 {
                     returnValue = YES;
                 }
             }
         }
         else if (substring.length > 1)
         {
             const unichar ls = [substring characterAtIndex:1];
             
             if (ls == 0x20e3)
             {
                 returnValue = YES;
             }
         }
         else
         {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff)
             {
                 returnValue = YES;
             }
             else if (0x2B05 <= hs && hs <= 0x2b07)
             {
                 returnValue = YES;
             }
             else if (0x2934 <= hs && hs <= 0x2935)
             {
                 returnValue = YES;
             }
             else if (0x3297 <= hs && hs <= 0x3299)
             {
                 returnValue = YES;
             }
             else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50)
             {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

+ (BOOL)xt_verifySixToEighteen:(NSString *)string {
    BOOL flag = YES;
    if (string.length < 6 || string.length > 18)    {
        flag = NO;
    }
    return flag;
//    NSString *regex = @"^\\w+$";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
//    return [predicate evaluateWithObject:password];
}

+ (BOOL)xt_verifySixNumber:(NSString *)string {
    if (string.length != 6) {
        return NO;
    }
    NSString *regex = @"^\\d*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:string];
}

+ (NSString *)xt_verifyChineseOrAlphaOrNumberAndNoatallnumber:(NSString *)string {
    
    NSString *result = nil;
    if (string.length < 2 || string.length > 12) {
        result = @"长度必须是3~11位";
        return result;
    }
    
    NSString *regex = @"([\u4e00-\u9fa5a-zA-Z]+[0-9]*)";
    NSString *pattern = @"[`~!@#$^&*()=|{}':;',\\[\\].<>~！@#￥……&*（）——|{}【】‘；：”“'。，、？]";
    
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    NSPredicate *predicate2= [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isUseful1 = [predicate1 evaluateWithObject:string];
    BOOL isUseful2 = [predicate2 evaluateWithObject:string];
    if (!isUseful1) {
        result = @"格式错误，仅支持中文，字母，数字且不能纯数字，“_”，“-”，且不能有空字符串";
        return result;
    }
    
    if (isUseful2) {
        result = @"不能包含特殊字符";
        return result;
    }
    
    return result;
}

+ (BOOL)xt_verifyAlaphOrNumberOrUnderline:(NSString *)string {
    if (string.length <= 0) {
        return NO;
    }
    NSString *regex = @"^\\w+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:string];
}

+ (BOOL)xt_verifyPositiveIntegerNumber:(NSString *)string {
    if (!string.length) {
        return NO;
    }
    NSString *regex = @"^\\d*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:string];
}

+ (BOOL)xt_verifyPositiveFloatNumber:(NSString *)string {
    if (string.length <= 0) {
        return NO;
    }
    NSString *regex = @"^\\d+(\\.\\d+)$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:string];
}

// 正则 密码 由数字和字母组成， 并且不能为纯字母或纯数字
+ (BOOL)xt_verifyAlaphAndNumberButNotatallSingleAlaphOrNumber:(NSString *)string {
    if (string.length <= 0) {
        return NO;
    }
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,18}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:string];
}

/**
 护照的验证
 */
+ (BOOL)xt_verifyPassportWithNo:(NSString *)carNO {
    if (carNO.length <= 0) {
        return NO;
    }
    NSString *regex1 = @"^[a-zA-Z]{5,17}$";
    NSString *regex2 = @"^[a-zA-Z0-9]{5,17}$";
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex1];
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL match1 = [predicate1 evaluateWithObject:carNO];
    BOOL match2 = [predicate2 evaluateWithObject:carNO];
    if (!match1 && !match2) {
        return NO;
    }
    return YES;
    
}
/**
 港澳通行证的验证
 */
+ (BOOL)xt_verifyHKAndMacaoTrafficPermitWithNo:(NSString *)carNO {
    if (carNO.length <= 0) {
        return NO;
    }
    NSString *regex = @"^[HMhm]{1}([0-9]{10}|[0-9]{8})$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:carNO];
}
/**
 军官证的验证
 */
+ (BOOL)xt_verifyCertificateOfOfficersWithNo:(NSString *)carNO {
    if (carNO.length <= 0) {
        return NO;
    }
    NSString *regex = @"南字第(\\d{8})号|北字第(\\d{8})号|沈字第(\\d{8})号|兰字第(\\d{8})号|成字第(\\d{8})号|济字第(\\d{8})号|广字第(\\d{8})号|海字第(\\d{8})号|空字第(\\d{8})号|参字第(\\d{8})号|政字第(\\d{8})号|后字第(\\d{8})号|装字第(\\d{8})号";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:carNO];
}

/**
 判断是否包含中文
 
 @param text 输入内容
 @return 结果
 */
+ (BOOL)xt_verifyContainChinese:(NSString *)text {
    if (!text.length) {
        return NO;
    }
    
    NSString *pattern = @"[\u4e00-\u9fa5]";
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *result = [regular matchesInString:text options:NSMatchingReportProgress range:NSMakeRange(0, text.length)];
    return result.count;
}

#pragma mark - Utilities
///=============================================================================
/// @name Utilities
///=============================================================================

//通过身份证获取性别
+ (NSString *)xt_getSexWithCardNo:(NSString *)carNO {
    NSString *sexNo = nil;
    if (carNO.length != 15 && carNO.length != 18) {
        return nil;
    } else {
        sexNo = [carNO substringWithRange:NSMakeRange(carNO.length - 1, 1)];
        
        if ([[sexNo lowercaseString] isEqualToString:@"x"] || [[sexNo lowercaseString] isEqualToString:@"e"]) {
            return @"男";
        } else {
            NSInteger temp = [sexNo integerValue] % 2;
            return temp == 0 ? @"女" : @"男";
        }
    }
}


@end
