//
//  ViewController.m
//  PSTCollectionViewDemo
//
//  Created by baidu on 13-11-4.
//  Copyright (c) 2013年 alex. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "FooterView.h"
#import "HeaderView.h"

@interface ViewController ()
@property (strong, nonatomic)PSUICollectionView *collectionView;
@property (strong, nonatomic)NSMutableArray *data;

@end

static NSString *cellIdentifier = @"TestCell";
static NSString *headerViewIdentifier = @"Test Header View";
static NSString *footerViewIdentifier = @"Test Footer View";


@implementation ViewController
@synthesize data=_data;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.data=[NSMutableArray arrayWithObjects:
               [NSMutableArray arrayWithObjects:@"1", @"2", @"3",@"4", @"5", @"6",@"7", @"8", @"9",@"10", @"11", @"12", nil],
               [NSMutableArray arrayWithObjects:@"1", @"2", @"3",@"4", @"5", @"6",@"7", @"8", @"9",@"10", @"11", @"12", nil],
               [NSMutableArray arrayWithObjects:@"1", @"2", @"3",@"4", @"5", @"6",@"7", @"8", @"9",@"10", @"11", @"12", nil],
               nil];
        
    PSUICollectionViewFlowLayout *collectionViewFlowLayout = [[PSUICollectionViewFlowLayout alloc] init];
	[collectionViewFlowLayout setScrollDirection:PSTCollectionViewScrollDirectionHorizontal];
	[collectionViewFlowLayout setItemSize:CGSizeMake(250, 245)];
	[collectionViewFlowLayout setHeaderReferenceSize:CGSizeMake(30, 500)];
	[collectionViewFlowLayout setFooterReferenceSize:CGSizeMake(30, 500)];
	[collectionViewFlowLayout setMinimumInteritemSpacing:10];
	[collectionViewFlowLayout setMinimumLineSpacing:10];
	[collectionViewFlowLayout setSectionInset:UIEdgeInsetsMake(0, 10, 0, 20)];//left:10,right:20
	
	_collectionView = [[PSUICollectionView alloc] initWithFrame:CGRectMake(0, 124, 1024, 500) collectionViewLayout:collectionViewFlowLayout];
	[_collectionView setDelegate:self];
	[_collectionView setDataSource:self];
//	[_collectionView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin];
    [_collectionView setAutoresizingMask:UIViewAutoresizingNone];
	[_collectionView setBackgroundColor:[UIColor redColor]];
	
    //注册Cell和Header及Footer
	[_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
	[_collectionView registerClass:[HeaderView class] forSupplementaryViewOfKind:PSTCollectionElementKindSectionHeader withReuseIdentifier:headerViewIdentifier];
	[_collectionView registerClass:[FooterView class] forSupplementaryViewOfKind:PSTCollectionElementKindSectionFooter withReuseIdentifier:footerViewIdentifier];
	[self.view addSubview:_collectionView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Rotation stuff

- (BOOL)shouldAutorotate {
    return YES;
}


- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}


- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation {
    if ((orientation == UIInterfaceOrientationLandscapeRight) || (orientation == UIInterfaceOrientationLandscapeLeft)) {
        return YES;
    }
    
    return NO;
}

#pragma mark PSUICollectionView stuff

- (NSInteger)numberOfSectionsInCollectionView:(PSUICollectionView *)collectionView {
    return [self.data count];
}


- (NSInteger)collectionView:(PSUICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.data objectAtIndex:section] count];
}


- (PSUICollectionViewCell *)collectionView:(PSUICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    UILabel *label = (UILabel *)[cell viewWithTag:123];
    label.text  = [[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    return cell;
}

- (PSUICollectionReusableView *)collectionView:(PSUICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
	NSString *identifier = nil;
	
	if ([kind isEqualToString:PSTCollectionElementKindSectionHeader]) {
		identifier = headerViewIdentifier;
	} else if ([kind isEqualToString:PSTCollectionElementKindSectionFooter]) {
		identifier = footerViewIdentifier;
	}
    PSUICollectionReusableView *supplementaryView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
    
    // TODO Setup view
    
    return supplementaryView;
}



@end
