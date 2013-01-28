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
#import <AFImageRequestOperation.h>
#import "User+CoreData.h"

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
    [[OCUtility appDelegate] saveContext];
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
    if (!self.imageData || ![self imageFromData])
        [self pullImage];
    [self updateUserInfo];
}

- (UIImage *)imageFromData
{
    return [UIImage imageWithData:self.imageData];
}

- (void)pullImage
{
    // download the photo
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.image]];
    AFImageRequestOperation *operator = [AFImageRequestOperation imageRequestOperationWithRequest:request success:^(UIImage *image) {
        NSData *imageData = UIImagePNGRepresentation(image);
        self.imageData = imageData;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ImageDownloaded" object:nil];
    }];
    [operator start];
}

- (void)updateUserInfo
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    User *user = (User *)[NSManagedObject findSingleEntity:@"User" withPredicateString:@"(email == %@)" andArguments:@[[userDefaults objectForKey:@"email"]] withSortDescriptionKey:nil];
    if (user)
        [user addACourse:self];
}

@end
