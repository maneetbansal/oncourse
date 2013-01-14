//
//  OCCrawlerLectureListingState.m
//  OnCourse
//
//  Created by East Agile on 12/9/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCCrawlerLectureListingState.h"
#import "OCJavascriptFunctions.h"
#import "OCAppDelegate.h"
#import "OCUtility.h"
#import "OCCourseListingsViewController.h"
#import "Lecture+CoreData.h"
#import <SBJson.h>

@interface OCCrawlerLectureListingState()

@property (nonatomic, strong) NSString *lectureIndexLink;

@end

@implementation OCCrawlerLectureListingState

- (id)initWithWebView:(UIWebView *)webview andLectureIndexLink:(NSString *)lectureIndexLink
{
    self = [super init];
    if (self) {
        self.webviewCrawler = webview;
        self.webviewCrawler.delegate = self;
        self.lectureIndexLink = lectureIndexLink;
        [self loadRequest:lectureIndexLink];
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
            [self fetchAllLectureLinks];
            [self presentLectureView];
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

- (NSString *)executeJSFetchLectureLinks
{
    return [self.webviewCrawler stringByEvaluatingJavaScriptFromString:[OCJavascriptFunctions jsFetchLectureLinks]];
}

- (void)fetchAllLectureLinks
{
    NSLog(@"fetch all lecture links");
    NSString *jsonLecture = [self executeJSFetchLectureLinks];
    NSArray *resArray = [jsonLecture JSONValue];

    [Lecture initLectures:resArray];
    self.webviewCrawler.delegate = nil;
}

- (void)presentLectureView
{
    OCAppDelegate *delegate = [OCUtility appDelegate];
    OCCourseListingsViewController *courseListingViewController = (OCCourseListingsViewController *)delegate.navigationController.topViewController;
    [courseListingViewController presentLectureViewController];
    
}

@end
