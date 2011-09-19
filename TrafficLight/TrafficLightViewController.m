//
//  TrafficLightViewController.m
//  TrafficLight
//
//  Created by Eelco Lempsink on 16-09-11.
//  Copyright 2011 Unsolicited Code. All rights reserved.
//

#import "TrafficLightViewController.h"
#import <QuartzCore/CoreAnimation.h>
#import "LightsLayer.h"

@interface TrafficLightViewController ()
@property (nonatomic,retain) CALayer* backgroundLayer;
@property (nonatomic,retain) LightsLayer* lightsLayer;
@end

@implementation TrafficLightViewController

@synthesize backgroundLayer = _backgroundLayer;
@synthesize lightsLayer     = _lightsLayer;

- (void)dealloc {
    self.backgroundLayer = nil;
    self.lightsLayer = nil;
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
    
    LightsLayer* lightsLayer = [LightsLayer layer];
    lightsLayer.frame = CGRectInset(backgroundLayer.bounds, 20, 100);
    [lightsLayer setState:LightsLayerStateGo];
    
    [backgroundLayer addSublayer:lightsLayer];

    self.lightsLayer = lightsLayer;
    
    [self.view addGestureRecognizer:
     [[[UITapGestureRecognizer alloc]
       initWithTarget:self action:@selector(tapped)]
      autorelease]];
}

- (void)tapped {
    [self.lightsLayer removeAllAnimations];
    static BOOL toggler = YES;
    if (toggler) {
        CAKeyframeAnimation* animation = [CAKeyframeAnimation 
                                          animationWithKeyPath:@"state"];
        
        animation.values = [NSArray arrayWithObjects:
                            [NSNumber numberWithInt:LightsLayerStateHurry],
                            [NSNumber numberWithInt:LightsLayerStateStop], 
                            nil];
        animation.calculationMode = kCAAnimationDiscrete;
        animation.duration = 3;
        [self.lightsLayer addAnimation:animation forKey:nil];    
    } else {
        [self.lightsLayer setState:LightsLayerStateGo];
    }
    toggler = !toggler;
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
