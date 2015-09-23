//
//  ForecastDetailsViewController.m
//  WeatherTeller
//
//  Created by Vuk Simovic on 9/21/15.
//  Copyright © 2015 Mera. All rights reserved.
//

#import "ForecastDetailsViewController.h"

@interface ForecastDetailsViewController ()

@end

@implementation ForecastDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    self.summary.text = self.daily.summary;
    self.temperatureMin.text = [NSString stringWithFormat:@"%.0f", self.daily.temperatureMin];
    self.temperatureMax.text = [NSString stringWithFormat:@"%.0f", self.daily.temperatureMax];
    self.humidity.text = [NSString stringWithFormat:@"%.02f",self.daily.humidity ];
    self.windSpeed.text = [NSString stringWithFormat:@"%.02f",self.daily.windSpeed ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)doneButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
