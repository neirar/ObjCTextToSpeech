//
//  RNMenuViewController.m
//  SlidingViewController
//
//  Created by Roberto Neira on 2015-08-16.
//  Copyright (c) 2015 Roberto Neira. All rights reserved.
//

#import "RNMenuViewController.h"


@interface RNMenuViewController ()

@property (nonatomic, readwrite, strong) NSNumber *selectedNumber;
@property (nonatomic, readwrite, strong) NSLocale *selectedLocale;

@property (nonatomic, strong) NSArray *locales;
@property (nonatomic, strong) NSArray *numbers;

@end



@implementation RNMenuViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self _createNumbers];
	[self _createLocales];
}



#pragma mark -
#pragma mark Private methods

- (void)_createNumbers {
	NSMutableArray *numbers = [NSMutableArray array];
	
	for (NSInteger i = 0; i <= 100; i+=9) {
		[numbers addObject:@(i)];
	}
	
	self.numbers = numbers;
	self.selectedNumber = numbers[0];
}


- (void)_createLocales {
	NSMutableArray *locales = [NSMutableArray array];
	NSArray *identifiers = @[@"en", @"es", @"fr", @"de", @"ru"];
	
	for (NSString *anIdentifier in identifiers) {
		NSLocale *aLocale = [NSLocale localeWithLocaleIdentifier:anIdentifier];
		
		if (aLocale != nil) {
			[locales addObject:aLocale];
		}
	}
	
	self.locales = locales;
	self.selectedLocale = locales[0];
}


- (void)_populateCell:(UITableViewCell *)cell withLanguageAtIndex:(NSUInteger)index {
	NSLocale *locale = self.locales[index];
	
	NSLocale *currentLocale = [NSLocale currentLocale];
	cell.textLabel.text = [currentLocale displayNameForKey:NSLocaleIdentifier value:locale.localeIdentifier];
	
	if ([locale isEqual:self.selectedLocale]) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}
	else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
}


- (void)_populateCell:(UITableViewCell *)cell withNumberAtIndex:(NSUInteger)index {
	NSNumber *number = self.numbers[index];
	cell.textLabel.text = [number stringValue];
	
	if ([number isEqualToNumber:self.selectedNumber]) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}
	else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
}


- (IBAction)_close:(UIBarButtonItem *)sender {
	[self.delegate menuViewController:self didFinishWithLocale:self.selectedLocale number:self.selectedNumber];
}



#pragma mark -
#pragma mark UITableViewDataSource Protocol

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0) {
		return self.locales.count;
	}
	else {
		return self.numbers.count;
	}
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return NSLocalizedString(@"Languages", nil);
	}
	else {
		return NSLocalizedString(@"Numbers", nil);
	}
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell" forIndexPath:indexPath];
	
	if (indexPath.section == 0) {
		[self _populateCell:cell withLanguageAtIndex:indexPath.row];
	}
	else {
		[self _populateCell:cell withNumberAtIndex:indexPath.row];
	}
	
	return cell;
}



#pragma mark -
#pragma mark UITableViewDelegate Protocol

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0) {
		self.selectedLocale = self.locales[indexPath.row];
	}
	else {
		self.selectedNumber = self.numbers[indexPath.row];
	}
	
	[tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
