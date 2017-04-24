//
//  UIBarButtonItem+Extension.h
//  颐惠商城
//
//  Created by 何凯楠 on 15/8/25.
//  Copyright (c) 2015年 何凯楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(UIImage *)image highImage:(UIImage *)highImage;

@end
