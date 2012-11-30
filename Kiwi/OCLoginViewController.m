//
//  OCLoginViewController.m
//  OnCourse
//
//  Created by East Agile on 11/30/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "Kiwi.h"
#import "OCLoginViewController.h"

SPEC_BEGIN(OCLoginViewControllerSpecs)
describe(@"#aloc:init", ^{
    context(@"create login view controller", ^{
        it(@"should not be nil", ^{
            OCLoginViewController *loginViewController = [[OCLoginViewController alloc] init];
            [loginViewController shouldNotBeNil];
        });
        it(@"should call .viewDidload", ^{
            OCLoginViewController *loginViewController = [[OCLoginViewController alloc] init];
            [[loginViewController should] receive:@selector(viewDidLoad)];
            [loginViewController viewDidLoad];
        });
    });
});
SPEC_END