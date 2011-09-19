//
//  LightsLayer.h
//  TrafficLight
//
//  Created by Eelco Lempsink on 19-09-11.
//  Copyright (c) 2011 Unsolicited Code. All rights reserved.
//

#import <QuartzCore/CoreAnimation.h>

typedef enum {
    LightsLayerStateOff,
    LightsLayerStateGo,
    LightsLayerStateHurry,
    LightsLayerStateStop
} LightsLayerState;

@interface LightsLayer : CALayer
@property (nonatomic,assign) LightsLayerState state;

- (void)hurryStop:(NSTimeInterval)duration;

@end
