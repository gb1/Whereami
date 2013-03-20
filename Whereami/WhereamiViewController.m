//
//  WhereamiViewController.m
//  Whereami
//
//  Created by Gregor Brett on 19/03/2013.
//  Copyright (c) 2013 Gregor Brett. All rights reserved.
//

#import "WhereamiViewController.h"
#import "BNRMapPoint.h"

@interface WhereamiViewController ()

@end

@implementation WhereamiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [worldView setShowsUserLocation:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    NSLog(@"got here");
    
    if(self){
        //create location manager
        locationManager = [[CLLocationManager alloc]init];
        
        [locationManager setDelegate:self];
        
        //as accurate as possible
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        
        //start looking for location
        //[locationManager startUpdatingLocation];
    }
    
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    NSLog(@"%f", [oldLocation distanceFromLocation:newLocation]);
    
    //how many seconds ago was this loc created?
    NSTimeInterval t = [[newLocation timestamp] timeIntervalSinceNow];
    
    //CLLocationManager will return the last found location of the device first
    //if its more than 3 mins old ignore it
    
    if(t > 180){
        return;
    }
    
    [self foundLocation:newLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Could not find location: %@", error);
}

-(void)dealloc{
    [locationManager setDelegate:nil];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    NSLog(@"location updated");
    
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    [worldView setRegion:region];
    

    
}

-(void)findLocation{
    [locationManager startUpdatingLocation];
    [activityIndicator startAnimating];
    [locationTitleField setHidden:YES];
}

-(void)foundLocation:(CLLocation *)loc{
    CLLocationCoordinate2D coord = [loc coordinate];
    
    //create an instance of BNRMapPoint with the current data
    BNRMapPoint *mp = [[BNRMapPoint alloc]initWithCoordinate:coord title:[locationTitleField text]];
    
    //add it to the map
    [worldView addAnnotation:mp];
    
    //zoom in
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250, 250);
    [worldView setRegion:region animated:YES];
    
    //reset UI
    [locationTitleField setText:@""];
    [activityIndicator stopAnimating];
    [locationTitleField setHidden:NO];
    [locationManager stopUpdatingLocation];
}


#pragma mark UITextView

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self findLocation];
    
    [textField resignFirstResponder];
    
    return YES;
}


@end
