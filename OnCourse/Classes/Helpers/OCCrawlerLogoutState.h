//
//  OCCrawlerLogoutState.h
//  OnCourse
//
//  Created by East Agile on 1/27/13.
//  Copyright (c) 2013 phatle. All rights reserved.
//

#import "OCCrawlerAbstractState.h"

@interface OCCrawlerLogoutState : OCCrawlerAbstractState <UIWebViewDelegate>

- (id)initWithWebview:(UIWebView *)webview;

@end
