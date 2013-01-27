//
//  User+CoreData.m
//  OnCourse
//
//  Created by East Agile on 1/27/13.
//  Copyright (c) 2013 phatle. All rights reserved.
//

#import "User+CoreData.h"
#import "OCUtility.h"
#import "OCAppDelegate.h"
#import "NSManagedObject+Adapter.h"
#import "Course+CoreData.h"

@implementation User (CoreData)

+ (void)initWithInfo:(NSDictionary *)json
{
    User *user = nil;
    if (![NSManagedObject entityExist:@"User" withPredicateString:@"(email == %@)" andArguments:@[[json objectForKey:@"email"]] withSortDescriptionKey:nil]) {
        user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:[OCUtility appDelegate].managedObjectContext];
        user.email = [json objectForKey:@"email"];
    }
    else
    {
        user = (User *)[NSManagedObject findSingleEntity:@"User" withPredicateString:@"(email == %@)" andArguments:@[[json objectForKey:@"email"]] withSortDescriptionKey:nil];
    }
    [user updateAttributes:json];
    [[OCUtility appDelegate] saveContext];
}

- (void)updateAttributes:(NSDictionary *)json
{
    self.password = [json objectForKey:@"password"];
}

- (void)addACourse:(Course *)course
{
    if ([[self.courses filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"courseID == %@" argumentArray:@[course.courseID]]] count] == 0)
        self.courses = [self.courses setByAddingObject:course];
}

@end
