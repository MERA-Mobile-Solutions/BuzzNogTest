//
//  WTHTTPRequestOperationManager.h
//  WeatherTeller
//
//  Created by Ugljesha on 9/23/15.
//  Copyright © 2015 Mera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface WTHTTPRequestOperationManager : AFHTTPRequestOperationManager

+ (WTHTTPRequestOperationManager *)sharedInstance;

- (AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)request success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure ;

@end
