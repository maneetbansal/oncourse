//
//  User+CoreData.h
//  OnCourse
//
//  Created by East Agile on 1/27/13.
//  Copyright (c) 2013 phatle. All rights reserved.
//

#import "User.h"
@class Course;

@interface User (CoreData)

+ (void)initWithInfo:(NSDictionary *)json;
- (void)addACourse:(Course *)course;

@end
