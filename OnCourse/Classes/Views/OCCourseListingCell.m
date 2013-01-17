
//  OCCourseListingCell.m
//  OnCourse
//
//  Created by East Agile on 12/5/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCCourseListingCell.h"
#import "Course+CoreData.h"

@implementation OCCourseListingCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)reloadData:(Course *)course
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, self.frame.size.width / 3, self.frame.size.height - 30)];
    self.image.image = [UIImage imageWithData:course.imageData];
    [self addSubview:self.image];

    self.title.text = course.title;
    self.title.font = [UIFont fontWithName:@"Livory-Bold" size:16];
    self.title.backgroundColor = [UIColor colorWithRed:50/255.0 green:128/255.0 blue:200/255.0 alpha:0.7];
    [self addSubview:self.title];
    
    self.metaInfo.numberOfLines = 2;
    self.metaInfo.text = course.metaInfo;
    self.metaInfo.backgroundColor = [UIColor clearColor];
    self.metaInfo.font = [UIFont fontWithName:@"Livory" size:12];
    [self addSubview:self.metaInfo];
    self.backgroundColor = [UIColor clearColor];
    
    
    if ([@"disabled" isEqualToString:course.status])
    {
        UIView *overlapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        overlapView.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:0.5];
        [self addSubview:overlapView];
        [self.image setImage:[self convertToBlackWhiteImage:self.image.image]];
    }
    else
    {
        self.progressBar = [[UIProgressView alloc] initWithFrame:CGRectMake(self.frame.size.width / 3 + 20, self.frame.size.height / 7 * 6, self.frame.size.width / 3 * 2 - 40, self.frame.size.height / 7)];
        
        if ([@"archive" isEqualToString:course.status]) {
            course.progress = @100;
            [self.progressBar setProgressViewStyle:UIProgressViewStyleBar];
        } else {
            [self.progressBar setProgressViewStyle:UIProgressViewStyleDefault];
        }
        
        self.progressBar.progress = [course.progress floatValue] / 100;
        [self addSubview:self.progressBar];
    }
}

- (UIImage *)convertToBlackWhiteImage:(UIImage *)image
{
    UIImage *result;
    CGColorSpaceRef colorSapce = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8, image.size.width, colorSapce, kCGImageAlphaNone);

    if (context != nil) {
        CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
        CGContextSetShouldAntialias(context, NO);
        CGContextDrawImage(context, CGRectMake(0, 0, image.size.width, image.size.height), [image CGImage]);
        
        CGImageRef bwImage = CGBitmapContextCreateImage(context);
        CGContextRelease(context);
        CGColorSpaceRelease(colorSapce);
        
        result = [UIImage imageWithCGImage:bwImage]; // This is result B/W image.
        CGImageRelease(bwImage);
    }

    return result;
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