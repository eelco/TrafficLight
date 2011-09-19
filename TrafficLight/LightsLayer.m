//
//  LightsLayer.m
//  TrafficLight
//
//  Created by Eelco Lempsink on 19-09-11.
//  Copyright (c) 2011 Unsolicited Code. All rights reserved.
//

#import "LightsLayer.h"

@interface LightsLayer ()
@property (nonatomic,retain) CALayer* redLight;
@property (nonatomic,retain) CALayer* orangeLight;
@property (nonatomic,retain) CALayer* greenLight;
@end

@implementation LightsLayer

@dynamic redLight;
@dynamic orangeLight;
@dynamic greenLight;
@synthesize state = _state;

- (CALayer*)lightLayer {
    CALayer* layer = [CALayer layer];
    layer.backgroundColor = [[UIColor darkGrayColor] CGColor];
    layer.contents = (id)[UIImage imageNamed:@"lens.png"].CGImage;    
    layer.shadowColor = [[UIColor yellowColor] CGColor];
    layer.shadowOffset = CGSizeZero;
    return layer;
}

- (id)init {
    self = [super init];
    if (self) {
        self.redLight    = [self lightLayer];
        self.orangeLight = [self lightLayer];
        self.greenLight  = [self lightLayer];
        
        [self addSublayer:self.redLight];
        [self addSublayer:self.orangeLight];
        [self addSublayer:self.greenLight];
    }    
    return self;
}

- (void)turnOn:(CALayer*)lightLayer {
    UIColor* color = nil;
    if (lightLayer == self.redLight) {
        color = [UIColor redColor];
    } else if (lightLayer == self.orangeLight) {
        color = [UIColor orangeColor];
    } else if (lightLayer == self.greenLight) {
        color = [UIColor greenColor];
    }
    
    lightLayer.shadowOpacity = 0.8;    
    lightLayer.backgroundColor = [color CGColor];    
}

- (void)turnOff:(CALayer*)lightLayer {
    lightLayer.shadowOpacity = 0;
    lightLayer.backgroundColor = [[UIColor darkGrayColor] CGColor];
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
    return [key isEqualToString:@"state"]
        || [super needsDisplayForKey:key];
}

- (void)setState:(LightsLayerState)state {
    if (state == LightsLayerStateOff) {
        [self turnOff:self.redLight];
        [self turnOff:self.orangeLight];
        [self turnOff:self.greenLight];
    } else if (state == LightsLayerStateGo) {
        [self turnOff:self.redLight];
        [self turnOff:self.orangeLight];
        [self turnOn:self.greenLight];
    } else if (state == LightsLayerStateHurry) { 
        [self turnOff:self.redLight];
        [self turnOn:self.orangeLight];
        [self turnOff:self.greenLight];
    } else if (state == LightsLayerStateStop) {
        [self turnOn:self.redLight];
        [self turnOff:self.orangeLight];
        [self turnOff:self.greenLight];
    }
    _state = state;
}

- (void)hurryStop:(NSTimeInterval)duration {
    [self setState:LightsLayerStateStop];
    
    CAKeyframeAnimation* lightAnimation = [CAKeyframeAnimation 
                                           animationWithKeyPath:@"backgroundColor"];
    lightAnimation.duration = duration;
    lightAnimation.keyTimes = [NSArray arrayWithObjects:
                               [NSNumber numberWithFloat:0.0], 
                               [NSNumber numberWithFloat:0.1],
                               [NSNumber numberWithFloat:0.9],
                               [NSNumber numberWithFloat:1.0], 
                               nil];
   
    lightAnimation.values = [NSArray arrayWithObjects:
                             (id)[[UIColor darkGrayColor] CGColor], 
                             (id)[[UIColor orangeColor] CGColor],
                             (id)[[UIColor orangeColor] CGColor],
                             (id)[[UIColor darkGrayColor] CGColor], 
                             nil];
    
    [self.orangeLight addAnimation:lightAnimation forKey:nil];
    
    lightAnimation.values = [NSArray arrayWithObjects:
                             (id)[[UIColor greenColor] CGColor], 
                             (id)[[UIColor darkGrayColor] CGColor],
                             (id)[[UIColor darkGrayColor] CGColor],
                             (id)[[UIColor darkGrayColor] CGColor],
                             nil];
    
    [self.greenLight addAnimation:lightAnimation forKey:nil];
    
    lightAnimation.values = [NSArray arrayWithObjects:
                             (id)[[UIColor darkGrayColor] CGColor], 
                             (id)[[UIColor darkGrayColor] CGColor],
                             (id)[[UIColor darkGrayColor] CGColor],
                             (id)[[UIColor redColor] CGColor], 
                             nil];
    
    [self.redLight addAnimation:lightAnimation forKey:nil];    
}

- (void)layoutSublayers {
    [super layoutSublayers];
    
    CGFloat lightMargin    = roundf(MAX(1, self.bounds.size.height * 0.05));
    CGFloat lightMaxHeight = roundf((self.bounds.size.height - 2 * lightMargin) / 3.0);
    CGFloat lightMaxWidth  = self.bounds.size.width;
    
    CGFloat lightHeightWidth = MIN(lightMaxHeight, lightMaxWidth);
    CGFloat lightInsetX      = roundf((lightMaxWidth - lightHeightWidth) / 2.0);
    CGFloat lightInsetY      = roundf((lightMaxHeight -  lightHeightWidth) / 2.0);
    
    self.redLight.cornerRadius    = lightHeightWidth / 2;
    self.orangeLight.cornerRadius = lightHeightWidth / 2;
    self.greenLight.cornerRadius  = lightHeightWidth / 2;
    
    self.redLight.shadowRadius    = lightHeightWidth / 5;
    self.orangeLight.shadowRadius = lightHeightWidth / 5;
    self.greenLight.shadowRadius  = lightHeightWidth / 5;
    
    self.redLight.frame    = CGRectMake(lightInsetX, lightInsetY, 
                                        lightHeightWidth, lightHeightWidth);
    self.orangeLight.frame = CGRectMake(lightInsetX, lightMaxHeight + lightMargin + lightInsetY,
                                        lightHeightWidth, lightHeightWidth);
    self.greenLight.frame  = CGRectMake(lightInsetX, (lightMaxHeight + lightMargin) * 2 + lightInsetY,
                                        lightHeightWidth, lightHeightWidth);
}

@end
