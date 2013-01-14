//
//  Lecture.h
//  OnCourse
//
//  Created by East Agile on 1/14/13.
//  Copyright (c) 2013 phatle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Course;

@interface Lecture : NSManagedObject

@property (nonatomic, retain) NSNumber * lectureID;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * section;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * sectionIndex;
@property (nonatomic, retain) Course *course;

@end
