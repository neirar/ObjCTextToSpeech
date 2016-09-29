//
//  RNRootViewController.m
//  SlidingViewController
//
//  Created by Roberto Neira on 2015-08-16.
//  Copyright (c) 2015 Roberto Neira. All rights reserved.
//

#import "RNRootViewController.h"

@interface RNRootViewController () <RNMenuViewControllerDelegate>

@end



@implementation RNRootViewController

@dynamic menuViewController;
@dynamic mainContentViewController;

#pragma mark - 
#pragma mark Init methods

- (instancetype)init {
	if (self = [super init]) {
		
	}
	
	return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
		
		RNMenuViewController *menuViewController = [storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
		menuViewController.delegate = self;
		self.menuViewController = [[UINavigationController alloc] initWithRootViewController:menuViewController];
		
		self.mainContentViewController = [storyboard instantiateViewControllerWithIdentifier:@"NumberSpellingViewController"];
		self.mainContentViewController.number = @(0);
		self.mainContentViewController.locale = [NSLocale currentLocale];
	}
	
	return self;
}



#pragma mark -
#pragma mark RNMenuViewControllerDelegate Protocol

- (void)menuViewController:(RNMenuViewController *)controller didFinishWithLocale:(NSLocale *)locale number:(NSNumber *)number {
	self.mainContentViewController.number = number;
	self.mainContentViewController.locale = locale;
	
	[self hideMenuAnimated:YES];
}

@end
