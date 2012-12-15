//
//  OCCrawlerSignupState.m
//  OnCourse
//
//  Created by admin on 12/15/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCCrawlerSignupState.h"

@implementation OCCrawlerSignupState

- (id)initWithWebview:(UIWebView *)webview
{
    self = [super init];
    if (self){
        self.webviewCrawler = webview;
        self.webviewCrawler.delegate = self;
    }
    return self;
}



@end
