//
//  OCLectureListingView.m
//  OnCourse
//
//  Created by East Agile on 12/11/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCLectureListingView.h"
#import "OCAppDelegate.h"
#import "OCUtility.h"

#define WIDTH_IPHONE_5 568
#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds].size.height == WIDTH_IPHONE_5)

NSString *const kLabelTopLectureVertical = @"V:|-15-[_labelTop]-10-[_tableviewLecture]";

NSString *const kTableviewLectureListingHorizontal = @"H:|-0-[_tableviewLecture]-0-|";
NSString *const kTableviewLectureListingVertical = @"V:[_tableviewLecture]-0-|";

@interface OCLectureListingView()

@property (nonatomic, strong) UILabel *labelTop;
@property (nonatomic, strong) UITableView *tableviewLecture;
@property (nonatomic, strong) NSMutableArray *lectureData;
@property (nonatomic, strong) UIButton *buttonBack;

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

- (id)initWithLectureData:(NSMutableArray *)lectureData
{
    self = [super init];
    if (self) {
        [self constructUIComponents];
        [self addConstraints:[self arrayContraints]];
        [self setNiceBackground];
        self.lectureData = lectureData;
    }
    return self;
}

- (void)constructUIComponents
{
    self.labelTop = [[UILabel alloc] init];
    self.labelTop.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTop.backgroundColor = [UIColor clearColor];
    [self.labelTop setFont:[UIFont fontWithName:@"Livory" size:25]];
    self.labelTop.text = @"Lectures";
    [self addSubview:self.labelTop];

    self.tableviewLecture = [[UITableView alloc] init];
    self.tableviewLecture.delegate = self;
    self.tableviewLecture.dataSource = self;
    self.tableviewLecture.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tableviewLecture reloadData];
    [self addSubview:self.tableviewLecture];

    self.buttonBack = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 20, 10)];
    [self.buttonBack addTarget:self action:@selector(actionBack) forControlEvents:UIControlEventTouchDown];
    [self addSubview:self.buttonBack];
}

- (void)actionBack
{
    OCAppDelegate *appDelegate = [OCUtility appDelegate];
    [appDelegate.navigationController popViewControllerAnimated:YES];

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
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_labelTop, _tableviewLecture);
    [result addObject:[NSLayoutConstraint constraintWithItem:self.labelTop attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];

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
    
    [result addObjectsFromArray:[self labelTopConstraints]];
    [result addObjectsFromArray:[self tableviewLectureListingConstrains]];

    return [NSArray arrayWithArray:result];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.lectureData.count/2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self.lectureData objectAtIndex:(section * 2 + 1)] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LectureCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"LectureCell"];
    }
    
    cell.textLabel.text = [[self.lectureData objectAtIndex:indexPath.section *2 +1] objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.lectureData objectAtIndex:section*2];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 892, 40)];
    view.backgroundColor = [UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 350, 42)];
    label.text = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:109/255.0 green:109/255.0 blue:109/255.0 alpha:1];

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
