//
//  OCLectureListingView.m
//  OnCourse
//
//  Created by East Agile on 12/11/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCLectureListingView.h"
#import "OCCourseraCrawler.h"
#import "OCAppDelegate.h"
#import "OCUtility.h"
#import "OCWatchingVideoViewController.h"
#import "OCLectureListingsViewController.h"
#import "OCCrawlerAuthenticationCourseState.h"
#import "OCCourseraCrawler.h"
#import "UIButton+Style.h"
#import "NSManagedObject+Adapter.h"
#import "Lecture+CoreData.h"
#import "MBProgressHUD.h"
#import "Course+CoreData.h"

#define WIDTH_IPHONE_5 568
#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds].size.height == WIDTH_IPHONE_5)

NSString *const kButtonBackToCoursesViewHorizontal = @"H:|-15-[_buttonBack(==75)]-15-[_labelTop]";
NSString *const kButtonBackToCoursesViewVertical = @"V:|-15-[_buttonBack(==40)]-10-[_tableviewLecture]";

NSString *const kLabelTopLectureVertical = @"V:|-15-[_labelTop]-10-[_tableviewLecture]";
NSString *const kLabelTopLectureHorizontal = @"H:[_labelTop]-0-|";

NSString *const kTableviewLectureListingHorizontal = @"H:|-0-[_tableviewLecture]-0-|";
NSString *const kTableviewLectureListingVertical = @"V:[_tableviewLecture]-0-|";

@interface OCLectureListingView()

@property (nonatomic, strong) UILabel *labelTop;
@property (nonatomic, strong) UITableView *tableviewLecture;
@property (nonatomic, strong) __block NSMutableDictionary *lectureData;
@property (nonatomic, strong) NSArray *lectureSections;
@property (nonatomic, strong) UIButton *buttonBack;
@property (nonatomic, strong) OCWatchingVideoViewController *watchingVideoController;
@property (nonatomic, strong) NSString *videoLink;
@property (nonatomic, strong) NSString *videoTitle;

@end

@implementation OCLectureListingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self initLectureData];
        [self constructUIComponents];
        [self addConstraints:[self arrayContraints]];
        [self setNiceBackground];
    }
    return self;
}

- (void)reloadData
{
    [self initLectureData];
    [self.tableviewLecture reloadData];
}

- (void)initLectureData
{
    self.lectureData = [@{} mutableCopy];
    self.lectureSections = [@[] mutableCopy];

    Course *course = [self currentCourse];
    NSArray *lectureItems = [[course lectures] allObjects];
    if (0 == lectureItems.count)
    {
        [MBProgressHUD showHUDAddedTo:self animated:YES];
        [self performSelector:@selector(removeLectureView) withObject:nil afterDelay:15];
    }
    else
    {
        [MBProgressHUD hideHUDForView:self animated:YES];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(removeLectureView) object:nil];

        NSArray *lectureSections = [lectureItems valueForKeyPath:@"@distinctUnionOfObjects.section"];
        [lectureSections enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSArray *lecturesInSection = [NSManagedObject findEntities:@"Lecture" withPredicateString:@"(section == %@)" andArguments:@[obj] withSortDescriptionKey:@{ @"lectureID" : @1 }];
            [self.lectureData setObject:lecturesInSection forKey:obj];
        }];
        self.lectureSections = [self.lectureData keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            if ([[[obj1 lastObject] sectionIndex] intValue] > [[[obj2 lastObject] sectionIndex] intValue])
                return NSOrderedDescending;
            return NSOrderedAscending;
        }];
    }
}

- (void)removeLectureView
{
    id topView = [OCUtility appDelegate].navigationController.topViewController;
    if ([topView class] == [OCLectureListingsViewController class]) {
        [[OCUtility appDelegate].navigationController popViewControllerAnimated:YES];
        [[[UIAlertView alloc] initWithTitle:@"No Lecture" message:@"No lecture is available now" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

- (Course *)currentCourse
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"currentCourseID"]) {
        return (Course *)[NSManagedObject findSingleEntity:@"Course" withPredicateString:@"(courseID == %@)" andArguments:@[[userDefaults objectForKey:@"currentCourseID"]] withSortDescriptionKey:nil];
    }
    return nil;
}

- (void)constructUIComponents
{
    [self buttonBackUI];
    [self labelTopUI];
    [self tableviewLectureUI];
    [self addUIComponetToView:self];
}

- (void)buttonBackUI
{
    self.buttonBack = [UIButton buttonWithBackStyleAndTitle:@"Courses"];
    [self.buttonBack addTarget:self action:@selector(actionBack) forControlEvents:UIControlEventTouchDown];
}

- (void)labelTopUI
{
    self.labelTop = [[UILabel alloc] init];
    self.labelTop.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTop.backgroundColor = [UIColor clearColor];
    [self.labelTop setFont:[UIFont fontWithName:@"Livory-Bold" size:16]];
    self.labelTop.text = @"Your course";
}

- (void)tableviewLectureUI
{
    self.tableviewLecture = [[UITableView alloc] init];
    self.tableviewLecture.delegate = self;
    self.tableviewLecture.dataSource = self;
    self.tableviewLecture.translatesAutoresizingMaskIntoConstraints = NO;
    UIColor *backgroundColor = [[UIColor alloc] initWithWhite:1 alpha:0.0];
    self.tableviewLecture.backgroundColor = backgroundColor;
        [self.tableviewLecture reloadData];
}

- (void)actionBack
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(removeLectureView) object:nil];
    OCAppDelegate *appDelegate = [OCUtility appDelegate];
    [appDelegate.navigationController popViewControllerAnimated:YES];
}

- (void)addUIComponetToView:(UIView *)paramView
{
    [paramView addSubview:self.buttonBack];
    [paramView addSubview:self.labelTop];
    [paramView addSubview:self.tableviewLecture];
}

- (void)setNiceBackground
{
    if (IS_IPHONE_5)
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_background-568h@2x.png"]]];
    else
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_background"]]];
    
}

- (NSArray *)buttonBackConstrains
{
    NSMutableArray *result = [@[] mutableCopy];
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_buttonBack, _labelTop, _tableviewLecture);

    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kButtonBackToCoursesViewHorizontal options:0 metrics:nil views:viewsDictionary]];
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kButtonBackToCoursesViewVertical options:0 metrics:nil views:viewsDictionary]];

    return [NSArray arrayWithArray:result];
}

- (NSArray *)labelTopConstraints
{
    NSMutableArray *result = [@[] mutableCopy];
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_labelTop, _tableviewLecture);

    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kLabelTopLectureHorizontal options:0 metrics:nil views:viewsDictionary]];
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kLabelTopLectureVertical options:0 metrics:nil views:viewsDictionary]];

    return [NSArray arrayWithArray:result];
    
}

- (NSArray *)tableviewLectureListingConstrains
{
    NSMutableArray *result = [@[] mutableCopy];
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_tableviewLecture);

    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kTableviewLectureListingHorizontal options:0 metrics:nil views:viewsDictionary]];
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kTableviewLectureListingVertical options:0 metrics:nil views:viewsDictionary]];

    return [NSArray arrayWithArray:result];
    
}

- (NSArray *)arrayContraints
{
    NSMutableArray *result = [@[] mutableCopy];

    [result addObjectsFromArray:[self buttonBackConstrains]];
    [result addObjectsFromArray:[self labelTopConstraints]];
    [result addObjectsFromArray:[self tableviewLectureListingConstrains]];

    return [NSArray arrayWithArray:result];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.lectureSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *sectionKey = [self.lectureSections objectAtIndex:section];
    return [[self.lectureData objectForKey:sectionKey] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LectureCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"LectureCell"];
    }

    NSString *sectionKey = [self.lectureSections objectAtIndex:indexPath.section];
    cell.textLabel.text = [[[self.lectureData objectForKey:sectionKey] objectAtIndex:indexPath.row] title];
    cell.textLabel.font = [UIFont fontWithName:@"Livory" size:16];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.lectureSections objectAtIndex:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1136, 40)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1136, 40)];
    label.text = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
    label.font = [UIFont fontWithName:@"Livory-Bold" size:16];
    label.backgroundColor = [UIColor colorWithRed:50/255.0 green:128/255.0 blue:200/255.0 alpha:1.0];

    [view addSubview:label];

    return view;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sectionKey = [self.lectureSections objectAtIndex:indexPath.section];
    Lecture *lecture = [[self.lectureData objectForKey:sectionKey] objectAtIndex:indexPath.row];
    self.watchingVideoController = [[OCWatchingVideoViewController alloc] initWithLecture:lecture];

    OCAppDelegate *appDelegate = [OCUtility appDelegate];
    [appDelegate.navigationController pushViewController:self.watchingVideoController animated:YES];
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
