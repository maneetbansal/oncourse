//
//  OCStartScreenView.m
//  OnCourse
//
//  Created by Ngoc-Nhan Nguyen on 12/25/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCStartScreenView.h"

#define WIDTH_IPHONE_5 640
#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds].size.height == WIDTH_IPHONE_5)

@implementation OCStartScreenView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setNiceScreen];
    }
    return self;
}

- (void)setNiceScreen
{
    if (IS_IPHONE_5)
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"startScreen@2x.png"]]];
    else
       [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"startScreen.png"]]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
