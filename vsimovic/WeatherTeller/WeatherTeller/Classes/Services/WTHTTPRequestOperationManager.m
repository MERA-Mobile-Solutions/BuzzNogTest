//
//  WTHTTPRequestOperationManager.m
//  WeatherTeller
//
//  Created by Ugljesha on 9/23/15.
//  Copyright © 2015 Mera. All rights reserved.
//

#import "WTHTTPRequestOperationManager.h"

@implementation WTHTTPRequestOperationManager

+ (WTHTTPRequestOperationManager *)sharedInstance {
    __strong static WTHTTPRequestOperationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WTHTTPRequestOperationManager alloc] init];
        
//        AFSecurityPolicy *policy = [[AFSecurityPolicy alloc] init];
//        [policy setAllowInvalidCertificates:YES];
//        
//        [(AFHTTPRequestOperationManager*)sharedInstance setSecurityPolicy:policy];
        ((AFHTTPRequestOperationManager*)sharedInstance).requestSerializer = [AFJSONRequestSerializer serializer];
        
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
        [responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/html", nil]];
        ((AFHTTPRequestOperation *)sharedInstance).responseSerializer = responseSerializer;
    });
    return sharedInstance;
}


- (AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)request success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    return [super HTTPRequestOperationWithRequest:request
                                          success:success
                                          failure:failure];
}

@end
