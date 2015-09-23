//
//  Manager+UserData.m
//  WeatherTeller
//
//  Created by Vuk Simovic on 9/22/15.
//  Copyright © 2015 Mera. All rights reserved.
//

#import "Manager+UserData.h"

@implementation Manager (UserData)
- (BOOL)isFirstStartDone {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:@"ApplicationFirstStartDone"];
}


- (void)setFirstStartDone:(BOOL)startFlag {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:startFlag forKey:@"ApplicationFirstStartDone"];
    [userDefaults synchronize];
}

@end
