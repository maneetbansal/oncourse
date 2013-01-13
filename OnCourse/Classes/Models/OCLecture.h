//
//  OCLecture.h
//  OnCourse
//
//  Created by East Agile on 12/12/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCLecture : NSObject

@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *title;

- (id)initWithJson:(NSDictionary *)json;

@end
