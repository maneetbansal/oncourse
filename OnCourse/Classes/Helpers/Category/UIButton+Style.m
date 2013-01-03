//
//  UIButton+Style.m
//  OnCourse
//
//  Created by Ngoc-Nhan Nguyen on 1/2/13.
//  Copyright (c) 2013 phatle. All rights reserved.
//

#import "UIButton+Style.h"

@implementation UIButton (Style)

+ (UIButton *)buttonWithDarkBackgroundStyle
{
    UIButton *result = [[UIButton alloc] init];

    result.titleLabel.font = [UIFont fontWithName:@"Livory" size:16];
    [result setBackgroundImage:[UIImage imageNamed:@"login_button"] forState:UIControlStateNormal];
    return result;
}

@end
