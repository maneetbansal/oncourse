//
//  OCLecture.m
//  OnCourse
//
//  Created by East Agile on 12/12/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCLecture.h"

@implementation OCLecture

- (id)initWithJson:(NSDictionary *)json
{
    self = [super init];
    if (self) {
        NSArray *jsonAttributes = @[@"lecture_link", @"lecture_title"];
        NSArray *properties = @[@"setLink:", @"setTitle:"];
        [jsonAttributes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([json objectForKey:obj] && [json objectForKey:obj] != [NSNull null]) {
                [self performSelector:NSSelectorFromString([properties objectAtIndex:idx]) withObject:[json objectForKey:obj]];
            }
        }];
    }
    return self;
}

@end
