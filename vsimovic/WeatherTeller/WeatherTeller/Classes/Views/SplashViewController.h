//
//  SplashViewController.h
//  WeatherTeller
//
//  Created by Vuk Simovic on 9/21/15.
//  Copyright © 2015 Mera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SplashViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (strong, nonatomic) IBOutlet UILabel *message;
@property (strong, nonatomic) NSTimer *timer;

@end
