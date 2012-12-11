//
//  OCCrawlerLectureListingState.h
//  OnCourse
//
//  Created by East Agile on 12/9/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCCrawlerAbstractState.h"

@interface OCCrawlerLectureListingState : OCCrawlerAbstractState <UIWebViewDelegate>

- (id)initWithWebView:(UIWebView *)webview andLectureIndexLink:(NSString *)lectureIndexLink;

@end
