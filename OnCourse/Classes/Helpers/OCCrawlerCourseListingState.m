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
        NSString *argsAsString = [(NSString*)[components objectAtIndex:2]
                                  stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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

- (NSArray *)fetchAllImageCourse
{
    NSString *js = [OCJavascriptFunctions jsFetchAllImageCourse];
    NSString *result = [self.webviewCrawler stringByEvaluatingJavaScriptFromString:js];
    return [[NSString stringWithFormat:@"%@", result] componentsSeparatedByString:@";"];
}

- (NSArray *)fetchAllTitleCourse
{
    NSString *js = [OCJavascriptFunctions jsFetchAllTitleCourse];
    NSString *result = [self.webviewCrawler stringByEvaluatingJavaScriptFromString:js];
    return [[NSString stringWithFormat:@"%@", result] componentsSeparatedByString:@";"];
}

- (NSArray *)fetchAllLinkCourse
{
    NSString *js = [OCJavascriptFunctions jsFetchAllLinkCourse];
    NSString *result = [self.webviewCrawler stringByEvaluatingJavaScriptFromString:js];
    return [[NSString stringWithFormat:@"%@", result] componentsSeparatedByString:@";"];
}

- (NSArray *)fetchAllMetaInfoCourse
{
    NSString *js = [OCJavascriptFunctions jsFetchAllMetaInfoCourse];
    NSString *result = [self.webviewCrawler stringByEvaluatingJavaScriptFromString:js];
    return [[NSString stringWithFormat:@"%@", result] componentsSeparatedByString:@";"];
}

- (NSArray *)fetchAllStatusCourse
{
    NSString *js = [OCJavascriptFunctions jsFetchAllStatusCourse];
    NSString *result = [self.webviewCrawler stringByEvaluatingJavaScriptFromString:js];
    return [[NSString stringWithFormat:@"%@", result] componentsSeparatedByString:@";"];
}

- (NSArray *)fetchAllProgressCourse
{
    NSString *js = [OCJavascriptFunctions jsFetchAllProgressCourse];
    NSString *result = [self.webviewCrawler stringByEvaluatingJavaScriptFromString:js];
    return [[NSString stringWithFormat:@"%@", result] componentsSeparatedByString:@";"];
}

- (void)fetchAllCourse
{
    NSLog(@"fetching all course");
    NSArray *images = [self fetchAllImageCourse];
    NSArray *titles = [self fetchAllTitleCourse];
    NSArray *links = [self fetchAllLinkCourse];
    NSArray *metaInfo = [self fetchAllMetaInfoCourse];
    NSArray *status = [self fetchAllStatusCourse];
    NSArray *progress = [self fetchAllProgressCourse];

    NSMutableArray *courses = [[NSMutableArray alloc] init];
    
    int iProgress = 0;
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    for (int i = 0; i < images.count; ++i) {
        __block OCCourse *aCourse = [[OCCourse alloc] init];
        NSString *imageLink = [NSString stringWithFormat:@"%@", [images objectAtIndex:i ]];
        
        dispatch_async(concurrentQueue, ^{
            dispatch_sync(concurrentQueue, ^{
                NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:imageLink]];
                NSError *downloadError = nil;
                NSData *imageData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:&downloadError];
                if (downloadError == nil && imageData != nil) {
                    aCourse.image = [UIImage imageWithData:imageData];
                }
            });
        });
        
//        aCourse.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageLink]]];
        aCourse.title = [titles objectAtIndex:i];
        aCourse.link = [links objectAtIndex:i];
        aCourse.metaInfo = [metaInfo objectAtIndex:i];
        aCourse.status = [status objectAtIndex:i];
        if ([@"available" isEqualToString:aCourse.status]) {
            aCourse.progress = [[progress objectAtIndex:iProgress] intValue];
            iProgress += 1;
        }
        
        NSLog(imageLink);
        NSLog(aCourse.link);
        NSLog(aCourse.metaInfo);
        NSLog(aCourse.status);
        NSLog([NSString stringWithFormat:@"%i", aCourse.progress]);
        NSLog(@"\n");
        
        [courses addObject:aCourse];
    }
    [self updateCoursesListing:courses];
}

- (void)updateCoursesListing:(NSMutableArray *)courses
{
    OCAppDelegate *appDelegate = [OCUtility appDelegate];
    OCCourseListingsViewController * courseListing = (OCCourseListingsViewController *)appDelegate.navigationController.topViewController;
    [courseListing updateCourseListing:courses];
}

@end
