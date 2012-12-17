//
//  OCCrawlerSignupState.h
//  OnCourse
//
//  Created by admin on 12/15/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCCrawlerAbstractState.h"
#import <Foundation/Foundation.h>

@interface OCCrawlerSignupState : OCCrawlerAbstractState <UIWebViewDelegate>

@property (nonatomic, strong) NSString *fullname;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

- (id)initWithWebview:(UIWebView *)webview andFullname:(NSString *)fullname andUsername:(NSString *)username andPassword:(NSString *)password;

@end
