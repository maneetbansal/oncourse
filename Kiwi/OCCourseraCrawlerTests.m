//
//  OCCourseraCrawlerTests.cpp
//  OnCourse
//
//  Created by East Agile on 12/1/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "Kiwi.h"
#import "OCCourseraCrawler.h"
#import "OCUtility.h"
#import "OCAppDelegate.h"
#import "OCCourseListingsViewController.h"

SPEC_BEGIN(OCCourseraCrawlerSpecs)
describe(@"#aloc:init", ^{
    context(@"create coursera crawler", ^{
        it(@"should not be nil", ^{
            OCCourseraCrawler *crawler = [[OCCourseraCrawler alloc] init];
            [crawler shouldNotBeNil];
        });
    });
});

describe(@"#loginWithEmail:andPassword:", ^{
    context(@"login successfully", ^{
        it(@"should present list course page", ^{
            OCAppDelegate *appDelegate = [OCUtility appDelegate];
            [[appDelegate.navigationController.topViewController.class should] equal:[OCCourseListingsViewController class]];
        });
    });
});

SPEC_END