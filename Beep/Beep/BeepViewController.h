//
//  BeepViewController.h
//  Beep
//
//  Created by Daniel Young on 2014-03-28.
//  Copyright (c) 2014 Beep Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface BeepViewController : UIViewController {
    SystemSoundID playSoundID;
}
@property (nonatomic, strong) NSArray *beaconsArray;
@end
