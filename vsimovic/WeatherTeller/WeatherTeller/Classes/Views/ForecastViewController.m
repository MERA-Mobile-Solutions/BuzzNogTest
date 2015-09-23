//
//  ForecastViewController.m
//  WeatherTeller
//
//  Created by Vuk Simovic on 9/21/15.
//  Copyright © 2015 Mera. All rights reserved.
//

#import "ForecastViewController.h"
#import "ForecastCollectionViewCell.h"
#import "SKYIconView.h"
#import "UIColor+WeatherTeller.h"
#import "Manager.h"
#import "ForecastDetailsViewController.h"

@interface ForecastViewController ()

@end

@implementation ForecastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.icons = @{ @"clear-day":@(SKYClearDay),
                    @"clear-night":@(SKYClearNight),
                    @"partly-cloudy-day":@(SKYPartlyCloudyDay),
                    @"partly-cloudy-night":@(SKYPartlyCloudyNight),
                    @"cloudy":@(SKYCloudy),
                    @"rain":@(SKYRain),
                    @"sleet":@(SKYSleet),
                    @"snow":@(SKYSnow),
                    @"wind":@(SKYWind),
                    @"fog":@(SKYFog)};


    [self.collection setPagingEnabled:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.collection.collectionViewLayout;
    layout.itemSize = self.collection.frame.size;
    layout.headerReferenceSize = CGSizeZero;
    layout.footerReferenceSize = CGSizeZero;
//    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
}




- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    Manager *manager = [Manager sharedInstance];
    self.current = [manager.userProfile.locations objectAtIndex:manager.userProfile.currentLocationIndex];
    self.forecasts = self.current.dailyForecasts;

    [self setupFormatedTitle:self.current.name];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.forecasts count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    WTForecastDaily *daily = (WTForecastDaily *)[self.forecasts objectAtIndex:indexPath.row];
    self.currentDaily = daily;

    ForecastCollectionViewCell *cell= (ForecastCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ForecastCollectionCellIdentifier" forIndexPath:indexPath];

    cell.icon.color = [UIColor colorWithRed:96.0/255.0 green:189.0/255.0 blue:224.0/255.0 alpha:1.0];
    NSString *iconName = (NSString *)daily.wIcon;
    if(iconName != nil && [iconName length] > 0){
        cell.icon.type = [[self.icons valueForKey:iconName] integerValue];
    }
    cell.backgroundColor=[UIColor clearColor];

    cell.summary.text = daily.summary;
    cell.temperature.text = [NSString stringWithFormat:@"%.0f - %.0f",daily.temperatureMin, daily.temperatureMax];
    cell.humidity.text = [NSString stringWithFormat:@"%.02f",daily.humidity ];
    cell.windSpeed.text = [NSString stringWithFormat:@"%.02f",daily.windSpeed ];

    return (UICollectionViewCell *)cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    self.selectedForecast = [self.forecasts objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ForecastDetailsSegue" sender:self];
}

- (void)setupFormatedTitle:(NSString *)title {
    self.titleItem.title = title;
    UIFont * font = [UIFont fontWithName:@"HelveticaNeue" size:17];
    NSDictionary * attributes = @{NSFontAttributeName: font};

    [self.titleItem setTitleTextAttributes:attributes forState:UIControlStateNormal];
}


- (IBAction)locationPressed:(id)sender {
    [self performSegueWithIdentifier:@"ManageLocationsSegue" sender:self];
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"ForecastDetailsSegue"]) {
        ForecastDetailsViewController* details = segue.destinationViewController;
        details.daily = self.currentDaily;
    }
}


@end
