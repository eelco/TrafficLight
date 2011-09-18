//
//  TrafficLightViewController.m
//  TrafficLight
//
//  Created by Eelco Lempsink on 16-09-11.
//  Copyright 2011 Unsolicited Code. All rights reserved.
//

#import "TrafficLightViewController.h"
#import <QuartzCore/CoreAnimation.h>

@interface TrafficLightViewController ()
@property (nonatomic,retain) CALayer* backgroundLayer;
@end

@implementation TrafficLightViewController

@synthesize backgroundLayer = _backgroundLayer;

- (void)dealloc {
    self.backgroundLayer = nil;
    [super dealloc];
}
    
#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CALayer* backgroundLayer = [CALayer layer];
    backgroundLayer.backgroundColor = [[UIColor blackColor] CGColor];
    
    [self.view.layer addSublayer:backgroundLayer];
    
    self.backgroundLayer = backgroundLayer;
    
    [self.view addGestureRecognizer:
     [[[UITapGestureRecognizer alloc]
       initWithTarget:self action:@selector(tapped)]
      autorelease]];
}

- (void)tapped {
    self.backgroundLayer.frame = self.view.bounds;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

@end
