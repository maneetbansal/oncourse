//
//  OCCourseListingView.m
//  OnCourse
//
//  Created by East Agile on 12/3/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCCourseListingView.h"
#import "OCCourse.h"
#import "OCCourseListingCell.h"
#import "OCCrawlerAuthenticationCourseState.h"
#import "OCAppDelegate.h"
#import "OCUtility.h"
#import "OCCourseraCrawler.h"

#define WIDTH_IPHONE_5 568
#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds].size.height == WIDTH_IPHONE_5)

NSString *const kLabelTopVertical = @"V:|-15-[_labelTop]-10-[collectionView]-35-|";

NSString *const kCollectionCourseListingHorizontal = @"H:|-0-[collectionView]-0-|";
NSString *const kCollectionCourseListingVertical = @"V:[collectionView]";

@interface OCCourseListingView()

@property (nonatomic, strong) UILabel *labelTop;
@property (nonatomic, strong) UICollectionViewController *collectionCourseListing;
@property (nonatomic, strong) UIButton *accountInformationButton;
@property (nonatomic, strong) UIButton *logoutButton;
@property (nonatomic, strong) OCCrawlerAuthenticationCourseState *crawlerAuthenticationCourse;
@end

@implementation OCCourseListingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self constructUIComponents];
        [self addConstraints:[self arrayContraints]];
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
    self.labelTop = [[UILabel alloc] init];
    self.labelTop.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTop.backgroundColor = [UIColor clearColor];
    [self.labelTop setFont:[UIFont fontWithName:@"Livory-Bold" size:25]];
    self.labelTop.text = @"Your Courses";
    [self addSubview:self.labelTop];
    
    UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [aFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionCourseListing = [[UICollectionViewController alloc] initWithCollectionViewLayout:aFlowLayout];
    self.collectionCourseListing.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionCourseListing.collectionView.delegate = self;
    self.collectionCourseListing.collectionView.dataSource = self;
    [self.collectionCourseListing.collectionView registerClass:[OCCourseListingCell class] forCellWithReuseIdentifier:@"COURSE_CELL"];
    self.collectionCourseListing.collectionView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.collectionCourseListing.collectionView];
    
    self.accountInformationButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.accountInformationButton.titleLabel.font = [UIFont fontWithName:@"Livory-Bold" size:16];
    [self.accountInformationButton setTitle:@"Your acccount" forState:UIControlStateNormal];
    [self addSubview:self.accountInformationButton];
    
    self.logoutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.logoutButton.titleLabel.font = [UIFont fontWithName:@"Livory-Bold" size:16];
    [self.logoutButton setTitle:@"Logout" forState:UIControlStateNormal];
    [self addSubview:self.logoutButton];
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

- (NSArray *)arrayContraints
{
    NSMutableArray *result = [@[] mutableCopy];
    
    [result addObjectsFromArray:[self labelTopConstraints]];
    [result addObjectsFromArray:[self collectionCourseListingConstrains]];
    
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

    OCCourse *course = [_listAllCourse objectAtIndex:indexPath.row];
    CGSize size = self.frame.size;

    if (size.width == [UIScreen mainScreen].bounds.size.width) {
        self.accountInformationButton.frame = CGRectMake(20, [UIScreen mainScreen].bounds.size.height - 50, [UIScreen mainScreen].bounds.size.width / 2 - 40, 25);
        self.logoutButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width) / 2 + 20, [UIScreen mainScreen].bounds.size.height - 50, [UIScreen mainScreen].bounds.size.width / 2 - 40, 25);
        
        cell.image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, size.width/2, size.width/2 * 135/ 240)];
        cell.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, 30)];
        cell.metaInfo = [[UILabel alloc] initWithFrame:CGRectMake(size.width/2 + 20, 35, 150, 40)];
    }
    else
    {
        self.accountInformationButton.frame = CGRectMake(20, [UIScreen mainScreen].bounds.size.width - 50, [UIScreen mainScreen].bounds.size.height / 2 - 40, 25);
        self.logoutButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.height) / 2 + 20, [UIScreen mainScreen].bounds.size.width - 50, [UIScreen mainScreen].bounds.size.height / 2 - 40, 25);
        
        cell.image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, size.width/4, size.width/4 * 135/ 240)];
        cell.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width/2 -10, 30)];
        cell.metaInfo = [[UILabel alloc] initWithFrame:CGRectMake(size.width/4 + 20, 33, 100, 35)];
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
    NSLog([NSString stringWithFormat:@"%i", indexPath.row ]);
    
    NSString *courseLink = [[self.listAllCourse objectAtIndex:indexPath.row] link];
    NSString *courseStatus = [[self.listAllCourse objectAtIndex:indexPath.row] status];
    NSString *metaInfo = [[self.listAllCourse objectAtIndex:indexPath.row] metaInfo];
    NSString *date = [[metaInfo componentsSeparatedByString:@"<br>"] objectAtIndex:0];
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
        self.crawlerAuthenticationCourse = [[OCCrawlerAuthenticationCourseState alloc] initWithWebView:appDelegate.courseCrawler.webviewCrawler andCourseLink:courseLink];
        self.crawlerAuthenticationCourse.crawlerDelegate = appDelegate.courseCrawler;
        [appDelegate.courseCrawler changeState:self.crawlerAuthenticationCourse];
    }
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
