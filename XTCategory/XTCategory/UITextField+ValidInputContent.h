//
//  UITextField+ValidInputContent.h
//  YiZhongShop
//
//  Created by 何凯楠 on 16/7/29.
//  Copyright © 2016年 HeXiaoBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (ValidInputContent)

//输入框中只能输入数字和小数点，且小数点只能输入一位，参数number 可以设置小数的位数，该函数在-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string调用；
+ (BOOL)isValidAboutInputText:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string decimalNumber:(NSInteger)number;

@end
