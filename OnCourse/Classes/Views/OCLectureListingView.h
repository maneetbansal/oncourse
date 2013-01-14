//
//  OCLectureListingView.h
//  OnCourse
//
//  Created by East Agile on 12/11/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCLectureListingView : UIView <UITableViewDataSource, UITableViewDelegate>

- (void)reloadData;

@end
