//
//  WTLocation.h
//  WeatherTeller
//
//  Created by Vuk Simovic on 9/22/15.
//  Copyright © 2015 Mera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTForecastCurrent.h"
#import "WTForecastDaily.h"

@interface WTLocation : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) long latitude;
@property (nonatomic, assign) long longitude;

@property (nonatomic, strong) WTForecastCurrent *currentForecast;
@property (nonatomic, strong) NSArray *dailyForecasts;

- (void)encodeWithCoder:(NSCoder *)coder;
- (id)initWithCoder:(NSCoder *)coder;

- (id)copyWithZone:(NSZone *)zone;

@end
