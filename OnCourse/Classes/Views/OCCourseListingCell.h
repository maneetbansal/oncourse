//
//  OCCourseListingCell.h
//  OnCourse
//
//  Created by East Agile on 12/5/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Course;

@interface OCCourseListingCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *metaInfo;
@property (nonatomic, strong) __block UIImageView *image;
@property (nonatomic, strong) UIProgressView *progressBar;

- (void)reloadData:(Course *)course;

@end
