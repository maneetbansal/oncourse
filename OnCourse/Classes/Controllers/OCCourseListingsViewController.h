//
//  OCCourseListingsViewController.h
//  OnCourse
//
//  Created by East Agile on 11/29/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCCourseListingsViewController : UIViewController

@property (nonatomic, strong) NSString *courseTitle;

- (void)updateCourseListing:(NSArray *)courses;
- (void)presentLectureViewController:(NSMutableArray *)lectureData;

@end
