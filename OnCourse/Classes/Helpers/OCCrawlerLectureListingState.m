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
#import "OCLecture.h"
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
    NSDictionary *resDict = [jsonLecture JSONValue];

    NSMutableArray *lectureData = [@[] mutableCopy];
    NSArray *lectures = [resDict objectForKey:@"lectures"];
    for (int i = 0; i < lectures.count; ++i) {
        NSDictionary *sectionDict = [lectures objectAtIndex:i];
        NSString *sectionName = [sectionDict objectForKey:@"section_name"];
        [lectureData addObject:sectionName];
        NSMutableArray *arrayLectures = [@[] mutableCopy];
        NSArray *lectureList = [sectionDict objectForKey:@"lecture"];
        for (int j = 0; j < lectureList.count; ++j) {
        }
        [lectureList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            OCLecture *aLecture = [OCLecture new];
            aLecture.link = [obj objectForKey:@"lecture_link"];
            aLecture.title = [obj objectForKey:@"lecture_title"];
            [arrayLectures addObject:aLecture];
        }];
        [lectureData addObject:arrayLectures];
    }
    [self presentLectureView:lectureData];
    self.webviewCrawler.delegate = nil;
}

- (NSArray *)lectureJsonToLecture:(NSArray *)lectureJson
{
    __block NSArray *lectures = @[];
    [lectureJson enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        OCLecture *aLecture = [[OCLecture alloc] initWithJson:obj];
        lectures = [lectures arrayByAddingObject:aLecture];
    }];
    return lectures;
}

- (void)presentLectureView:(NSMutableArray *)lectureData
{
    OCAppDelegate *delegate = [OCUtility appDelegate];
    OCCourseListingsViewController *courseListingViewController = (OCCourseListingsViewController *)delegate.navigationController.topViewController;
    [courseListingViewController presentLectureViewController:lectureData];
    
}

@end
