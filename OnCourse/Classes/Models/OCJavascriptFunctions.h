//
//  OCJavascriptFunctions.h
//  OnCourse
//
//  Created by East Agile on 12/2/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCJavascriptFunctions : NSObject

+ (NSString *)jsLogin;
+ (NSString *)jsFillElement:(NSString *)element withContent:(NSString *)content;
+ (NSString *)checkLogined;
+ (NSString *)jsCallObjectiveCFunction;
+ (NSString *)checkPageLoaded;
+ (NSString *)jsCheckAuthenticationCourseNeeded;
+ (NSString *)jsAuthenticateCourse;
+ (NSString *)jsFetchLectureLinks;
+ (NSString *)jsPlayLectureVideo;
+ (NSString *)checkCourseLoaded;
+ (NSString *)jsCheckCheckbox:(NSString *)checkboxId;
+ (NSString *)jsClickButton:(NSString *)buttonClassName;
+ (NSString *)jsCheckSignUpSuccessfully;
+ (NSString *)jsGetDirectLink;
+ (NSString *)jsSimulateKeyupEvent:(NSString *)elementId;
+ (NSString *)jsFetchAllCourses;

@end
