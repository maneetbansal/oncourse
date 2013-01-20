//
//  Data+Coredata.m
//  OnCourse
//
//  Created by East Agile on 1/18/13.
//  Copyright (c) 2013 phatle. All rights reserved.
//

#import "Data+Coredata.h"
#import "NSManagedObject+Adapter.h"
#import "OCUtility.h"
#import "OCAppDelegate.h"

@implementation Data (Coredata)

+ (void)dataWithInfo:(NSDictionary *)json
{
    Data *data = nil;
    if (![NSManagedObject entityExist:@"Data" withPredicateString:@"(dataID == %@)" andArguments:@[[json objectForKey:@"data_id"]] withSortDescriptionKey:nil]) {
        data = [NSEntityDescription insertNewObjectForEntityForName:@"Data" inManagedObjectContext:[OCUtility appDelegate].managedObjectContext];
        data.dataID = [json objectForKey:@"data_id"];
    }
    else
    {
        data = (Data *)[NSManagedObject findSingleEntity:@"Data" withPredicateString:@"(dataID == %@)" andArguments:@[[json objectForKey:@"data_id"]] withSortDescriptionKey:nil];
    }
    [data updateAttributes:json];
    [[OCUtility appDelegate] saveContext];
}

- (void)updateAttributes:(NSDictionary *)json
{
    self.javascript = [json objectForKey:@"javascript"];
}
@end
