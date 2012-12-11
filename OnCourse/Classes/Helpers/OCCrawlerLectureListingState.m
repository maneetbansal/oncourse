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
            NSLog(@"fetch all lecture links");
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

- (void)fetchAllLectureLinks
{
    NSString *result = [self.webviewCrawler stringByEvaluatingJavaScriptFromString:[OCJavascriptFunctions jsFetchLectureLinks]];
    NSArray *sectionItems = [result componentsSeparatedByString:@"|"];
    NSMutableArray *lectureData = [@[] mutableCopy];
    for (int i = 0; i < sectionItems.count; ++i) {
        NSArray *data = [[sectionItems objectAtIndex:i] componentsSeparatedByString:@"^"];
        if (2 == data.count) {
            [lectureData addObject:[data objectAtIndex:0]];
            NSArray *lectures = [[data objectAtIndex:1] componentsSeparatedByString:@";"];
            NSMutableArray *arrayLectures = [@[] mutableCopy];
            [lectures enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSArray *lec = [obj componentsSeparatedByString:@"~"];
                if (2 == lec.count) {
                    OCLecture *aLecture = [OCLecture new];
                    aLecture.link = [lec objectAtIndex:0];
                    aLecture.title = [lec objectAtIndex:1];
                    [arrayLectures addObject:aLecture];
                }
            }];
            [lectureData addObject:arrayLectures];
        }
    }
    [self presentLectureView:lectureData];
}

- (void)presentLectureView:(NSMutableArray *)lectureData
{
    OCAppDelegate *delegate = [OCUtility appDelegate];
    OCCourseListingsViewController *courseListingViewController = (OCCourseListingsViewController *)delegate.navigationController.topViewController;
    [courseListingViewController presentLectureViewController:lectureData];
    
}

@end
