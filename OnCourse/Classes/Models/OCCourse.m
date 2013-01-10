//
//  OCCourse.m
//  OnCourse
//
//  Created by East Agile on 10/31/12.
//  Copyright (c) 2012 oncourse. All rights reserved.
//

#import "OCCourse.h"

@implementation OCCourse

- (id)initWithJson:(NSDictionary *)json
{
    self = [super init];
    if (self) {
        NSArray *jsonAttributes = @[ @"course_image", @"course_name", @"course_link", @"course_meta_info", @"course_status", @"course_progress" ];
        NSArray *properties = @[ @"setImage:", @"setTitle:", @"setLink:",@"setMetaInfo:", @"setStatus:", @"setProgress:" ];
        [jsonAttributes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([json objectForKey:obj] && [json objectForKey:obj] != [NSNull null]) {
                [self performSelector:NSSelectorFromString([properties objectAtIndex:idx]) withObject:[json objectForKey:obj]];
            }
        }];
    }
    return self;
}

@end
