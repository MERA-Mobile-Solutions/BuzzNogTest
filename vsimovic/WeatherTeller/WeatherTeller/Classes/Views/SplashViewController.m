//
//  SplashViewController.m
//  WeatherTeller
//
//  Created by Vuk Simovic on 9/21/15.
//  Copyright © 2015 Mera. All rights reserved.
//

#import "SplashViewController.h"
#import "WTConstants.h"
#import "Manager.h"
#import "Manager+Communication.h"
#import "Manager+UserData.h"

#import "WTLocation.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)registerObservers {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(locationUpdated:)
               name:kLocationUpdated
             object:nil];
}

- (void)removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self registerObservers];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self removeObservers];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    Manager *manager = [Manager sharedInstance];

    if(![manager isFirstStartDone]) {
        [manager.locationManager requestWhenInUseAuthorization];
        [self startTimer];
        [manager setFirstStartDone:YES];
    }
    else {
        [self checkStatus];
    }

}

- (void)checkStatus{
    Manager *manager = [Manager sharedInstance];
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    switch (status) {
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self stopTimer];
            self.message.text = @"Updating current location";
            [manager.locationManager startUpdatingLocation];
            break;

        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
            [self stopTimer];
            [self loadData];
            break;

        case kCLAuthorizationStatusNotDetermined:
        default:
            break;
    }
}

- (void)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(checkStatus)
                                                userInfo:nil repeats:YES];
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)loadData {
    Manager *manager = [Manager sharedInstance];

    self.message.text = @"Retriving forecasts for locations";
    for (WTLocation *location in manager.userProfile.locations) {
        [manager getForecastForLatitude:location.latitude longitude:location.longitude completionHandler:^(NSArray *forecasts) {
            location.dailyForecasts = forecasts;
            self.message.text = @"";
            [self.activity stopAnimating];

            [self performSegueWithIdentifier:@"MainSegue" sender:self];
        } errorHandler:^(NSError *error) {
            NSLog(@"Error %@", error.description);
            self.message.text = error.description;
            [self.activity stopAnimating];
        }];
    }
}

- (void)locationUpdated:(NSNotification *) notification {
    self.message.text = @"Current location updated";
    [self loadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
