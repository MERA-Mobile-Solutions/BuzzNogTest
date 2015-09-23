//
//  WTLocation.m
//  WeatherTeller
//
//  Created by Vuk Simovic on 9/22/15.
//  Copyright © 2015 Mera. All rights reserved.
//

#import "WTLocation.h"

@implementation WTLocation

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:@"WTLocationName"];
    [coder encodeObject:[NSNumber numberWithFloat:self.latitude ] forKey:@"WTLocationLatitude"];
    [coder encodeObject:[NSNumber numberWithFloat:self.longitude ] forKey:@"WTLocationLongitude"];
//    [coder encodeObject:self.currentForecast forKey:@"WTLocationCurrentForecast"];
//    [coder encodeObject:self.dailyForecasts forKey:@"WTLocationDailyForecasts"];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.name = [coder decodeObjectForKey:@"WTLocationName"];
        self.latitude = [[coder decodeObjectForKey:@"WTLocationLatitude"] floatValue];
        self.longitude = [[coder decodeObjectForKey:@"WTLocationLongitude"] floatValue];
        self.currentForecast = nil;
        self.dailyForecasts = nil;
//        self.currentForecast = [coder decodeObjectForKey:@"WTLocationCurrentForecast"];
//        self.dailyForecasts = [coder decodeObjectForKey:@"WTLocationDailyForecasts"];
    }
    return self;
}


- (id)copyWithZone:(NSZone *)zone {
    id copy = [[[self class] alloc] init];
    if (copy) {
        [copy setName:self.name];
        [copy setLatitude:self.latitude];
        [copy setLongitude:self.longitude];

//        NSMutableArray *nForecasts = [[NSMutableArray alloc] init];
//        for(WTForecastDaily *f in self.dailyForecasts){
//
//        }

        [copy setDailyForecasts:[NSArray arrayWithArray:self.dailyForecasts]];
    }
    return copy;
}

@end
