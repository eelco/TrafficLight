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
    
    self.view.backgroundColor = [UIColor blackColor];
    
    CALayer* backgroundLayer = [CALayer layer];
    backgroundLayer.frame = CGRectInset(self.view.bounds, 100, 50);
    backgroundLayer.backgroundColor = [[UIColor blackColor] CGColor];
    backgroundLayer.borderColor = [[UIColor whiteColor] CGColor];
    backgroundLayer.borderWidth = 25;
    backgroundLayer.cornerRadius = backgroundLayer.frame.size.width / 2;
    
    [self.view.layer addSublayer:backgroundLayer];
    
    self.backgroundLayer = backgroundLayer;
    
    [self.view addGestureRecognizer:
     [[[UITapGestureRecognizer alloc]
       initWithTarget:self action:@selector(tapped)]
      autorelease]];
}

- (void)tapped {
    CABasicAnimation* animation = [CABasicAnimation 
                                   animationWithKeyPath:@"transform"];

    NSNumber* fromValue = [self.backgroundLayer.presentationLayer 
                           valueForKeyPath:@"transform.rotation.x"];
    if (fromValue == nil) {
        fromValue = [NSNumber numberWithDouble:0.0f];
    }
    animation.fromValue = fromValue;
    
    static BOOL toggler = YES;
    if (toggler) {
        animation.toValue   = [NSNumber numberWithDouble:M_PI / 2];
    } else {
        animation.toValue   = [NSNumber numberWithDouble:0.0f];
    }
    toggler = !toggler;
    
    animation.valueFunction = [CAValueFunction 
                               functionWithName:kCAValueFunctionRotateX];
    animation.duration  = 1.0f;
    
    [self.backgroundLayer setValue:animation.toValue 
                        forKeyPath:@"transform.rotation.x"];
    
    [self.backgroundLayer removeAnimationForKey:@"flip"];
    [self.backgroundLayer addAnimation:animation forKey:@"flip"];
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
