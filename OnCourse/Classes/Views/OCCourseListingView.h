//
//  OCCourseListingView.h
//  OnCourse
//
//  Created by East Agile on 12/3/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCCourseListingView : UIView <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *listAllCourse;

- (void)reloadData;
- (void)orientationChanged;

@end
