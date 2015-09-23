//
//  UserProfile.h
//  WeatherTeller
//
//  Created by Vuk Simovic on 9/23/15.
//  Copyright © 2015 Mera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTLocation.h"
#import "WTForecastDaily.h"

@interface UserProfile : NSObject

@property (nonatomic, strong) NSMutableArray *locations;
@property (nonatomic, assign) NSInteger currentLocationIndex;

- (instancetype) init;

- (void) save;
- (void)load;

@end
