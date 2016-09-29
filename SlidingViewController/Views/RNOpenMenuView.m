//
//  RNOpenMenuView.m
//  SlidingViewController
//
//  Created by Roberto Neira on 2015-08-15.
//  Copyright (c) 2015 Roberto Neira. All rights reserved.
//

#import "RNOpenMenuView.h"

@interface RNOpenMenuView ()

@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, strong) UIImageView *imageView;

@end



@implementation RNOpenMenuView

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[super setBackgroundColor:[UIColor whiteColor]];
		[self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
		[self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
		
		[self _addCircularBackground];
		[self _addImage];
	}
	
	return self;
}



#pragma mark -
#pragma mark Inherited methods

- (void)layoutSubviews {
	[super layoutSubviews];
	[self _resetCircularPath];
}


- (CGSize)intrinsicContentSize {
	return CGSizeMake(60, 60);
}


- (void)setBackgroundColor:(UIColor *)backgroundColor {
	self.circleLayer.strokeColor = backgroundColor.CGColor;
	self.circleLayer.fillColor = backgroundColor.CGColor;
}



#pragma mark -
#pragma mark Private methods

- (void)_addCircularBackground {
	_circleLayer = [[CAShapeLayer alloc] init];
	_circleLayer.strokeColor = [UIColor whiteColor].CGColor;
	_circleLayer.fillColor = [UIColor whiteColor].CGColor;
	[self _resetCircularPath];
	[self.layer addSublayer:_circleLayer];
}


- (void)_resetCircularPath {
	UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
	self.circleLayer.path = bezierPath.CGPath;
}


- (void)_addImage {
	_imageView = [[UIImageView alloc] initWithFrame:self.bounds];
	_imageView.image = [UIImage imageNamed:@"OpenSlidingMenu"];
	_imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	[self addSubview:_imageView];
}

@end
