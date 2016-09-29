//
//  UIViewController+SlidingViewController.m
//  SlidingViewController
//
//  Created by Roberto Neira on 2015-08-16.
//  Copyright (c) 2015 Roberto Neira. All rights reserved.
//

#import "UIViewController+SlidingViewController.h"

@implementation UIViewController (SlidingViewController)

- (RNSlidingViewController *)slidingViewController {
	UIViewController *parentController = self.parentViewController;
	
	while (![parentController isKindOfClass:[RNSlidingViewController class]] && parentController != nil) {
		parentController = parentController.parentViewController;
	}
	
	return (RNSlidingViewController *)parentController;
}

@end
