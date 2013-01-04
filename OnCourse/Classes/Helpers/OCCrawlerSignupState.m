//
//  OCCrawlerSignupState.m
//  OnCourse
//
//  Created by admin on 12/15/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCCrawlerSignupState.h"
#import "OCJavascriptFunctions.h"

@implementation OCCrawlerSignupState

- (id)initWithWebview:(UIWebView *)webview andFullname:(NSString *)fullname andUsername:(NSString *)username andPassword:(NSString *)password
{
    self = [super init];
    if (self){
        self.webviewCrawler = webview;
        self.fullname = fullname;
        self.username = username;
        self.password = password;
        self.webviewCrawler.delegate = self;
        [self loadRequest:@"https://www.coursera.org/account/signup"];
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
        
        if ([@"signup_successfully" isEqualToString:function])
        {
            NSLog([NSString stringWithFormat:@"%@",@"Signup successfully"]);
            [[[UIAlertView alloc] initWithTitle:@"Sign up successfully" message:@"Congratulation! You signed up successfully!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
        else if ([@"pageLoaded" isEqualToString:function])
        {
            [self fillAllElements];
            NSLog(@"Page loaded");
        }
        return NO;
    }
    
    return YES;
}

- (void)fillAllElements
{
    NSString *jsFillSignUpElement = [OCJavascriptFunctions jsFillElement:@"coursera-signup-fullname" withContent:self.fullname];
    [self.webviewCrawler stringByEvaluatingJavaScriptFromString:jsFillSignUpElement];
    NSString *jsFillEmailElement = [OCJavascriptFunctions jsFillElement:@"coursera-signup-email" withContent:self.username];
    [self.webviewCrawler stringByEvaluatingJavaScriptFromString:jsFillEmailElement];
    NSString *jsFillPasswordElement = [OCJavascriptFunctions jsFillElement:@"coursera-signup-password" withContent:self.password];
    [self.webviewCrawler stringByEvaluatingJavaScriptFromString:jsFillPasswordElement];
    NSString *jsCheckAgreeBox = [OCJavascriptFunctions jsCheckCheckbox:@"coursera-signup-agree"];
    [self.webviewCrawler stringByEvaluatingJavaScriptFromString:jsCheckAgreeBox];
    NSString *jsClickSignUpButton = [OCJavascriptFunctions jsClickButton:@"btn btn-success coursera-signup-button"];
    [self.webviewCrawler stringByEvaluatingJavaScriptFromString:jsClickSignUpButton];
    
    [self.webviewCrawler stringByEvaluatingJavaScriptFromString:[OCJavascriptFunctions jsCallObjectiveCFunction]];
    NSString *jsCheckSignUped = [OCJavascriptFunctions jsCheckSignUpSuccessfully];
    [self.webviewCrawler stringByEvaluatingJavaScriptFromString:jsCheckSignUped];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.webviewCrawler stringByEvaluatingJavaScriptFromString:[OCJavascriptFunctions jsCallObjectiveCFunction]];
    [self.webviewCrawler stringByEvaluatingJavaScriptFromString:[OCJavascriptFunctions checkPageLoaded]];
}

@end
