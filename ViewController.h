//
//  ViewController.h
//  ChimenCompass
//
//  Created by AKI on 2015/7/28.
//  Copyright (c) 2015年 AKI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface ViewController : UIViewController<CLLocationManagerDelegate>
{
    IBOutlet UIImageView *imgCompass;
    BOOL isLocation;
    
    IBOutlet UISegmentedControl *segNorth;
    IBOutlet UILabel *lblAlt;
    IBOutlet UILabel *lblLat;
    IBOutlet UILabel *lblLong;
    
}

@property (nonatomic,retain) CLLocationManager *locationManager;
@property (nonatomic,retain) CLHeading *currentHeading;

@end

