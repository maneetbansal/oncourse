//
//  Course+CoreData.m
//  OnCourse
//
//  Created by East Agile on 1/10/13.
//  Copyright (c) 2013 phatle. All rights reserved.
//

#import "Course+CoreData.h"
#import "OCUtility.h"
#import "OCAppDelegate.h"
#import "NSManagedObject+Adapter.h"

@implementation Course (CoreData)

+ (void)courseWithInfo:(NSDictionary *)json
{
    Course *course = nil;
    if (![NSManagedObject entityExist:@"Course" withPredicateString:@"(courseID == %@)" andArguments:@[[json objectForKey:@"course_id"]] withSortDescriptionKey:nil]) {
        course = [NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext:[OCUtility appDelegate].managedObjectContext];
        course.courseID = [json objectForKey:@"course_id"];
    }
    else
    {
        course = (Course *)[NSManagedObject findSingleEntity:@"Course" withPredicateString:@"(courseID == %@)" andArguments:@[[json objectForKey:@"course_id"]] withSortDescriptionKey:nil];
    }
    [course updateAttributes:json];
}

+ (void)initCourses:(NSArray *)jsonArray
{
    [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [[self class] courseWithInfo:obj];
    }];
}

- (void)updateAttributes:(NSDictionary *)json
{
    NSArray *jsonAttributes = @[ @"course_image", @"course_name", @"course_link", @"course_meta_info", @"course_status", @"course_progress" ];
    NSArray *properties = @[ @"setImage:", @"setTitle:", @"setLink:",@"setMetaInfo:", @"setStatus:", @"setProgress:" ];
    [jsonAttributes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([json objectForKey:obj] && [json objectForKey:obj] != [NSNull null]) {
            [self performSelector:NSSelectorFromString([properties objectAtIndex:idx]) withObject:[json objectForKey:obj]];
        }
    }];
}

@end
