//
//  OCCrawlerSignupState.m
//  OnCourse
//
//  Created by admin on 12/15/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCCrawlerSignupState.h"

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



@end
