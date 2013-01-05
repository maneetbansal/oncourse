//
//  UIButton+Style.m
//  OnCourse
//
//  Created by Ngoc-Nhan Nguyen on 1/2/13.
//  Copyright (c) 2013 phatle. All rights reserved.
//

#import "UIButton+Style.h"

@implementation UIButton (Style)

+ (UIButton *)buttonBigWithDarkBackgroundStyleAndTitle:(NSString *)title
{
    return [self buttonWithImage:@"login_button" andFontSize:20 andTitle:title];
}


+ (UIButton *)buttonSmallWithDarkBackgroundStyleAndTitle:(NSString *)title
{
    return [self buttonWithImage:@"login_button" andFontSize:16 andTitle:title];
}

+ (UIButton *)buttonWithBackStyleAndTitle:(NSString *)title
{
    return [self buttonWithImage:@"back_button" andFontSize:16 andTitle:title];
}

+ (UIButton *)buttonWithImage:(NSString *)image andFontSize:(int)fontSize andTitle:(NSString *)title
{
    UIButton *result = [[UIButton alloc] init];
    result.translatesAutoresizingMaskIntoConstraints = NO;
    result.titleLabel.font = [UIFont fontWithName:@"Livory" size:fontSize];
    [result setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [result setTitle:title forState:UIControlStateNormal];
    return result;
}

@end
