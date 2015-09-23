//
//  Manager.m
//  WeatherTeller
//
//  Created by Vuk Simovic on 9/22/15.
//  Copyright © 2015 Mera. All rights reserved.
//

#import "Manager.h"
#import "WTConstants.h"
#import "WTHTTPRequestOperationManager.h"

@implementation Manager


static Manager *sharedObject = nil;


+ (NSError *)createCustomErrorWithMessage:(NSString *)message code:(NSInteger)code {
    NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
    [errorDetail setValue:message forKey:NSLocalizedDescriptionKey];
    NSError *error = [[NSError alloc] initWithDomain:kWTErrorDomain code:code userInfo:errorDetail];
    
    return error;
}

+ (NSError *)createCustomErrorWithMessage:(NSString *)message code:(NSInteger)code underlyingError:(NSError *)underlyingError {
    NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
    [errorDetail setValue:message forKey:NSLocalizedDescriptionKey];
    [errorDetail setValue:underlyingError forKey:NSUnderlyingErrorKey];
    NSError *error = [[NSError alloc] initWithDomain:kWTErrorDomain code:code userInfo:errorDetail];
    
    return error;
}

+ (Manager *)sharedInstance {
    static dispatch_once_t _singletonPredicate;

    dispatch_once(&_singletonPredicate, ^{
        sharedObject = [[super allocWithZone:nil] init];
    });

    return sharedObject;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [self sharedInstance];
}


- (id)init {
    self = [super init];
    if(self != nil) {
        self.reachability = [Reachability reachabilityForInternetConnection];
        self.operationManager = [WTHTTPRequestOperationManager sharedInstance];

        self.userProfile = [[UserProfile alloc] init];
        [self.userProfile load];

        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reachabilityChanged:)
                                                     name:kReachabilityChangedNotification
                                                   object:nil];
    }
    return self;
}


#pragma mark - Reachability changed
- (void)reachabilityChanged:(NSNotification *) notification {
    if(![self.reachability isReachable]) {
        NSLog(@"Offline mode");
    }
    else {
        NSLog(@"Online mode");
    }
}


- (void)initDefaultCurrentLocation {
    if([self.userProfile.locations count] == 0) {
        WTLocation *defaultLocation = [[WTLocation alloc] init];
        defaultLocation.name = @"Default location";
        defaultLocation.latitude = 37.8267f;
        defaultLocation.longitude = -122.423f;
        [self.userProfile.locations addObject:defaultLocation];
        self.userProfile.currentLocationIndex = 0;
        [self.userProfile save];
    }
}

#pragma mark - Location manager
- (void)startLocationManagerUpdate {
    [self.locationManager startUpdatingLocation];
}

- (void)stopLocationManagerUpdate {
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *current = [locations lastObject];
    WTLocation *currentLocation = [self.userProfile.locations objectAtIndex:0];
    currentLocation.latitude = current.coordinate.latitude;
    currentLocation.longitude = current.coordinate.longitude;
    currentLocation.name = @"Current location";
    [self.userProfile save];

    [self stopLocationManagerUpdate];

    [[NSNotificationCenter defaultCenter] postNotificationName:kLocationUpdated object:nil];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error: %@",error.description);
//    [self initDefaultCurrentLocation];
}

@end
