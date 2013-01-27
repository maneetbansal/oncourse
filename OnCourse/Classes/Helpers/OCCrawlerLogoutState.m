//
//  OCCrawlerLogoutState.m
//  OnCourse
//
//  Created by East Agile on 1/27/13.
//  Copyright (c) 2013 phatle. All rights reserved.
//

#import "OCCrawlerLogoutState.h"
#import "OCJavascriptFunctions.h"
#import "OCLoginViewController.h"
#import "OCUtility.h"
#import "OCAppDelegate.h"

@interface OCCrawlerLogoutState()

@property (nonatomic, strong) OCLoginViewController *loginViewController;

@end

@implementation OCCrawlerLogoutState

- (id)initWithWebview:(UIWebView *)webview
{
    self = [super init];
    if (self) {
        self.webviewCrawler = webview;
        self.webviewCrawler.delegate = self;
        [self loadRequest:@"https://www.coursera.org/account/logout"];
    }
    return self;
}

- (OCLoginViewController *)loginViewController
{
    if (!_loginViewController) {
        _loginViewController =  [OCLoginViewController new];
    }
    return _loginViewController;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestString = [[request URL] absoluteString];
    NSLog(@"request : %@",requestString);

    if ([requestString hasPrefix:@"js-frame:"]) {
        NSArray *components = [requestString componentsSeparatedByString:@":"];
        NSString *function = (NSString*)[components objectAtIndex:1];

        if ([@"pageLoaded" isEqualToString:function])
        {
            [self removeUserInfo];
            [self presentLoginViewController];
        }
        return NO;
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.webviewCrawler stringByEvaluatingJavaScriptFromString:[[OCJavascriptFunctions sharedInstance] jsCallObjectiveCFunction]];
    [self.webviewCrawler stringByEvaluatingJavaScriptFromString:[[OCJavascriptFunctions sharedInstance] checkPageLoaded]];
}

- (void)removeUserInfo
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"isLogin"];
    [userDefaults removeObjectForKey:@"email"];
    [userDefaults removeObjectForKey:@"password"];
}

- (void)presentLoginViewController
{
    OCAppDelegate *appDelegate = [OCUtility appDelegate];
    [appDelegate.navigationController pushViewController:self.loginViewController animated:YES];
}

@end
