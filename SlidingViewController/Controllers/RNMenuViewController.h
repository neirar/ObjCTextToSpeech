//
//  RNMenuViewController.h
//  SlidingViewController
//
//  Created by Roberto Neira on 2015-08-16.
//  Copyright (c) 2015 Roberto Neira. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RNMenuViewControllerDelegate;


@interface RNMenuViewController : UITableViewController

@property (nonatomic, readonly) NSNumber *selectedNumber;
@property (nonatomic, readonly) NSLocale *selectedLocale;

@property (nonatomic, weak) id <RNMenuViewControllerDelegate> delegate;

@end


@protocol RNMenuViewControllerDelegate
@required
- (void)menuViewController:(RNMenuViewController *)controller didFinishWithLocale:(NSLocale *)locale number:(NSNumber *)number;

@end