//
//  ForecastViewController.h
//  WeatherTeller
//
//  Created by Vuk Simovic on 9/21/15.
//  Copyright © 2015 Mera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTLocation.h"

@interface ForecastViewController : UIViewController

@property (nonatomic, strong) NSDictionary *icons;
@property (strong, nonatomic) WTLocation *current;
@property (strong, nonatomic) NSArray *forecasts;
@property (nonatomic, strong) WTForecastDaily *currentDaily;
@property (strong, nonatomic) IBOutlet UICollectionView *collection;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *titleItem;


@end
