//
//  OCCrawlerLoginState.h
//  OnCourse
//
//  Created by East Agile on 12/2/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCCrawlerAbstractState.h"

@interface OCCrawlerLoginState : OCCrawlerAbstractState <UIWebViewDelegate>

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;

- (id)initWithWebview:(UIWebView *)webview andEmail:(NSString *)email andPassword:(NSString *)password;

@end
