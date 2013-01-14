//
//  Lecture+CoreData.h
//  OnCourse
//
//  Created by East Agile on 1/14/13.
//  Copyright (c) 2013 phatle. All rights reserved.
//

#import "Lecture.h"

@interface Lecture (CoreData)

+ (void)initLectures:(NSArray *)jsonArray;

@end
