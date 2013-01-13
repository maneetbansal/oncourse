//
//  NSManagedObject+Adapter.m
//  OnCourse
//
//  Created by East Agile on 1/10/13.
//  Copyright (c) 2013 phatle. All rights reserved.
//

#import "NSManagedObject+Adapter.h"
#import "OCUtility.h"
#import "OCAppDelegate.h"

@implementation NSManagedObject (Adapter)

+ (NSFetchRequest *)getFetchRequest:(NSString *)entityName
                withPredicateString:(NSString *)predicateString
                       andArguments:(NSArray *)arguments
            withSortDescriptionKeys:(NSDictionary *)keys {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    if (predicateString)
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:predicateString argumentArray:arguments]];
    if (keys){
        NSMutableArray *sortDescriptions = [[NSMutableArray alloc] initWithCapacity:keys.count];
        for (NSString *key in keys) {
            [sortDescriptions addObject:[[NSSortDescriptor alloc] initWithKey:key ascending:[(NSNumber *)([keys objectForKey:key]) boolValue]]];
        }
        [fetchRequest setSortDescriptors:sortDescriptions];
    }
    return fetchRequest;
}

+ (NSArray *)findEntities:(NSString *)entityName
      withPredicateString:(NSString *)predicateString
             andArguments:(NSArray *)arguments
   withSortDescriptionKey:(NSDictionary *)sortKeys {
    NSFetchRequest *fetchRequest = [[self class] getFetchRequest:entityName withPredicateString:predicateString andArguments:arguments withSortDescriptionKeys:sortKeys];
    return [[OCUtility appDelegate].managedObjectContext executeFetchRequest:fetchRequest error:nil];
}

+ (NSManagedObject *)findSingleEntity:(NSString *)entityName
                  withPredicateString:(NSString *)predicateString
                         andArguments:(NSArray *)arguments
               withSortDescriptionKey:(NSDictionary *)sortKeys {
    return [[[self class] findEntities:entityName withPredicateString:predicateString andArguments:arguments withSortDescriptionKey:sortKeys] lastObject];
}

+ (BOOL)entityExist:(NSString *)entityName withPredicateString:(NSString *)predicateString andArguments:(NSArray *)arguments withSortDescriptionKey:(NSDictionary *)sortKeys {
    NSFetchRequest *fetchRequest = [[self class] getFetchRequest:entityName withPredicateString:predicateString andArguments:arguments withSortDescriptionKeys:sortKeys];
    return [[OCUtility appDelegate].managedObjectContext countForFetchRequest:fetchRequest error:nil] > 0;
}

+ (void)removeEntity:(NSString *)entityName withPredicateString:(NSString *)predicateString andArguments:(NSArray *)arguments withSortDescriptionKey:(NSDictionary *)sortKeys {
    NSManagedObject *object = [self findSingleEntity:entityName withPredicateString:predicateString andArguments:arguments withSortDescriptionKey:sortKeys];
    [[OCUtility appDelegate].managedObjectContext deleteObject:object];
    [[OCUtility appDelegate] saveContext];
}

@end
