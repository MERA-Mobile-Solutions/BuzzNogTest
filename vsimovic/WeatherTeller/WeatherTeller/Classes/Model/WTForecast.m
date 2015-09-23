//
//  WTForecast.m
//  WeatherTeller
//
//  Created by Vuk Simovic on 9/22/15.
//  Copyright © 2015 Mera. All rights reserved.
//

#import "WTForecast.h"

@implementation WTForecast

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if(self != nil) {
        if([dict objectForKey:@"time"] != nil && [dict objectForKey:@"time"] != [NSNull null]) {
            self.time = [[dict objectForKey:@"time"] doubleValue];
        }

        if([dict objectForKey:@"summary"] != nil && [dict objectForKey:@"summary"] != [NSNull null]) {
            self.summary = [NSString stringWithFormat:@"%@",[dict objectForKey:@"summary"]];
        }
        if([dict objectForKey:@"icon"] != nil && [dict objectForKey:@"icon"] != [NSNull null]) {
            self.wIcon = [NSString stringWithFormat:@"%@",[dict objectForKey:@"icon"]];
        }

        if([dict objectForKey:@"dewPoint"] != nil && [dict objectForKey:@"dewPoint"] != [NSNull null]) {
            self.dewPoint = [[dict objectForKey:@"dewPoint"] floatValue];
        }
        if([dict objectForKey:@"humidity"] != nil && [dict objectForKey:@"humidity"] != [NSNull null]) {
            self.humidity = [[dict objectForKey:@"humidity"] floatValue];
        }
        if([dict objectForKey:@"windSpeed"] != nil && [dict objectForKey:@"windSpeed"] != [NSNull null]) {
            self.windSpeed = [[dict objectForKey:@"windSpeed"] floatValue];
        }
        if([dict objectForKey:@"windBearing"] != nil && [dict objectForKey:@"windBearing"] != [NSNull null]) {
            self.windBearing = [[dict objectForKey:@"windBearing"] floatValue];
        }
        if([dict objectForKey:@"visibility"] != nil && [dict objectForKey:@"visibility"] != [NSNull null]) {
            self.visibility = [[dict objectForKey:@"visibility"] floatValue];
        }
        if([dict objectForKey:@"cloudCover"] != nil && [dict objectForKey:@"cloudCover"] != [NSNull null]) {
            self.cloudCover = [[dict objectForKey:@"cloudCover"] floatValue];
        }
        if([dict objectForKey:@"pressure"] != nil && [dict objectForKey:@"pressure"] != [NSNull null]) {
            self.pressure = [[dict objectForKey:@"pressure"] floatValue];
        }
        if([dict objectForKey:@"ozone"] != nil && [dict objectForKey:@"ozone"] != [NSNull null]) {
            self.time = [[dict objectForKey:@"ozone"] floatValue];
        }
        
    }
    return self;
}





- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.summary forKey:@"WTForecastSummary"];
    [coder encodeObject:self.wIcon forKey:@"WTForecastIcon"];

    [coder encodeObject:[NSNumber numberWithFloat:self.temperature ] forKey:@"WTForecastTemerature"];
    [coder encodeObject:[NSNumber numberWithFloat:self.humidity ] forKey:@"WTForecastHumidity"];
    [coder encodeObject:[NSNumber numberWithFloat:self.windSpeed ] forKey:@"WTForecastWindSpeed"];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.summary = [coder decodeObjectForKey:@"WTForecastSummary"];
        self.wIcon = [coder decodeObjectForKey:@"WTForecastIcon"];

        self.temperature = [[coder decodeObjectForKey:@"WTForecastTemerature"] floatValue];
        self.humidity = [[coder decodeObjectForKey:@"WTForecastHumidity"] floatValue];
        self.windSpeed = [[coder decodeObjectForKey:@"WTForecastWindSpeed"] floatValue];
    }
    return self;
}




@end
