//
//  OCUtility.m
//  OnCourse
//
//  Created by East Agile on 11/29/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCUtility.h"
#import "OCAppDelegate.h"

@implementation OCUtility

+ (OCAppDelegate *)appDelegate
{
    return (OCAppDelegate *)[[UIApplication sharedApplication] delegate];
}

@end
