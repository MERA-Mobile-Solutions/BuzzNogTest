//
//  ForecastDetailsViewController.h
//  WeatherTeller
//
//  Created by Vuk Simovic on 9/21/15.
//  Copyright © 2015 Mera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTForecastDaily.h"

@interface ForecastDetailsViewController : UIViewController

@property (strong, nonatomic) WTForecastDaily *daily;

@property (strong, nonatomic) IBOutlet UILabel *summary;
@property (strong, nonatomic) IBOutlet UILabel *temperatureMin;
@property (strong, nonatomic) IBOutlet UILabel *temperatureMax;
@property (strong, nonatomic) IBOutlet UILabel *humidity;
@property (strong, nonatomic) IBOutlet UILabel *windSpeed;

@end
