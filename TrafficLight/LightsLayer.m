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

- (CALayer*)lightLayer {
    CALayer* layer = [CALayer layer];
    layer.backgroundColor = [[UIColor darkGrayColor] CGColor];
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
    
    self.redLight.frame    = CGRectMake(lightInsetX, lightInsetY, 
                                        lightHeightWidth, lightHeightWidth);
    self.orangeLight.frame = CGRectMake(lightInsetX, lightMaxHeight + lightMargin + lightInsetY,
                                        lightHeightWidth, lightHeightWidth);
    self.greenLight.frame  = CGRectMake(lightInsetX, (lightMaxHeight + lightMargin) * 2 + lightInsetY,
                                        lightHeightWidth, lightHeightWidth);
}

@end
