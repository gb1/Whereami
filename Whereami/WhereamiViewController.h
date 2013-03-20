//
//  WhereamiViewController.h
//  Whereami
//
//  Created by Gregor Brett on 19/03/2013.
//  Copyright (c) 2013 Gregor Brett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface WhereamiViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate>{
    CLLocationManager *locationManager;
    
    IBOutlet MKMapView *worldView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UITextField *locationTitleField;
}

-(void)findLocation;
-(void)foundLocation:(CLLocation *)loc;

@end
