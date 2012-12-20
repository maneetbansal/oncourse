//
//  OCCrawlerAuthenticationCourse.h
//  OnCourse
//
//  Created by East Agile on 12/8/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCCrawlerAbstractState.h"

@interface OCCrawlerAuthenticationCourseState : OCCrawlerAbstractState <UIWebViewDelegate>

- (id)initWithWebView:(UIWebView *)webview andCourseLink:(NSString *)courseLink andCourseTitle:(NSString *)courseTitle;

@end
