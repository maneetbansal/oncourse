//
//  NSManagedObject+Adapter.h
//  OnCourse
//
//  Created by East Agile on 1/10/13.
//  Copyright (c) 2013 phatle. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Adapter)

+ (NSArray *)findEntities:(NSString *)entityName withPredicateString:(NSString *)predicateString andArguments:(NSArray *)arguments withSortDescriptionKey:(NSDictionary *)sortKeys;
+ (NSManagedObject *)findSingleEntity:(NSString *)entityName withPredicateString:(NSString *)predicateString andArguments:(NSArray *)arguments withSortDescriptionKey:(NSDictionary *)sortKeys;
+ (BOOL)entityExist:(NSString *)entityName withPredicateString:(NSString *)predicateString andArguments:(NSArray *)arguments withSortDescriptionKey:(NSDictionary *)sortKeys;
+ (void)removeEntity:(NSString *)entityName withPredicateString:(NSString *)predicateString andArguments:(NSArray *)arguments withSortDescriptionKey:(NSDictionary *)sortKeys;

@end
