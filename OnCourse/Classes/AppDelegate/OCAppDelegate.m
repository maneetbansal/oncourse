//
//  OCAppDelegate.m
//  OnCourse
//
//  Created by East Agile on 11/29/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCAppDelegate.h"
#import "OCCourseListingsViewController.h"
#import "OCLoginViewController.h"
#import "OCCourseraCrawler.h"
#import "OCCrawlerLoginState.h"
#import <CoreData/CoreData.h>
#import "Data+Coredata.h"

@interface OCAppDelegate()

@property (nonatomic, strong) OCCrawlerLoginState *crawlerLoginState;
@property (nonatomic, strong) OCCourseListingsViewController *courseListingViewController;
@property (nonatomic, strong) OCLoginViewController *loginViewController;

@end

@implementation OCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.courseCrawler = [[OCCourseraCrawler alloc] init];
    [self pullJavascriptFile];
    [self presentFirstView];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)pullJavascriptFile
{
    NSString *javascript = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://dl.dropbox.com/u/81417138/oncourse_json.txt"] encoding:NSUTF8StringEncoding error:nil];
    if (javascript)
        [Data dataWithInfo:@{ @"data_id" : @1, @"javascript" : javascript }];
}

- (void)presentFirstView
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults stringForKey:@"isLogin"])
    {
        NSString *email = [NSString stringWithFormat:@"%@", [userDefaults objectForKey:@"email"]];
        NSString *password = [NSString stringWithFormat:@"%@", [userDefaults objectForKey:@"password"]];
        self.crawlerLoginState = [[OCCrawlerLoginState alloc] initWithWebview:self.courseCrawler.webviewCrawler andEmail:email andPassword:password];
        self.crawlerLoginState.crawlerDelegate = self.courseCrawler;
        [self.courseCrawler changeState:self.crawlerLoginState];
        self.courseListingViewController = [OCCourseListingsViewController new];
        self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.courseListingViewController];
    }
    else
    {
        self.loginViewController = [OCLoginViewController new];
        self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.loginViewController];
    }

    [self.navigationController setNavigationBarHidden:YES];
    self.window.rootViewController = self.navigationController;
}

- (NSManagedObjectContext *)managedObjectContext {
  if (_managedObjectContext != nil) {
    return _managedObjectContext;
  }
  NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
  if (coordinator != nil) {
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator: coordinator];
  }

  return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
  if (_managedObjectModel != nil) {
    return _managedObjectModel;
  }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];

  return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
  if (_persistentStoreCoordinator != nil) {
    return _persistentStoreCoordinator;
  }
  NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
                      stringByAppendingPathComponent: @"OnCourse.sqlite"]];
  NSError *error = nil;
  _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                 initWithManagedObjectModel:[self managedObjectModel]];
  if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                 configuration:nil URL:storeUrl options:nil error:&error]) {
    /*Error for store creation should be handled in here*/
  }

  return _persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory {
  return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
