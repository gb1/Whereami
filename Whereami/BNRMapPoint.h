//
//  BNRMapPoint.h
//  Whereami
//
//  Created by Gregor Brett on 19/03/2013.
//  Copyright (c) 2013 Gregor Brett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface BNRMapPoint : NSObject <MKAnnotation>{
    
}

-(id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;

@end
