//
//  WTForecast.m
//  WeatherTeller
//
//  Created by Vuk Simovic on 9/22/15.
//  Copyright © 2015 Mera. All rights reserved.
//

#import "WTForecastDaily.h"

@implementation WTForecastDaily

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super initWithDictionary:dict];
    
    if(self != nil) {
//        if([dict objectForKey:@"time"] != nil && [dict objectForKey:@"time"] != [NSNull null]) {
//            self.time = [[dict objectForKey:@"time"] doubleValue];
//        }
//
//        if([dict objectForKey:@"summary"] != nil && [dict objectForKey:@"summary"] != [NSNull null]) {
//            self.summary = [NSString stringWithFormat:@"%@",[dict objectForKey:@"summary"]];
//        }
//        if([dict objectForKey:@"icon"] != nil && [dict objectForKey:@"icon"] != [NSNull null]) {
//            self.wIcon = [NSString stringWithFormat:@"%@",[dict objectForKey:@"icon"]];
//        }
//
//        if([dict objectForKey:@"dewPoint"] != nil && [dict objectForKey:@"dewPoint"] != [NSNull null]) {
//            self.dewPoint = [[dict objectForKey:@"dewPoint"] floatValue];
//        }
//        if([dict objectForKey:@"humidity"] != nil && [dict objectForKey:@"humidity"] != [NSNull null]) {
//            self.humidity = [[dict objectForKey:@"humidity"] floatValue];
//        }
//        if([dict objectForKey:@"windSpeed"] != nil && [dict objectForKey:@"windSpeed"] != [NSNull null]) {
//            self.windSpeed = [[dict objectForKey:@"windSpeed"] floatValue];
//        }
//        if([dict objectForKey:@"windBearing"] != nil && [dict objectForKey:@"windBearing"] != [NSNull null]) {
//            self.windBearing = [[dict objectForKey:@"windBearing"] floatValue];
//        }
//        if([dict objectForKey:@"visibility"] != nil && [dict objectForKey:@"visibility"] != [NSNull null]) {
//            self.visibility = [[dict objectForKey:@"visibility"] floatValue];
//        }
//        if([dict objectForKey:@"cloudCover"] != nil && [dict objectForKey:@"cloudCover"] != [NSNull null]) {
//            self.cloudCover = [[dict objectForKey:@"cloudCover"] floatValue];
//        }
//        if([dict objectForKey:@"pressure"] != nil && [dict objectForKey:@"pressure"] != [NSNull null]) {
//            self.pressure = [[dict objectForKey:@"pressure"] floatValue];
//        }
//        if([dict objectForKey:@"ozone"] != nil && [dict objectForKey:@"ozone"] != [NSNull null]) {
//            self.time = [[dict objectForKey:@"ozone"] floatValue];
//        }



        if([dict objectForKey:@"sunriseTime"] != nil && [dict objectForKey:@"sunriseTime"] != [NSNull null]) {
            self.sunriseTime = [[dict objectForKey:@"sunriseTime"] doubleValue];
        }
        if([dict objectForKey:@"sunsetTime"] != nil && [dict objectForKey:@"sunsetTime"] != [NSNull null]) {
            self.sunsetTime = [[dict objectForKey:@"sunsetTime"] doubleValue];
        }
        if([dict objectForKey:@"moonPhase"] != nil && [dict objectForKey:@"moonPhase"] != [NSNull null]) {
            self.moonPhase = [[dict objectForKey:@"moonPhase"] floatValue];
        }
        if([dict objectForKey:@"precipIntensity"] != nil && [dict objectForKey:@"precipIntensity"] != [NSNull null]) {
            self.precipIntensity = [[dict objectForKey:@"precipIntensity"] floatValue];
        }
        if([dict objectForKey:@"precipIntensityMax"] != nil && [dict objectForKey:@"precipIntensityMax"] != [NSNull null]) {
            self.precipIntensityMax = [[dict objectForKey:@"precipIntensityMax"] floatValue];
        }
        if([dict objectForKey:@"precipProbability"] != nil && [dict objectForKey:@"precipProbability"] != [NSNull null]) {
            self.precipProbability = [[dict objectForKey:@"precipProbability"] floatValue];
        }
        if([dict objectForKey:@"temperatureMin"] != nil && [dict objectForKey:@"temperatureMin"] != [NSNull null]) {
            self.temperatureMin = [[dict objectForKey:@"temperatureMin"] floatValue];
        }
        if([dict objectForKey:@"temperatureMinTime"] != nil && [dict objectForKey:@"temperatureMinTime"] != [NSNull null]) {
            self.temperatureMinTime = [[dict objectForKey:@"temperatureMinTime"] doubleValue];
        }
        if([dict objectForKey:@"temperatureMax"] != nil && [dict objectForKey:@"temperatureMax"] != [NSNull null]) {
            self.temperatureMax = [[dict objectForKey:@"temperatureMax"] floatValue];
        }
        if([dict objectForKey:@"temperatureMaxTime"] != nil && [dict objectForKey:@"temperatureMaxTime"] != [NSNull null]) {
            self.temperatureMaxTime = [[dict objectForKey:@"temperatureMaxTime"] doubleValue];
        }
        if([dict objectForKey:@"apparentTemperatureMin"] != nil && [dict objectForKey:@"apparentTemperatureMin"] != [NSNull null]) {
            self.apparentTemperatureMin = [[dict objectForKey:@"apparentTemperatureMin"] floatValue];
        }
        if([dict objectForKey:@"apparentTemperatureMinTime"] != nil && [dict objectForKey:@"apparentTemperatureMinTime"] != [NSNull null]) {
            self.apparentTemperatureMinTime = [[dict objectForKey:@"apparentTemperatureMinTime"] doubleValue];
        }
        if([dict objectForKey:@"apparentTemperatureMax"] != nil && [dict objectForKey:@"apparentTemperatureMax"] != [NSNull null]) {
            self.apparentTemperatureMax = [[dict objectForKey:@"apparentTemperatureMax"] floatValue];
        }
        if([dict objectForKey:@"apparentTemperatureMaxTime"] != nil && [dict objectForKey:@"apparentTemperatureMaxTime"] != [NSNull null]) {
            self.apparentTemperatureMaxTime = [[dict objectForKey:@"apparentTemperatureMaxTime"] doubleValue];
        }
        
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)coder {
//    [coder encodeObject:self.summary forKey:@"WTForecastSummary"];
//    [coder encodeObject:self.wIcon forKey:@"WTForecastIcon"];
//
//    [coder encodeObject:[NSNumber numberWithFloat:self.temperature ] forKey:@"WTForecastTemerature"];
//    [coder encodeObject:[NSNumber numberWithFloat:self.humidity ] forKey:@"WTForecastHumidity"];
//    [coder encodeObject:[NSNumber numberWithFloat:self.windSpeed ] forKey:@"WTForecastWindSpeed"];

    [super encodeWithCoder:coder];

    [coder encodeObject:[NSNumber numberWithDouble:self.sunriseTime] forKey:@"WTForecastDailySunriseTime"];
    [coder encodeObject:[NSNumber numberWithDouble:self.sunsetTime] forKey:@"WTForecastDailySunsetTime"];


    [coder encodeObject:[NSNumber numberWithFloat:self.temperatureMin ] forKey:@"WTForecastDailyTemperatureMin"];
    [coder encodeObject:[NSNumber numberWithFloat:self.temperatureMax ] forKey:@"WTForecastDailyTemperatureMax"];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
//        self.summary = [coder decodeObjectForKey:@"WTForecastSummary"];
//        self.wIcon = [coder decodeObjectForKey:@"WTForecastIcon"];
//
//        self.temperature = [[coder decodeObjectForKey:@"WTForecastTemerature"] floatValue];
//        self.humidity = [[coder decodeObjectForKey:@"WTForecastHumidity"] floatValue];
//        self.windSpeed = [[coder decodeObjectForKey:@"WTForecastWindSpeed"] floatValue];

        
        self.sunriseTime = [[coder decodeObjectForKey:@"WTForecastDailySunriseTime"] doubleValue];
        self.sunsetTime = [[coder decodeObjectForKey:@"WTForecastDailySunsetTime"] doubleValue];

        self.temperatureMin = [[coder decodeObjectForKey:@"WTForecastDailyTemperatureMin"] floatValue];
        self.temperatureMax = [[coder decodeObjectForKey:@"WTForecastDailyTemperatureMax"] floatValue];
    }
    return self;
}

@end
