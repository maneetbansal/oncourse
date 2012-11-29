//
//  Kiwi.m
//  Kiwi
//
//  Created by East Agile on 11/29/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "Kiwi.h"

SPEC_BEGIN(MathSpec)

describe(@"Math", ^{
    it(@"is pretty cool", ^{
        NSUInteger a = 16;
        NSUInteger b = 26;
        [[theValue(a + b) should] equal:theValue(42)];
    });
});

SPEC_END