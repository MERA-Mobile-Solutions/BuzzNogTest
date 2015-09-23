//
//  ForecastCollectionViewCell.h
//  WeatherTeller
//
//  Created by Vuk Simovic on 9/22/15.
//  Copyright © 2015 Mera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKYIconView.h"

@interface ForecastCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *summary;
@property (strong, nonatomic) IBOutlet SKYIconView *icon;
@property (strong, nonatomic) IBOutlet UILabel *temperature;
@property (strong, nonatomic) IBOutlet UILabel *humidity;
@property (strong, nonatomic) IBOutlet UILabel *windSpeed;

@end
