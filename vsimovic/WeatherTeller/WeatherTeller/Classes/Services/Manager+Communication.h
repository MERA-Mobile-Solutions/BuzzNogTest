//
//  Manager+Communication.h
//  WeatherTeller
//
//  Created by Vuk Simovic on 9/22/15.
//  Copyright © 2015 Mera. All rights reserved.
//

#import "Manager.h"

@interface Manager (Communication)

- (void)getForecastForLatitude:(float)latitude
                     longitude:(float)longitude
             completionHandler:(void (^)(NSArray *forecasts))completionBlock
                  errorHandler:(void (^)(NSError *error))errorBlock;
@end
