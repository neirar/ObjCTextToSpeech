//
//  RNSlidingContentView.m
//  SlidingViewController
//
//  Created by Roberto Neira on 2015-08-16.
//  Copyright (c) 2015 Roberto Neira. All rights reserved.
//

#import "RNSlidingContentView.h"

@interface RNSlidingContentView ()

@property (nonatomic, strong) UIView *overlayView;

@end


@implementation RNSlidingContentView

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		_overlayView = [[UIView alloc] initWithFrame:self.bounds];
		_overlayView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
	}
	
	return self;
}



#pragma mark -
#pragma mark Inherited methods

- (void)layoutSubviews {
	[super layoutSubviews];
	
	_overlayView.frame = self.bounds;
}

@end
