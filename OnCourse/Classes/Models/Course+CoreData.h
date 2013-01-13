//
//  Course+CoreData.h
//  OnCourse
//
//  Created by East Agile on 1/10/13.
//  Copyright (c) 2013 phatle. All rights reserved.
//

#import "Course.h"

@interface Course (CoreData)

+ (void)courseWithInfo:(NSDictionary *)json;
+ (void)initCourses:(NSArray *)jsonArray;

- (void)updateAttributes:(NSDictionary *)json;

@end
