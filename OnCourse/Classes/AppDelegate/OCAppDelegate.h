//
//  OCAppDelegate.h
//  OnCourse
//
//  Created by East Agile on 11/29/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OCViewController;

@interface OCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) OCViewController *viewController;
@property (strong, nonatomic) UINavigationController *navigationController;

@end
