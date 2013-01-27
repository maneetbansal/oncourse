//
//  Course.h
//  OnCourse
//
//  Created by East Agile on 1/27/13.
//  Copyright (c) 2013 phatle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Lecture, User;

@interface Course : NSManagedObject

@property (nonatomic, retain) NSNumber * courseID;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSData * imageData;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * metaInfo;
@property (nonatomic, retain) NSNumber * progress;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *lectures;
@property (nonatomic, retain) NSSet *users;
@end

@interface Course (CoreDataGeneratedAccessors)

- (void)addLecturesObject:(Lecture *)value;
- (void)removeLecturesObject:(Lecture *)value;
- (void)addLectures:(NSSet *)values;
- (void)removeLectures:(NSSet *)values;

- (void)addUsersObject:(User *)value;
- (void)removeUsersObject:(User *)value;
- (void)addUsers:(NSSet *)values;
- (void)removeUsers:(NSSet *)values;

@end
