//
//  NSString+size.m
//  MeiTuan
//
//  Created by 何凯楠 on 16/6/20.
//  Copyright © 2016年 HeXiaoBa. All rights reserved.
//

#import "NSString+XTExtension.h"
#include <CommonCrypto/CommonCrypto.h>
#include <zlib.h>

@implementation NSString (XTExtension)

#pragma mark - Size
///=============================================================================
/// @name Size
///=============================================================================

- (CGSize)xt_getSizeWithFont:(UIFont *)font {
    
    return [self xt_getSizeWithFont:font size:CGSizeMake(MAXFLOAT, MAXFLOAT)];
}

- (CGSize)xt_getSizeWithFont:(UIFont *)font size:(CGSize)size {
    return [self xt_getSizeWithFont:font size:size mode:NSLineBreakByWordWrapping];
}

- (CGSize)xt_getSizeWithFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    
    if (!font) {
        font = [UIFont systemFontOfSize:16];
    }
    NSMutableDictionary *attr = [NSMutableDictionary new];
    attr[NSFontAttributeName] = font;
    
    if (lineBreakMode != NSLineBreakByWordWrapping) {
        // 段落样式
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineBreakMode = lineBreakMode;
        attr[NSParagraphStyleAttributeName] = paragraphStyle;
    }
    
    CGSize resultSize = CGSizeZero;
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:context:)]) {
        resultSize = [self boundingRectWithSize:size
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:attr
                                        context:nil].size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        resultSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }

    return resultSize;
}

- (CGFloat)xt_getWidthWithFont:(UIFont *)font {
    CGSize size = [self xt_getSizeWithFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}

- (CGFloat)xt_getHeightWithFont:(UIFont *)font width:(CGFloat)width {
    CGSize size = [self xt_getSizeWithFont:font size:CGSizeMake(width, HUGE) mode:NSLineBreakByWordWrapping];
    return size.height;
}

#pragma mark - Hash
///=============================================================================
/// @name Hash
///=============================================================================
- (NSString *)xt_md5String {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5([self UTF8String], (CC_LONG)self.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

#pragma mark - Attributed
///=============================================================================
/// @name Attributed
///=============================================================================

+ (NSAttributedString *)xt_addAttributesWithText:(NSString *)text effectiveText:(NSString *)effectiveText attrs:(NSDictionary<NSString *, id> *)attrs {
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange range = [text rangeOfString:effectiveText];
    
    if (range.location != NSNotFound) {
        [attr addAttributes:attrs range:range];
    }
    return attr;
}

/**
 给文字添加颜色
 */
+ (NSAttributedString *)xt_addAttributesColorWithText:(NSString *)text effectiveText:(NSString *)effectiveText effectiveColor:(UIColor *)effectiveColor {
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange range = [text rangeOfString:effectiveText];
    NSMutableDictionary *attrDic = [NSMutableDictionary dictionary];
    attrDic[NSForegroundColorAttributeName] = effectiveColor;
    
    if (range.location != NSNotFound) {
        [attr addAttributes:attrDic range:range];
    }
    return attr;
}

/**
 给文字添加中划线
 */
+ (NSAttributedString *)xt_addAttributesMiddleLineWithText:(NSString *)text effectiveText:(NSString *)effectiveText {
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange range = [text rangeOfString:effectiveText];
    NSMutableDictionary *attrDic = [NSMutableDictionary dictionary];
    attrDic[NSStrikethroughStyleAttributeName] = @(NSUnderlineStyleSingle);
    
    if (range.location != NSNotFound) {
        [attr addAttributes:attrDic range:range];
    }
    return attr;
}

#pragma mark - Utilities
///=============================================================================
/// @name Utilities
///=============================================================================
- (NSString *)xt_stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [[self stringByTrimmingCharactersInSet:set] uppercaseString];
}



@end
