//
//  OCCrawlerAuthenticationCourse.m
//  OnCourse
//
//  Created by East Agile on 12/8/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCCrawlerAuthenticationCourseState.h"
#import "OCJavascriptFunctions.h"
#import "OCAppDelegate.h"
#import "OCUtility.h"

@interface OCCrawlerAuthenticationCourseState()

@property (nonatomic, strong)NSString *courseLink;

@end

@implementation OCCrawlerAuthenticationCourseState

- (id)initWithWebView:(UIWebView *)webview andCourseLink:(NSString *)courseLink
{
    self = [super init];
    if (self) {
        self.webviewCrawler = webview;
        self.webviewCrawler.delegate = self;
        self.courseLink = courseLink;
        [self loadRequest:courseLink];
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
            BOOL isAuthenticateNeeded = [self checkAuthenticated];
            if (isAuthenticateNeeded)
                [self authenticateCourse];
            else
            {
//                [self loadRequest:[self lectureLink]];
                NSLog(@"authentication course successfully");
            }
        }
        
        return NO;
    }
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.webviewCrawler stringByEvaluatingJavaScriptFromString:[OCJavascriptFunctions jsCallObjectiveCFunction]];
    [self.webviewCrawler stringByEvaluatingJavaScriptFromString:[OCJavascriptFunctions checkPageLoaded]];
}

- (BOOL)checkAuthenticated
{
    NSString *js = [OCJavascriptFunctions jsCheckAuthenticationCourseNeeded];
    NSString *result = [self.webviewCrawler stringByEvaluatingJavaScriptFromString:js];
    if ([@"true" isEqualToString:result])
        return true;
    else
        return false;
}

- (NSString *)lectureLink
{
    NSString *pathToLecture = [self.courseLink stringByDeletingLastPathComponent];
    pathToLecture = [pathToLecture stringByDeletingLastPathComponent];
    pathToLecture = [pathToLecture stringByAppendingString:@"/lecture/index"];
    return pathToLecture;
}

- (void)authenticateCourse
{
    NSString *js = [OCJavascriptFunctions jsAuthenticateCourse];
    NSString *result = [self.webviewCrawler stringByEvaluatingJavaScriptFromString:js];
    [self loadRequest:result];
}

@end
