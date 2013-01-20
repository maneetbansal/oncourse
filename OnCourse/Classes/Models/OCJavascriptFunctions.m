//
//  OCJavascriptFunctions.m
//  OnCourse
//
//  Created by East Agile on 12/2/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCJavascriptFunctions.h"
#import "OCAppDelegate.h"
#import "NSManagedObject+Adapter.h"
#import "OCUtility.h"
#import "Data+Coredata.h"
#import <SBJson.h>

@interface OCJavascriptFunctions()

@property (nonatomic, strong) NSDictionary *jsonJavascriptFunctions;

@end


@implementation OCJavascriptFunctions

+ (OCJavascriptFunctions *)sharedInstance
{
    static OCJavascriptFunctions * instance = nil;

    static dispatch_once_t createIns;
    dispatch_once(&createIns, ^{
        // --- call to super avoids a deadlock with the above allocWithZone
        instance = [[OCJavascriptFunctions alloc] init];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
         Data *data = (Data *)[NSManagedObject findSingleEntity:@"Data" withPredicateString:@"(dataID == %@)" andArguments:@[ @1 ] withSortDescriptionKey:nil];
        self.jsonJavascriptFunctions = [data.javascript JSONValue];
    }
    return self;
}

- (NSString *)jsLogin
{
    return [self.jsonJavascriptFunctions objectForKey:@"jsLogin"];
}

- (NSString *)jsFillElement:(NSString *)element withContent:(NSString *)content
{
    return [NSString stringWithFormat:[self.jsonJavascriptFunctions objectForKey:@"jsFillElement"],element, content];
}

- (NSString *)jsCheckCheckbox:(NSString *)checkboxId
{
    return [NSString stringWithFormat:[self.jsonJavascriptFunctions objectForKey:@"jsCheckCheckbox"],checkboxId];
}

- (NSString *)jsClickButton:(NSString *)buttonClassName
{
    return [NSString stringWithFormat:[self.jsonJavascriptFunctions objectForKey:@"jsClickButton"],buttonClassName];
}

- (NSString *)jsSimulateKeyupEvent:(NSString *)elementId
{
    return [NSString stringWithFormat:[self.jsonJavascriptFunctions objectForKey:@"jsSimulateKeyupEvent"], elementId ];
}

- (NSString *)jsCallObjectiveCFunction
{
    return [self.jsonJavascriptFunctions objectForKey:@"jsCallObjectiveCFunction"];
}

- (NSString *)checkLogined
{
    return [self.jsonJavascriptFunctions objectForKey:@"checkLogined"];
}

- (NSString *)checkPageLoaded
{
    return [self.jsonJavascriptFunctions objectForKey:@"checkPageLoaded"];
    
}

- (NSString *)checkCourseLoaded
{
    return [self.jsonJavascriptFunctions objectForKey:@"checkCourseLoaded"];
}

- (NSString *)jsCheckAuthenticationCourseNeeded
{
    return [self.jsonJavascriptFunctions objectForKey:@"jsCheckAuthenticationCourseNeeded"];
}

- (NSString *)jsAuthenticateCourse
{
    return [self.jsonJavascriptFunctions objectForKey:@"jsAuthenticateCourse"];
}

- (NSString *)jsFetchLectureLinks
{
    return [self.jsonJavascriptFunctions objectForKey:@"jsFetchLectureLinks"];
}

- (NSString *)jsPlayLectureVideo
{
    return [self.jsonJavascriptFunctions objectForKey:@"jsPlayLectureVideo"];
}

- (NSString *)jsGetDirectLink
{
    return [self.jsonJavascriptFunctions objectForKey:@"jsGetDirectLink"];
}

- (NSString *)jsCheckSignUpSuccessfully
{
    return [self.jsonJavascriptFunctions objectForKey:@"jsCheckSignUpSuccessfully"];
}

- (NSString *)jsFetchAllCourses
{
    return [self.jsonJavascriptFunctions objectForKey:@"jsFetchAllCourses"];
}

@end
