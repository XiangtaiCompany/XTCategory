//
//  UIBarButtonItem+Extension.m
//  颐惠商城
//
//  Created by 何凯楠 on 15/8/25.
//  Copyright (c) 2015年 何凯楠. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(UIImage *)image highImage:(UIImage *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];

    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
