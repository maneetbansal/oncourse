//
//  OCCrawlerLoginState.m
//  OnCourse
//
//  Created by East Agile on 12/2/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCCrawlerLoginState.h"
#import "OCJavascriptFunctions.h"
#import "OCCrawlerCourseListingState.h"
#import "OCAppDelegate.h"
#import "OCUtility.h"
#import "OCCourseListingsViewController.h"
#import "User+CoreData.h"
#import <MBProgressHUD.h>

@interface OCCrawlerLoginState()

@property (nonatomic, strong) OCCourseListingsViewController *courseListingsViewController;

@end

@implementation OCCrawlerLoginState

- (id)initWithWebview:(UIWebView *)webview andEmail:(NSString *)email andPassword:(NSString *)password
{
    self = [super init];
    if (self) {
        self.webviewCrawler = webview;
        self.email = email;
        self.password = password;
        self.webviewCrawler.delegate = self;
        [self loadRequest:@"https://www.coursera.org/account/signin"];
    }
    return self;
}

- (void)loginWithEmail:(NSString *)email andPassword:(NSString *)password
{
    [self.webviewCrawler stringByEvaluatingJavaScriptFromString:[[OCJavascriptFunctions sharedInstance] jsFillElement:@"signin-email" withContent:email]];
    [self.webviewCrawler stringByEvaluatingJavaScriptFromString:[[OCJavascriptFunctions sharedInstance] jsFillElement:@"signin-password" withContent:password]];
    [self.webviewCrawler stringByEvaluatingJavaScriptFromString:[[OCJavascriptFunctions sharedInstance] jsLogin]];
    [self.webviewCrawler stringByEvaluatingJavaScriptFromString:[[OCJavascriptFunctions sharedInstance] jsCallObjectiveCFunction]];
    [self.webviewCrawler stringByEvaluatingJavaScriptFromString:[[OCJavascriptFunctions sharedInstance] checkLogined]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *requestString = [[request URL] absoluteString];
    
    NSLog(@"request : %@",requestString);
    
    if ([requestString hasPrefix:@"js-frame:"]) {
        
        NSArray *components = [requestString componentsSeparatedByString:@":"];
        
        NSString *function = (NSString*)[components objectAtIndex:1];
        
        if ([@"login_successfully" isEqualToString:function]) {
            if ([self.crawlerDelegate respondsToSelector:@selector(changeState:)]) {
                [MBProgressHUD hideHUDForView:[OCUtility appDelegate].navigationController.topViewController.view animated:YES];
                [self.crawlerDelegate changeState:[[OCCrawlerCourseListingState alloc] initWithWebview:self.webviewCrawler]];
                NSLog(@"Login_ successfully");
                [self saveUserInfo];
            }
        }
        else if ([@"login_fail" isEqualToString:function])
        {
            [MBProgressHUD hideHUDForView:[OCUtility appDelegate].navigationController.topViewController.view animated:YES];
            [[[UIAlertView alloc] initWithTitle:@"Login Fail" message:@"Please check your email and password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
        }
        else if ([@"pageLoaded" isEqualToString:function])
        {
            NSLog(@"call login javascript function");
            [self loginWithEmail:self.email andPassword:self.password];
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

- (void)saveUserInfo
{
    [User initWithInfo:@{ @"email" : self.email, @"password" : self.password }];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults objectForKey:@"email"]) {
        [userDefaults setObject:@"Logined" forKey:@"isLogin"];
        [userDefaults setObject:self.email forKey:@"email"];
        [userDefaults setObject:self.password forKey:@"password"];
        [self presentCourseListingsViewController];
    }
}

- (void)presentCourseListingsViewController
{
    OCAppDelegate *appDelegate = [OCUtility appDelegate];
    self.courseListingsViewController = [OCCourseListingsViewController new];
    [appDelegate.navigationController pushViewController:self.courseListingsViewController animated:YES];
}

@end
