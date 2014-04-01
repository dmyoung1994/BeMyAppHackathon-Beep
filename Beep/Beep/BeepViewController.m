//
//  BeepViewController.m
//  Beep
//
//  Created by Daniel Young on 2014-03-28.
//  Copyright (c) 2014 Beep Inc. All rights reserved.
//

#import "BeepViewController.h"
#import "ESTBeaconManager.h"
#import "BeepAroundMeController.h"

@interface BeepViewController () <ESTBeaconManagerDelegate>
@property (nonatomic, strong) ESTBeaconManager *beaconManager;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLavel;
@property (nonatomic, strong) ESTBeaconRegion *region;
@end

@implementation BeepViewController

- (IBAction)playShound:(id)sender {
    AudioServicesPlaySystemSound(playSoundID);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBarHidden = YES;
    
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    
    /*
     * Creates sample region object (you can additionaly pass major / minor values).
     *
     * We specify it using only the ESTIMOTE_PROXIMITY_UUID because we want to discover all
     * hardware beacons with Estimote's proximty UUID.
     */
    
    self.region = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID
                                                      identifier:@"EstimoteSampleRegion"];
    
    /*
     * Starts looking for Estimote beacons.
     * All callbacks will be delivered to beaconManager delegate.
     */
    [self.beaconManager startRangingBeaconsInRegion:self.region];
    
    NSURL *soundFile = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"gongSound" ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundFile, &playSoundID);
}

- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    self.beaconsArray = beacons;
    ESTBeacon *beacon = [self.beaconsArray objectAtIndex:0];
    if ([self.beaconsArray objectAtIndex:1]) {
      ESTBeacon *match = [self.beaconsArray objectAtIndex:1];
    } else {
        self.topLabel.text = @"No Matches Found!";
        self.bottomLavel.text = NULL;
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    /*
     *Stops ranging after exiting the view.
     */
    [self.beaconManager stopRangingBeaconsInRegion:self.region];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue destinationViewController] isKindOfClass:[BeepAroundMeController class]]) {
        BeepAroundMeController *con = (BeepAroundMeController *)[segue destinationViewController];
        con.beaconsArray = self.beaconsArray;
    }
}


@end
