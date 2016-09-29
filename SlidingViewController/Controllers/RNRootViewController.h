//
//  RNRootViewController.h
//  SlidingViewController
//
//  Created by Roberto Neira on 2015-08-16.
//  Copyright (c) 2015 Roberto Neira. All rights reserved.
//

#import "RNSlidingViewController.h"

#import "RNMenuViewController.h"
#import "RNNumberSpellingViewController.h"

@interface RNRootViewController : RNSlidingViewController

@property (nonatomic, strong) UINavigationController *menuViewController;
@property (nonatomic, strong) RNNumberSpellingViewController *mainContentViewController;

@end
