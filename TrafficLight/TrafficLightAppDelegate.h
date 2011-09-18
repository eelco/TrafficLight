//
//  TrafficLightAppDelegate.h
//  TrafficLight
//
//  Created by Eelco Lempsink on 16-09-11.
//  Copyright 2011 Unsolicited Code. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TrafficLightViewController;

@interface TrafficLightAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet TrafficLightViewController *viewController;

@end
