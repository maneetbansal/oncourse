//
//  OCCrawlerCourseListingState.h
//  OnCourse
//
//  Created by East Agile on 12/2/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCCrawlerAbstractState.h"

@interface OCCrawlerCourseListingState : OCCrawlerAbstractState <UIWebViewDelegate>

- (id)initWithWebview:(UIWebView *)webview;

@end
