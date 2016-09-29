//
//  RNSlidingViewController.h
//  SlidingViewController
//
//  Created by Roberto Neira on 2015-08-15.
//  Copyright (c) 2015 Roberto Neira. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RNSlidingViewController : UIViewController

@property (nonatomic, readonly, assign) BOOL isMenuShown;
@property (nonatomic, strong) UIViewController *menuViewController;
@property (nonatomic, strong) UIViewController *mainContentViewController;

- (void)showMenuAnimated:(BOOL)animated;
- (void)hideMenuAnimated:(BOOL)animated;

@end
