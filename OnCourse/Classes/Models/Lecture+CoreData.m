//
//  Lecture+CoreData.m
//  OnCourse
//
//  Created by East Agile on 1/14/13.
//  Copyright (c) 2013 phatle. All rights reserved.
//

#import "Lecture+CoreData.h"
#import "NSManagedObject+Adapter.h"
#import "OCUtility.h"
#import "OCAppDelegate.h"
#import "Course+CoreData.h"

@implementation Lecture (CoreData)

+ (void)lectureWithInfo:(NSDictionary *)json
{
    Lecture *lecture = nil;
    if (![NSManagedObject entityExist:@"Lecture" withPredicateString:@"(lectureID == %@)" andArguments:@[[json objectForKey:@"lecture_id"] ] withSortDescriptionKey:nil]) {
        lecture = [NSEntityDescription insertNewObjectForEntityForName:@"Lecture" inManagedObjectContext:[OCUtility appDelegate].managedObjectContext];
        lecture.lectureID = [json objectForKey:@"lecture_id"];
    }
    else
    {
        lecture = (Lecture *)[NSManagedObject findSingleEntity:@"Lecture" withPredicateString:@"(lectureID == %@)" andArguments:@[[json objectForKey:@"lecture_id"]] withSortDescriptionKey:nil];
    }
    [lecture updateAttributes:json];
}

+ (void)initLectures:(NSArray *)jsonArray
{
    [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [[self class] lectureWithInfo:obj];
    }];
}

- (void)updateAttributes:(NSDictionary *)json
{
    NSArray *jsonAttributes = @[ @"lecture_link", @"lecture_title", @"lecture_section", @"lecture_section_index" ];
    NSArray *properties = @[ @"setLink:", @"setTitle:", @"setSection:", @"setSectionIndex:" ];
    [jsonAttributes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([json objectForKey:obj] && [json objectForKey:obj] != [NSNull null]) {
            [self performSelector:NSSelectorFromString([properties objectAtIndex:idx]) withObject:[json objectForKey:obj]];
        }
    }];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"currentCourseID"]) {
        Course *course = (Course *)[NSManagedObject findSingleEntity:@"Course" withPredicateString:@"(courseID == %@)" andArguments:@[[userDefaults objectForKey:@"currentCourseID"]] withSortDescriptionKey:nil];
        self.course = course;
    }
}

@end
