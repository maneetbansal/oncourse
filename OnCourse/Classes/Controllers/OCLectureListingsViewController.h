//
//  OCLectureListingsViewController.h
//  OnCourse
//
//  Created by East Agile on 12/11/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCLectureListingsViewController : UIViewController

@property (nonatomic, strong) NSString *selectedVideoTitle;

- (id)initWithLectureData:(NSMutableArray *)lectureData;

@end
