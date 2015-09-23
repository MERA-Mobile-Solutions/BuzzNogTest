//
//  Manager+Communication.m
//  WeatherTeller
//
//  Created by Vuk Simovic on 9/22/15.
//  Copyright © 2015 Mera. All rights reserved.
//

#import "Manager+Communication.h"
#import "WTConstants.h"
#import "AFNetworking.h"
#import "WTForecastDaily.h"

@implementation Manager (Communication)

- (void)getForecastForLatitude:(float)latitude
                      longitude:(float)longitude
              completionHandler:(void (^)(NSArray *forecasts))completionBlock
                   errorHandler:(void (^)(NSError *error))errorBlock {
    
    NSString *url = [NSString stringWithFormat:@"%@%f,%f",kServiceUrl,latitude, longitude];
    
    AFHTTPRequestOperation *op = [self.operationManager GET:url
                                                 parameters:nil
                                                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                        if([responseObject isKindOfClass:[NSDictionary class]]) {
                                                            float lat = 500.0;
                                                            float lon = 500.0;
                                                            
                                                            if([responseObject objectForKey:@"latitude"] != nil && [responseObject objectForKey:@"latitude"] != [NSNull null]) {
                                                                lat = [[responseObject objectForKey:@"latitude"] floatValue];
                                                            }
                                                            
                                                            if([responseObject objectForKey:@"longitude"] != nil && [responseObject objectForKey:@"longitude"] != [NSNull null]) {
                                                                lon = [[responseObject objectForKey:@"longitude"] floatValue];
                                                            }
                                                            
                                                            if(latitude == lat && longitude == lon) {
                                                                if([responseObject objectForKey:@"daily"] != nil && [responseObject objectForKey:@"daily"] != [NSNull null]) {
                                                                    NSDictionary *dailyForecast = [responseObject objectForKey:@"daily"];
                                                                    if([dailyForecast objectForKey:@"data"] != nil && [dailyForecast objectForKey:@"data"] != [NSNull null]) {
                                                                        
                                                                        NSArray *dailyFs = [dailyForecast objectForKey:@"data"];
                                                                        NSMutableArray *forecasts = [[NSMutableArray alloc] init];
                                                                        for(NSDictionary *dailyF in dailyFs) {
                                                                            WTForecastDaily *wtForecast = [[WTForecastDaily alloc] initWithDictionary:dailyF];
                                                                            [forecasts addObject:wtForecast];
                                                                        }
                                                                        completionBlock(forecasts);
                                                                    }
                                                                }
                                                                else {
                                                                    NSInteger errorCode = 1003;
                                                                    NSString *errorMessage = @"Error retriving forecast - no daily forecasts";
                                                                    NSLog(@"Error %li, %@", (long)errorCode, errorMessage);
                                                                    NSError *error = [Manager createCustomErrorWithMessage:errorMessage code:errorCode];
                                                                    errorBlock(error);
                                                                }
                                                            }
                                                            else {
                                                                NSInteger errorCode = 1002;
                                                                NSString *errorMessage = @"Error retriving forecast";
                                                                NSLog(@"Error %li, %@", (long)errorCode, errorMessage);
                                                                NSError *error = [Manager createCustomErrorWithMessage:errorMessage code:errorCode];
                                                                errorBlock(error);
                                                            }
                                                        }
                                                        
                                                        else {
                                                            // response has wrong type
                                                            NSInteger errorCode = 1001;
                                                            NSString *errorMessage = @"Error retriving forecast";
                                                            NSLog(@"Error %li, %@", (long)errorCode, errorMessage);
                                                            NSError *error = [Manager createCustomErrorWithMessage:errorMessage code:errorCode];
                                                            errorBlock(error);
                                                        }
                                                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                        NSLog(@"Error: %@", error);
                                                        errorBlock(error);
                                                    }];
    [op start];
}

@end
