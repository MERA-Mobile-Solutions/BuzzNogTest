//
//  WTForecastCurrent.h
//  WeatherTeller
//
//  Created by Vuk Simovic on 9/22/15.
//  Copyright © 2015 Mera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTForecast.h"

@interface WTForecastCurrent : WTForecast

@property (nonatomic, assign) float nearestStormDistance;
@property (nonatomic, assign) float precipIntensity;
@property (nonatomic, assign) float precipProbability;
@property (nonatomic, assign) float apparentTemperature;

@end
