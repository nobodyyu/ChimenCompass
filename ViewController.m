//
//  ViewController.m
//  ChimenCompass
//
//  Created by AKI on 2015/7/28.
//  Copyright (c) 2015年 AKI. All rights reserved.
//

#import "ViewController.h"
#import "TaichiView.h"
#import <CoreLocation/CoreLocation.h>


@interface ViewController ()

@end

@implementation ViewController
@synthesize locationManager,currentHeading;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    imgCompass.center = self.view.center;
    TaichiView *taiChiView1 = [[TaichiView alloc] initWithFrame:CGRectMake(0, 0, 20.0f, 20.0f)];
    taiChiView1.center = self.view.center;
    [self.view addSubview:taiChiView1];
    
    self.currentHeading = [[CLHeading alloc] init];
    
    
    
    if ([CLLocationManager locationServicesEnabled]) //處理定位
    {
        if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"請先開啟定位" delegate:self cancelButtonTitle:@"確認" otherButtonTitles:nil];
            alert.tag =999;
            [self.view addSubview:alert];
            [alert show];
            isLocation = NO;
            return;
        }else{
            
            isLocation = YES;
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            self.locationManager.headingFilter = 1;
            self.locationManager.delegate = self;
            
            
            if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
                [locationManager requestWhenInUseAuthorization];
            }
            
            [self.locationManager startUpdatingLocation];
            [self.locationManager startUpdatingHeading];
            
            
            
        }
    }
    else {
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"請先開啟定位" delegate:self cancelButtonTitle:@"確認" otherButtonTitles:nil];
        alert.tag =999;
        [self.view addSubview:alert];
        isLocation = NO;
        [alert show];
        return;
        
    }
    
    
    
    
    
    
}


#pragma mark ------ location delegate ----


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation* location = [locations objectAtIndex:0];
    
    NSLog(@"%f",location.horizontalAccuracy);
    NSLog(@"%f-%f",location.coordinate.latitude,location.coordinate.longitude);
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",location.coordinate.latitude] forKey:@"Lat"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",location.coordinate.longitude] forKey:@"Lng"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",location.altitude] forKey:@"Alt"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    lblLat.text = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    lblLong.text = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    lblAlt.text = [NSString stringWithFormat:@"%f",location.altitude];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@",error);
}

#pragma LocationManager Delegate
-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    
    
    self.currentHeading = newHeading;
    
    if(segNorth.selectedSegmentIndex==1){
        float heading = newHeading.magneticHeading; //in degrees
        float headingDegrees = (heading*M_PI/180); //assuming needle points to top of iphone. convert to radians
        imgCompass.transform = CGAffineTransformMakeRotation(headingDegrees);
        
        
        NSLog(@"heading %f",heading);
        NSLog(@"heading %f",headingDegrees);
    }else{
        float heading = newHeading.trueHeading; //in degrees
        float headingDegrees = (heading*M_PI/180); //assuming needle points to top of iphone. convert to radians
        imgCompass.transform = CGAffineTransformMakeRotation(headingDegrees);
        
        NSLog(@"heading %f",heading);
        
        NSLog(@"heading %f",headingDegrees);
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
