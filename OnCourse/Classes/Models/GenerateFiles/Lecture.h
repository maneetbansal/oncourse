//
//  Lecture.h
//  OnCourse
//
//  Created by East Agile on 1/10/13.
//  Copyright (c) 2013 phatle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Lecture : NSManagedObject

@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSManagedObject *course;

@end
