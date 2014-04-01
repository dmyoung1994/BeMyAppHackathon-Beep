//
//  BeepAroundMeController.h
//  Beep
//
//  Created by Daniel Young on 2014-03-29.
//  Copyright (c) 2014 Beep Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface BeepAroundMeController : UIViewController <MKMapViewDelegate, MKAnnotation>
@property (nonatomic, strong) NSArray *beaconsArray;

@end
