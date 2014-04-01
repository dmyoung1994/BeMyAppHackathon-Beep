//
//  BeepAroundMeController.m
//  Beep
//
//  Created by Daniel Young on 2014-03-29.
//  Copyright (c) 2014 Beep Inc. All rights reserved.
//

#import "BeepAroundMeController.h"
#import "BeepViewController.h"
#import "ESTBeaconManager.h"

@interface BeepAroundMeController ()
@property (weak, nonatomic) IBOutlet MKMapView *parkingMap;
@property (strong, nonatomic) MKUserLocation *userLocation;
@property (strong, nonatomic) NSArray *MKAnnotationArray;
@end


@implementation BeepAroundMeController

- (CLLocationCoordinate2D)coordinate {
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = self.userLocation.coordinate.latitude;
    coordinate.longitude = self.userLocation.coordinate.longitude;
    return coordinate;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _parkingMap.delegate = self;
    [self centerMapOnUser];
    _parkingMap.showsUserLocation = YES;
    //_parkingMap.
    [self createMKAnnotations:self.beaconsArray userLocation:self.userLocation];
    
}

- (void)centerMapOnUser {
    MKUserLocation *userLocation = _parkingMap.userLocation;
    self.userLocation = userLocation;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance (
                                        userLocation.location.coordinate, 300, 300);
    [_parkingMap setRegion:region animated:YES];
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *) userLocation{
    _parkingMap.centerCoordinate = userLocation.location.coordinate;
    self.userLocation = userLocation;
}

- (void)createMKAnnotations:(NSArray *)beaconsArray userLocation:(MKUserLocation *)location {
    //NSLog(@"%d", length);
    int length = (int)[beaconsArray count];
    float startLat = 0.000089832;
    float startLong = 0.0001427437;
    for (int i=0; i<length; i++) {
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        ESTBeacon *beacon = [beaconsArray objectAtIndex:i];
        NSLog(@"%ld", beacon.proximity);
        if (beacon.proximity == 2) {
            float pinLat = location.coordinate.latitude + startLat;
            float pinLong = location.coordinate.longitude + startLong;
            CLLocationCoordinate2D pinLoc = CLLocationCoordinate2DMake(pinLat, pinLong);
            [annotation setCoordinate:pinLoc];
            startLat += 0.00001;
            startLong += 0.0001;
        }
        
        [annotation setTitle:@"Person"];
        [_parkingMap addAnnotation:annotation];
    }

}




@end
