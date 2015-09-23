//
//  Manager.h
//  WeatherTeller
//
//  Created by Vuk Simovic on 9/22/15.
//  Copyright © 2015 Mera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Reachability.h"
#import "WTHTTPRequestOperationManager.h"
#import "UserProfile.h"
#import "WTLocation.h"

@interface Manager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong) WTHTTPRequestOperationManager *operationManager;
@property (nonatomic, strong) Reachability *reachability;

@property (nonatomic, strong) UserProfile *userProfile;

@property (nonatomic, strong) CLLocationManager *locationManager;


+ (NSError *)createCustomErrorWithMessage:(NSString *)message code:(NSInteger)code;
+ (NSError *)createCustomErrorWithMessage:(NSString *)message code:(NSInteger)code underlyingError:(NSError *)underlyingError;

+ (Manager *)sharedInstance;

- (void)initDefaultCurrentLocation;

- (void)startLocationManagerUpdate;
- (void)stopLocationManagerUpdate;

@end
