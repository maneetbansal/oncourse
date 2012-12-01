//
//  OCLoginViewTests.m
//  OnCourse
//
//  Created by East Agile on 11/30/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "Kiwi.h"
#import "OCLoginView.h"

SPEC_BEGIN(OCLoginViewSpecs)
describe(@"#aloc:init", ^{
    context(@"create login view", ^{
        it(@"should not be nil", ^{
            OCLoginView *loginView = [[OCLoginView alloc] init];
            [loginView shouldNotBeNil];
        });
    });
});
SPEC_END