//
//  OCUtilityTests.cpp
//  OnCourse
//
//  Created by East Agile on 11/29/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "Kiwi.h"
#import "OCUtility.h"
#import "OCAppDelegate.h"

SPEC_BEGIN(OCUtilitySpecs)
describe(@".appDelegate", ^{
    context(@"get application delegate", ^{
        it(@"should return the application delegate", ^{
            id appDelegate = [OCUtility appDelegate];
            [appDelegate shouldNotBeNil];
            [[appDelegate should] isKindOfClass:[OCAppDelegate class]];
        });
    });
});
SPEC_END