//
//  RNSlidingViewController.m
//  SlidingViewController
//
//  Created by Roberto Neira on 2015-08-15.
//  Copyright (c) 2015 Roberto Neira. All rights reserved.
//

#import "RNSlidingViewController.h"

#import "RNOpenMenuView.h"
#import "RNSlidingContentView.h"


@interface RNSlidingViewController ()

@property (nonatomic, readwrite, assign) BOOL isMenuShown;

@property (nonatomic, strong) RNOpenMenuView *openMenuView;
@property (nonatomic, strong) RNSlidingContentView *mainContentView;
@property (nonatomic, strong) RNSlidingContentView *menuContentView;

@end


@implementation RNSlidingViewController

- (instancetype)init {
	if (self = [super init]) {
		
	}
	
	return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		
	}
	
	return self;
}


#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self _addOpenMenuView];
	[self _addContentViews];
	
	[self.mainContentView addSubview:_mainContentViewController.view];
}


- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	
	CGRect contentFrame = self.view.bounds;
	self.mainContentView.frame = contentFrame;
	
	contentFrame = self.menuContentView.frame;
	contentFrame.size = self.view.bounds.size;
	
	if (self.isMenuShown) {
		contentFrame.origin.y = 0;
	}
	else {
		contentFrame.origin.y = self.view.bounds.size.height;
	}
	
	self.menuContentView.frame = contentFrame;
}



#pragma mark -
#pragma mark Instance methods

- (void)showMenuAnimated:(BOOL)animated {
	self.isMenuShown = YES;
	
	[self _willShowMenuAnimated:animated];
	
	CGFloat scaleFactor = 0.95;
	
	[UIView animateWithDuration:(animated ? 0.5 : 0.0)
												delay:0.0
			 usingSpringWithDamping:0.8
				initialSpringVelocity:3
											options:0
									 animations:^{
										 [self.view bringSubviewToFront:self.menuContentView];
										 self.menuContentView.frame = self.view.bounds;
										 self.mainContentView.transform = CGAffineTransformMakeScale(scaleFactor, scaleFactor);
									 }
									 completion:^(BOOL finished) {
										 [self _didShowMenuAnimated:animated];
									 }];
}


- (void)hideMenuAnimated:(BOOL)animated {
	self.isMenuShown = NO;
	
	[self _willHideMenuAnimated:YES];
	
	CGRect finalFrame = self.view.bounds;
	finalFrame.origin.y = finalFrame.size.height;
	
	[UIView animateWithDuration:(animated ? 0.3 : 0.0)
									 animations:^{
										 self.menuContentView.frame = finalFrame;
										 self.mainContentView.transform = CGAffineTransformIdentity;
									 }
									 completion:^(BOOL finished) {
										 [self _didHideMenuAnimated:animated];
									 }];
}



#pragma mark -
#pragma mark Custom Getters and Setters 

- (void)setMenuViewController:(UIViewController *)menuViewController {
	if (_menuViewController != menuViewController) {
		[self _performRemoveOperationsOnViewController:menuViewController];
		
		_menuViewController = menuViewController;
		
		if (_menuViewController != nil) {
			[self _performAddOperationsOnViewController:_menuViewController];
		}
	}
}


- (void)setMainContentViewController:(UIViewController *)mainContentController {
	if (_mainContentViewController != mainContentController) {
		[self _performRemoveOperationsOnViewController:mainContentController];
		
		_mainContentViewController = mainContentController;
		
		if (_mainContentViewController != nil) {
			[self _performAddOperationsOnViewController:_mainContentViewController];
			
			if (self.isViewLoaded && !self.isMenuShown) {
				[self.mainContentView addSubview:_mainContentViewController.view];
			}
		}
	}
}



#pragma mark -
#pragma mark Private methods

- (void)_addOpenMenuView {
	RNOpenMenuView *openMenuView = [[RNOpenMenuView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
	openMenuView.translatesAutoresizingMaskIntoConstraints = NO;
	openMenuView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
	[self.view addSubview:openMenuView];
	self.openMenuView = openMenuView;
	
	NSDictionary *keyBindings = NSDictionaryOfVariableBindings(openMenuView);
	
	NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10@1000-[openMenuView]-10@100-|" options:0 metrics:nil views:keyBindings];
	NSArray *verticalConstratins = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10@100-[openMenuView]-10@1000-|" options:0 metrics:nil views:keyBindings];
	[self.view addConstraints:[horizontalConstraints arrayByAddingObjectsFromArray:verticalConstratins]];
	
	UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_showMenu:)];
	tapGestureRecognizer.numberOfTouchesRequired = 1;
	tapGestureRecognizer.numberOfTapsRequired = 1;
	[openMenuView addGestureRecognizer:tapGestureRecognizer];
}


- (void)_addContentViews {
	CGRect contentFrame = self.view.bounds;
	self.mainContentView = [[RNSlidingContentView alloc] initWithFrame:contentFrame];
	[self.view addSubview:self.mainContentView];
	[self.view sendSubviewToBack:self.mainContentView];
	
	contentFrame.origin.y = contentFrame.size.height;
	self.menuContentView = [[RNSlidingContentView alloc] initWithFrame:contentFrame];
	[self.view addSubview:self.menuContentView];
	[self.view bringSubviewToFront:self.menuContentView];
}


- (void)_performRemoveOperationsOnViewController:(UIViewController *)viewController {
	[viewController willMoveToParentViewController:nil];
	[viewController.view removeFromSuperview];
	[viewController removeFromParentViewController];
}


- (void)_performAddOperationsOnViewController:(UIViewController *)viewController {
	[self addChildViewController:viewController];
	[viewController didMoveToParentViewController:self];
}


- (void)_showMenu:(UITapGestureRecognizer *)gestureRecognizer {
	[self showMenuAnimated:YES];
}


- (void)_willShowMenuAnimated:(BOOL)animated {
	UIView *menuView = self.menuViewController.view;
	
	menuView.frame = self.menuContentView.bounds;
	[self.menuContentView addSubview:menuView];
}


- (void)_didShowMenuAnimated:(BOOL)animated {
	[self.mainContentViewController.view removeFromSuperview];
}


- (void)_willHideMenuAnimated:(BOOL)animated {
	UIView *mainView = self.mainContentViewController.view;
	
	mainView.frame = self.mainContentView.bounds;
	[self.mainContentView addSubview:mainView];
}


- (void)_didHideMenuAnimated:(BOOL)animated {
	[self.menuViewController.view removeFromSuperview];
}

@end
