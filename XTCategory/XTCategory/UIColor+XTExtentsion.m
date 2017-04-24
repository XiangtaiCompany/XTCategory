//
//  UIColor+Switch16ToColor.m
//  XiangTaiHealth
//
//  Created by xiangtai on 15/3/25.
//  Copyright (c) 2015年 xiangtai. All rights reserved.
//

#import "UIColor+XTExtentsion.h"

@implementation UIColor (XTExtentsion)

+ (UIColor *)xt_colorWithRGB:(uint32_t)rgbValue {
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0f
                           green:((rgbValue & 0xFF00) >> 8) / 255.0f
                            blue:(rgbValue & 0xFF) / 255.0f
                           alpha:1];
}

+ (UIColor *)xt_colorWithRGBA:(uint32_t)rgbaValue {
    return [UIColor colorWithRed:((rgbaValue & 0xFF000000) >> 24) / 255.0f
                           green:((rgbaValue & 0xFF0000) >> 16) / 255.0f
                            blue:((rgbaValue & 0xFF00) >> 8) / 255.0f
                           alpha:(rgbaValue & 0xFF) / 255.0f];
}

+ (UIColor *)xt_colorWithRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0f
                           green:((rgbValue & 0xFF00) >> 8) / 255.0f
                            blue:(rgbValue & 0xFF) / 255.0f
                           alpha:alpha];
}

+ (UIColor *)xt_colorWithHexString:(NSString *)hexStr
{
    CGFloat r = 0.0, g = 0.0, b = 0.0, a = 0.0;
    if (xt_hexStrToRGBA(hexStr, &r, &b, &b, &a)) {
        return [UIColor colorWithRed:r green:g blue:b alpha:a];
    }
    return nil;
    
}

static bool xt_hexStrToRGBA(NSString *str,
                         CGFloat *r,
                         CGFloat *g,
                         CGFloat *b,
                         CGFloat *a) {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    str = [[str stringByTrimmingCharactersInSet:set] uppercaseString];
    if ([str hasPrefix:@"#"]) {
        str = [str substringFromIndex:1];
    } else if ([str hasPrefix:@"0X"]) {
        str = [str substringFromIndex:2];
    }

    NSUInteger length = str.length;
    //GRB               GRBA            GGRRBB          RRGGBBAA
    if (length != 3 && length != 4 && length != 6 && length != 8) {
        return NO;
    }
    
    if (length < 5) {
        *r = xt_hexStrToInt([str substringWithRange:NSMakeRange(0, 1)]) / 255.0f;
        *g = xt_hexStrToInt([str substringWithRange:NSMakeRange(1, 1)]) / 255.0f;
        *b = xt_hexStrToInt([str substringWithRange:NSMakeRange(2, 1)]) / 255.0f;
        if (length == 4)  *a = xt_hexStrToInt([str substringWithRange:NSMakeRange(3, 1)]) / 255.0f;
        else *a = 1;
    } else {
        *r = xt_hexStrToInt([str substringWithRange:NSMakeRange(0, 2)]) / 255.0f;
        *g = xt_hexStrToInt([str substringWithRange:NSMakeRange(2, 2)]) / 255.0f;
        *b = xt_hexStrToInt([str substringWithRange:NSMakeRange(4, 2)]) / 255.0f;
        if (length == 8) *a = xt_hexStrToInt([str substringWithRange:NSMakeRange(6, 2)]) / 255.0f;
        else *a = 1;
    }
    return YES;
}

static inline NSUInteger xt_hexStrToInt(NSString *str) {
    uint32_t result = 0;
    sscanf([str UTF8String], "%X", &result);
    return result;
}

@end
