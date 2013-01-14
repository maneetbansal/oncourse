//
//  OCCourseListingView.m
//  OnCourse
//
//  Created by East Agile on 12/3/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCCourseListingView.h"
#import "OCCourseListingCell.h"
#import "OCCrawlerAuthenticationCourseState.h"
#import "OCAppDelegate.h"
#import "OCUtility.h"
#import "OCCourseraCrawler.h"
#import "UIButton+Style.h"
#import "Course+CoreData.h"

#define WIDTH_IPHONE_5 568
#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds].size.height == WIDTH_IPHONE_5)

NSString *const kLabelTopVertical = @"V:|-15-[_labelTop]-10-[collectionView]-35-|";

NSString *const kCollectionCourseListingHorizontal = @"H:|-0-[collectionView]-0-|";
NSString *const kCollectionCourseListingVertical = @"V:[collectionView]";

NSString *const kButtonAccountInfoHorizontal = @"H:|-0-[_buttonAccountInfo(==_buttonSignOut)]-0-[_buttonSignOut]";
NSString *const kButtonAccountInfoVertical = @"V:[_buttonAccountInfo(==35)]-0-|";

NSString *const kButtonSignOutHorizontal = @"H:[_buttonSignOut]-0-|";
NSString *const kButtonSignOutVertical = @"V:[_buttonSignOut(==35)]-0-|";

@interface OCCourseListingView()

@property (nonatomic, strong) UILabel *labelTop;
@property (nonatomic, strong) UICollectionViewController *collectionCourseListing;
@property (nonatomic, strong) UIButton *buttonAccountInfo;
@property (nonatomic, strong) UIButton *buttonSignOut;
@property (nonatomic, strong) OCCrawlerAuthenticationCourseState *crawlerAuthenticationCourse;
@end

@implementation OCCourseListingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self constructUIComponents];
        [self addConstraints:[self arrayConstraints]];
        [self setNiceBackground];
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter]
         addObserver:self selector:@selector(orientationChanged)
         name:UIDeviceOrientationDidChangeNotification
         object:[UIDevice currentDevice]];
    }
    return self;
}

- (void)orientationChanged
{
    [self.collectionCourseListing.collectionView reloadData];
}

- (void)reloadData
{
    [self.collectionCourseListing.collectionView reloadData];
}

- (void)constructUIComponents
{
    [self labelTopUI];
    [self collectionViewCourseListingUI];
    [self accountInfoButtonUI];
    [self signOutButtonUI];
    [self addComponentsUI];
}

- (void)addComponentsUI
{
    NSArray *components = @[self.labelTop, self.collectionCourseListing.collectionView, self.buttonAccountInfo, self.buttonSignOut];
    [components enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self addSubview:obj];
    }];
}

- (void)collectionViewCourseListingUI
{
    UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [aFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionCourseListing = [[UICollectionViewController alloc] initWithCollectionViewLayout:aFlowLayout];
    self.collectionCourseListing.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionCourseListing.collectionView.delegate = self;
    self.collectionCourseListing.collectionView.dataSource = self;
    [self.collectionCourseListing.collectionView registerClass:[OCCourseListingCell class] forCellWithReuseIdentifier:@"COURSE_CELL"];
    self.collectionCourseListing.collectionView.backgroundColor = [UIColor clearColor];
}

- (void)labelTopUI
{
    self.labelTop = [[UILabel alloc] init];
    self.labelTop.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTop.backgroundColor = [UIColor clearColor];
    [self.labelTop setFont:[UIFont fontWithName:@"Livory-Bold" size:25]];
    self.labelTop.text = @"Your Courses";
}

- (void)signOutButtonUI
{
    self.buttonSignOut = [UIButton buttonSmallWithDarkBackgroundStyleAndTitle:@"Sign Out"];
    [self.buttonSignOut addTarget:self action:@selector(buttonSignOutAction) forControlEvents:UIControlEventTouchDown];
}

- (void)buttonSignOutAction
{
    NSLog(@"Sign out");
}

- (void)accountInfoButtonUI
{
    self.buttonAccountInfo = [UIButton buttonSmallWithDarkBackgroundStyleAndTitle:@"Account Information"];
    [self.buttonAccountInfo addTarget:self action:@selector(buttonAccountInfoAction) forControlEvents:UIControlEventTouchDown];
}

- (void)buttonAccountInfoAction
{
    NSLog(@"Account Information");
}

- (void)setNiceBackground
{
    if (IS_IPHONE_5)
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_background-568h@2x.png"]]];
    else
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_background"]]];
    
}

- (NSArray *)labelTopConstraints
{
    NSMutableArray *result = [@[] mutableCopy];
    UICollectionView *collectionView = _collectionCourseListing.collectionView;
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_labelTop, collectionView);
    [result addObject:[NSLayoutConstraint constraintWithItem:self.labelTop attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];

    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kLabelTopVertical options:0 metrics:nil views:viewsDictionary]];

    return [NSArray arrayWithArray:result];
    
}

- (NSArray *)collectionCourseListingConstrains
{
    NSMutableArray *result = [@[] mutableCopy];
    UICollectionView *collectionView = _collectionCourseListing.collectionView;
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(collectionView);

    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kCollectionCourseListingHorizontal options:0 metrics:nil views:viewsDictionary]];
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kCollectionCourseListingVertical options:0 metrics:nil views:viewsDictionary]];

    return [NSArray arrayWithArray:result];
    
}

- (NSArray *)buttonAccountInfoConstraints
{
    NSMutableArray *result = [@[] mutableCopy];
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_buttonAccountInfo, _buttonSignOut);

    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kButtonAccountInfoHorizontal options:0 metrics:nil views:viewsDictionary]];
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kButtonAccountInfoVertical options:0 metrics:nil views:viewsDictionary]];

    return [NSArray arrayWithArray:result];
}

- (NSArray *)buttonSignOutConstraints
{
    NSMutableArray *result = [@[] mutableCopy];
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_buttonSignOut);

    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kButtonSignOutHorizontal options:0 metrics:nil views:viewsDictionary]];
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kButtonSignOutVertical options:0 metrics:nil views:viewsDictionary]];

    return [NSArray arrayWithArray:result];
}

- (NSArray *)arrayConstraints
{
    NSMutableArray *result = [@[] mutableCopy];

    NSArray *selectors = @[@"labelTopConstraints", @"collectionCourseListingConstrains", @"buttonAccountInfoConstraints", @"buttonSignOutConstraints"];
    [selectors enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [result addObjectsFromArray:[self performSelector:NSSelectorFromString(obj)]];
    }];
    
    return [NSArray arrayWithArray:result];
}

#pragma mark - UICollectionView Datasource
// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [_listAllCourse count];
}
// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OCCourseListingCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"COURSE_CELL" forIndexPath:indexPath];

    Course *course = [_listAllCourse objectAtIndex:indexPath.row];
    CGSize size = self.frame.size;

    if (size.width == [UIScreen mainScreen].bounds.size.width) {
//        cell.image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, size.width/2, size.width/2 * 135/ 240)];
        cell.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, 30)];
        cell.metaInfo = [[UILabel alloc] initWithFrame:CGRectMake(size.width / 3 + 65, 35, 150, 40)];

    }
    else
    {
//        cell.image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, size.width/4, size.width/4 * 135/ 240)];
        cell.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width/2 -10, 30)];
        cell.metaInfo = [[UILabel alloc] initWithFrame:CGRectMake(size.width/4, 33, 100, 35)];
    }
    
    [cell reloadData:course];
    return cell;
}
// 4
/*- (UICollectionReusableView *)collectionView:
 (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
 {
 return [[UICollectionReusableView alloc] init];
 }*/

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
    NSString *courseLink = [[self.listAllCourse objectAtIndex:indexPath.row] link];
    NSString *courseTitle = [[self.listAllCourse objectAtIndex:indexPath.row] title];
    NSString *courseStatus = [[self.listAllCourse objectAtIndex:indexPath.row] status];
    NSString *metaInfo = [[self.listAllCourse objectAtIndex:indexPath.row] metaInfo];
    NSString *date = [[metaInfo componentsSeparatedByString:@"\n"] objectAtIndex:0];
    NSString *announcement = @"";
    if ([@"Date to be announced" isEqualToString:date]) {
        announcement = @"Date to be announced!";
    } else {
        announcement = [NSString stringWithFormat:@"Please try again in %@!", date];
    }
    if ([@"disabled" isEqualToString:courseStatus]) {
        [[[UIAlertView alloc] initWithTitle:@"Coming soon" message:[NSString stringWithFormat:@"This course is coming soon. %@", announcement] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    } else {
        OCAppDelegate *appDelegate = [OCUtility appDelegate];
        self.crawlerAuthenticationCourse = [[OCCrawlerAuthenticationCourseState alloc] initWithWebView:appDelegate.courseCrawler.webviewCrawler andCourseLink:courseLink andCourseTitle:courseTitle];
        self.crawlerAuthenticationCourse.crawlerDelegate = appDelegate.courseCrawler;
        [appDelegate.courseCrawler changeState:self.crawlerAuthenticationCourse];
    }
    [self setUserDefaultForCourseSelected:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

#pragma mark – UICollectionViewDelegateFlowLayout

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize size = self.frame.size;

    if (size.width == [UIScreen mainScreen].bounds.size.width)
        return CGSizeMake(size.width, size.width/2 *135/240);
    else
        return CGSizeMake(size.width /2 - 10, size.width/4 *135/240);
    
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 10, 0);
}

- (void)setUserDefaultForCourseSelected:(NSIndexPath *)indexPath
{
    NSNumber *courseID = [[self.listAllCourse objectAtIndex:indexPath.row] courseID];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:courseID forKey:@"currentCourseID"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
