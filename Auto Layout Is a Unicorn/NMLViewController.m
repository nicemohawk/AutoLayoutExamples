//
//  NMLViewController.m
//  Auto Layout Is a Unicorn
//
//  Created by Ben Lachman on 3/4/14.
//  Copyright (c) 2014 Nice Mohawk Limited. All rights reserved.
//

#import "NMLViewController.h"

@interface NMLViewController ()

@property IBOutlet NSLayoutConstraint *animatedConstraint;
@property IBOutlet UIView *drawerView;
@property IBOutlet UIView *viewToTransform;
@property IBOutlet UIView *containerView;

@property BOOL drawerIsOpen;

@end

@implementation NMLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

	UIView *view = self.containerView;

	NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]-|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(view)];

	[self.view addConstraints:constraints];
}

#pragma mark - Actions

- (IBAction)animateAction:(id)sender {
	if( self.drawerIsOpen ) {
		// Close the drawer!
		self.animatedConstraint.constant = -220.0f;
		self.drawerIsOpen = NO;
	} else {
		self.animatedConstraint.constant = 0;
		self.drawerIsOpen = YES;
	}

	[UIView animateWithDuration:0.5 animations:^{
		[[self.animatedConstraint.firstItem superview] layoutIfNeeded];
	}];
}

- (IBAction)CATransformAction:(id)sender {
	CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform"];
	animation.duration = 0.5;
	animation.autoreverses = YES;
	animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 220, 0)];
	[self.drawerView.layer addAnimation:animation forKey:nil];
}

- (IBAction)transformAction:(id)sender {
	static BOOL toggle = NO;

	CGFloat scaleFactor = 2.0f;

	if( toggle ) {
		scaleFactor = 0.5f;
	}

	toggle = !toggle;

	CGAffineTransform animationTransform = CGAffineTransformConcat(CGAffineTransformMakeRotation(180/M_PI), CGAffineTransformMakeScale(scaleFactor, scaleFactor));

	[UIView animateWithDuration:.5 delay:0 options:0 animations:^{
		self.viewToTransform.transform = CGAffineTransformConcat(self.viewToTransform.transform, animationTransform);
	} completion:nil];
}

@end
