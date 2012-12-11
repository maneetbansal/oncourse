//
//  OCCrawlerWatchingVideoState.m
//  OnCourse
//
//  Created by admin on 12/10/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//
#import "OCJavascriptFunctions.h"
#import "OCAppDelegate.h"
#import "OCUtility.h"
#import "OCCrawlerWatchingVideoState.h"

@implementation OCCrawlerWatchingVideoState

- (id)initWithWebview:(UIWebView *) webview andVideoLink:(NSString *)videoLink
{
    self = [super init];
    if (self) {
        self.webviewCrawler = webview;
        self.videoLink = videoLink;
        self.webviewCrawler.delegate = self;
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
            
        }
        
        return NO;
    }
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    [self.webviewCrawler stringByEvaluatingJavaScriptFromString:[OCJavascriptFunctions jsCallObjectiveCFunction]];
//    [self.webviewCrawler stringByEvaluatingJavaScriptFromString:[OCJavascriptFunctions checkPageLoaded]];
}

@end
