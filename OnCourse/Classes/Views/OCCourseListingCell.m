//
//  OCCourseListingCell.m
//  OnCourse
//
//  Created by East Agile on 12/5/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCCourseListingCell.h"
#import "OCCourse.h"

@implementation OCCourseListingCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)reloadData:(OCCourse *)course
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.image setImage:course.image];
    [self addSubview:self.image];
    
    self.title.text = course.title;
    self.title.backgroundColor = [UIColor colorWithRed:50/255.0 green:128/255.0 blue:200/255.0 alpha:0.7];
    [self addSubview:self.title];
    
    self.metaInfo.numberOfLines = 2;
    self.metaInfo.text = [course.metaInfo stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    self.metaInfo.backgroundColor = [UIColor clearColor];
    self.metaInfo.font = [UIFont fontWithName:@"Livory" size:12];
    [self addSubview:self.metaInfo];
    self.backgroundColor = [UIColor clearColor];
    
    self.progressBar = [[UIProgressView alloc] initWithFrame:CGRectMake(self.frame.size.width / 7 * 4, self.frame.size.height / 7 * 6, self.frame.size.width / 7 * 2.7, self.frame.size.height / 7)];
    [self.progressBar setProgressViewStyle:UIProgressViewStyleDefault];
    
    if ([@"disabled" isEqualToString:course.status])
    {
        self.progressBar.progress = 1.0;
    }
    else
    {
        self.progressBar.progress = (float)course.progress / 100;
    }
    
    [self addSubview:self.progressBar];
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
