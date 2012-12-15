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

- (id)initWithWebview:(UIWebView *)webview;

@end
