//
//  Manager+UserData.h
//  WeatherTeller
//
//  Created by Vuk Simovic on 9/22/15.
//  Copyright © 2015 Mera. All rights reserved.
//

#import "Manager.h"

@interface Manager (UserData)

- (BOOL)isFirstStartDone;
- (void)setFirstStartDone:(BOOL)startFlag;

@end
