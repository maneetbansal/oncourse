//
//  OCButtonStyle.m
//  OnCourse
//
//  Created by admin on 12/19/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCButtonStyle.h"

@implementation OCButtonStyle


- (UIImage *)imageWithImage:(UIImage *)image scaleToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIButton *)buttonWithDarkBackground:(CGRect)rect
{
    UIButton *result = [[UIButton alloc] initWithFrame:rect];
    
    UIImage *button = [self imageWithImage:[UIImage imageNamed:@"login_button@2x"] scaleToSize:CGSizeMake(rect.size.width, rect.size.height)];
    UIImage *button_down = [self imageWithImage:[UIImage imageNamed:@"login_Down@2x"] scaleToSize:CGSizeMake(rect.size.width, rect.size.height)];
    
    result.translatesAutoresizingMaskIntoConstraints = NO;
    [result setFont:[UIFont fontWithName:@"Livory" size:16]];
    [result setBackgroundImage:button forState:UIControlStateNormal];
    [result setBackgroundImage:button_down forState:UIControlStateSelected];
    
    return result;
}

@end
