//
//  LocationsViewController.m
//  WeatherTeller
//
//  Created by Vuk Simovic on 9/22/15.
//  Copyright © 2015 Mera. All rights reserved.
//

#import "LocationsViewController.h"
#import "Manager.h"
#import "LocationTableViewCell.h"

@interface LocationsViewController ()

@end

@implementation LocationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[Manager sharedInstance].userProfile.locations count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    WTLocation *location = [[Manager sharedInstance].userProfile.locations objectAtIndex:indexPath.row];
    LocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationCellIdentifier" forIndexPath:indexPath];

    cell.locationName.text = location.name;

    return (UITableViewCell *)cell;
}



- (IBAction)doneButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)addButtonPressed:(id)sender {
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
