//
//  WTForecast.h
//  WeatherTeller
//
//  Created by Vuk Simovic on 9/22/15.
//  Copyright © 2015 Mera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTForecast : NSObject <NSCoding>

@property (nonatomic, assign) double time;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *wIcon;
@property (nonatomic, assign) float temperature;
@property (nonatomic, assign) float dewPoint;
@property (nonatomic, assign) float humidity;
@property (nonatomic, assign) float windSpeed;
@property (nonatomic, assign) float windBearing;
@property (nonatomic, assign) float visibility;
@property (nonatomic, assign) float cloudCover;
@property (nonatomic, assign) float pressure;
@property (nonatomic, assign) float ozone;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

- (void)encodeWithCoder:(NSCoder *)coder;
- (id)initWithCoder:(NSCoder *)coder;

@end
