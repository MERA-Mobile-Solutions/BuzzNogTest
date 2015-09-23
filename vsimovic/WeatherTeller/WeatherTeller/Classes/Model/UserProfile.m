//
//  UserProfile.m
//  WeatherTeller
//
//  Created by Vuk Simovic on 9/23/15.
//  Copyright © 2015 Mera. All rights reserved.
//

#import "UserProfile.h"

@implementation UserProfile


- (instancetype) init {
    self = [super init];
    if(self != nil) {
        self.locations = [[NSMutableArray alloc] init];
        self.currentLocationIndex = -1;
    }
    return self;
}

- (void)save {
    NSMutableDictionary *upDictionary = [[NSMutableDictionary alloc] init];
    NSData *locationsEncoded = [NSKeyedArchiver archivedDataWithRootObject:self.locations];
    [upDictionary setObject:locationsEncoded forKey:@"UserProfileLocations"];
    [upDictionary setObject:[NSNumber numberWithInteger:self.currentLocationIndex] forKey:@"UserProfileCurrentLocationIndex"];

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:upDictionary forKey:@"UserProfile"];
    [ud synchronize];
}

- (void)load {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];

    NSDictionary *upDictionary = [ud dictionaryForKey:@"UserProfile"];
    if (upDictionary != nil) {
        if ([upDictionary objectForKey:@"UserProfileLocations"] != nil) {
            NSData *locationsEncoded = [upDictionary objectForKey:@"UserProfileLocations"];
            self.locations = [NSKeyedUnarchiver unarchiveObjectWithData:locationsEncoded];
        }
        else {
            if(self.locations == nil) {
                self.locations = [[NSMutableArray alloc] init];
            }
        }
        if ([upDictionary objectForKey:@"UserProfileCurrentLocationIndex"] != nil) {
            self.currentLocationIndex = [[upDictionary objectForKey:@"UserProfileCurrentLocationIndex"] integerValue];
        }
        else {
            self.currentLocationIndex = 0;
        }
    }
    else {
        [self save];
    }

}


@end
