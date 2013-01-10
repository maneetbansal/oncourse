//
//  OCCrawlerCourseListingState.m
//  OnCourse
//
//  Created by East Agile on 12/2/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCCrawlerCourseListingState.h"
#import "OCJavascriptFunctions.h"
#import "OCAppDelegate.h"
#import "OCUtility.h"
#import "OCCourse.h"
#import "OCCourseListingsViewController.h"
#import <SBJson.h>

@interface OCCrawlerCourseListingState()

@end

@implementation OCCrawlerCourseListingState

- (id)initWithWebview:(UIWebView *)webview
{
    self = [super init];
    if (self) {
        self.webviewCrawler = webview;
        self.webviewCrawler.delegate = self;
        [self loadRequest:@"https://www.coursera.org/"];
    }
    return self;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *requestString = [[request URL] absoluteString];
    
    NSLog(@"request : %@",requestString);
    
    if ([requestString hasPrefix:@"js-frame:"]) {
        
        NSArray *components = [requestString componentsSeparatedByString:@":"];
        
        NSString *function = (NSString*)[components objectAtIndex:1];
        if ([@"pageLoaded" isEqualToString:function]) {
            [self fetchAllCourse];
        }
        
        return NO;
    }
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.webviewCrawler stringByEvaluatingJavaScriptFromString:[OCJavascriptFunctions jsCallObjectiveCFunction]];
    [self.webviewCrawler stringByEvaluatingJavaScriptFromString:[OCJavascriptFunctions checkCourseLoaded]];
}

- (NSString *)executeJSFetchCourses
{
    return [self.webviewCrawler stringByEvaluatingJavaScriptFromString:[OCJavascriptFunctions jsFetchAllCourses]];
}

- (void)fetchAllCourse
{
    NSLog(@"fetching all course");
    NSString *jsonCourses = [self executeJSFetchCourses];
    NSArray *resDict = [jsonCourses JSONValue];

    [self updateCoursesListing:[self coursesJsonToCourse:resDict]];
}

- (NSArray *)coursesJsonToCourse:(NSArray *)coursesJson
{
    __block NSArray *courses = @[];
    [coursesJson enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        OCCourse *aCourse = [[OCCourse alloc] initWithJson:obj];
        courses = [courses arrayByAddingObject:aCourse];
    }];
    return courses;
}

- (void)updateCoursesListing:(NSArray *)courses
{
    OCAppDelegate *appDelegate = [OCUtility appDelegate];
    OCCourseListingsViewController * courseListing = (OCCourseListingsViewController *)appDelegate.navigationController.topViewController;
    [courseListing updateCourseListing:courses];
}

@end
