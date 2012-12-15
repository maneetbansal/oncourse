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

@end
