//
//  BeepAroundYouViewController.m
//  Beep
//
//  Created by Daniel Young on 2014-03-29.
//  Copyright (c) 2014 Beep Inc. All rights reserved.
//

#import "BeepAroundYouViewController.h"

@interface BeepAroundYouViewController ()

@end

@implementation BeepAroundYouViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{

    // Do any additional setup after loading the view.
    _aroundYouMap.delegate = self;

    [self centerMapOnUser];

}

// Dispose of any resources that can be recreated.

- (void)centerMapOnUser {
    MKUserLocation *userLocation = _aroundYouMap.userLocation;
    NSLog(@"Location object %@", userLocation.location);
    MKCoordinateRegion region =
    MKCoordinateRegionMakeWithDistance (
                                        userLocation.location.coordinate, 300, 300);
    [_aroundYouMap setRegion:region animated:YES];

}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    _aroundYouMap.centerCoordinate =
    userLocation.location.coordinate;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
