//
//  OCCourseListingsViewControllerTests.cpp
//  OnCourse
//
//  Created by East Agile on 11/30/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "Kiwi.h"
#import "OCCourseListingsViewController.h"

SPEC_BEGIN(OCCourseListingsViewControllerSpecs)
describe(@"#aloc:init", ^{
    context(@"create course listings view controller", ^{
        it(@"should not be nil", ^{
            OCCourseListingsViewController *courseListings = [[OCCourseListingsViewController alloc] init];
            [courseListings shouldNotBeNil];
        });
    });
});
SPEC_END