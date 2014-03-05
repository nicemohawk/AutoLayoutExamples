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
@property BOOL drawerIsOpen;

@property IBOutlet UIView *viewToTransform;

@end

@implementation NMLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.viewToTransform.superview.translatesAutoresizingMaskIntoConstraints = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
		[self.view layoutIfNeeded];
	}];
}

- (IBAction)transformAction:(id)sender {
	[UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
		CGAffineTransform transform = CGAffineTransformConcat(self.viewToTransform.transform, CGAffineTransformMakeScale(2.0f, 2.0f));
		
		transform = CGAffineTransformConcat(transform, CGAffineTransformMakeRotation(180/M_PI));
		self.viewToTransform.transform = transform;
	} completion:nil];
	
	[sender setEnabled:NO];
}

@end
