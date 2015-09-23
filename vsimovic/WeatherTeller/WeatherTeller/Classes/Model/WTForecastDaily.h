//
//  WTForecast.h
//  WeatherTeller
//
//  Created by Vuk Simovic on 9/22/15.
//  Copyright © 2015 Mera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTForecast.h"

@interface WTForecastDaily : WTForecast <NSCoding>

//@property (nonatomic, assign) double time;
//@property (nonatomic, strong) NSString *summary;
//@property (nonatomic, strong) NSString *wIcon;
//@property (nonatomic, assign) float temperature;
//@property (nonatomic, assign) float dewPoint;
//@property (nonatomic, assign) float humidity;
//@property (nonatomic, assign) float windSpeed;
//@property (nonatomic, assign) float windBearing;
//@property (nonatomic, assign) float visibility;
//@property (nonatomic, assign) float cloudCover;
//@property (nonatomic, assign) float pressure;
//@property (nonatomic, assign) float ozone;

@property (nonatomic, assign) double sunriseTime;
@property (nonatomic, assign) double sunsetTime;
@property (nonatomic, assign) float moonPhase;
@property (nonatomic, assign) float precipIntensity;
@property (nonatomic, assign) float precipIntensityMax;
@property (nonatomic, assign) float precipProbability;
@property (nonatomic, assign) float temperatureMin;
@property (nonatomic, assign) double temperatureMinTime;
@property (nonatomic, assign) float temperatureMax;
@property (nonatomic, assign) double temperatureMaxTime;
@property (nonatomic, assign) float apparentTemperatureMin;
@property (nonatomic, assign) double apparentTemperatureMinTime;
@property (nonatomic, assign) float apparentTemperatureMax;
@property (nonatomic, assign) double apparentTemperatureMaxTime;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

- (void)encodeWithCoder:(NSCoder *)coder;
- (id)initWithCoder:(NSCoder *)coder;

@end
