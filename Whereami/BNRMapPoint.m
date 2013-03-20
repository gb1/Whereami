//
//  BNRMapPoint.m
//  Whereami
//
//  Created by Gregor Brett on 19/03/2013.
//  Copyright (c) 2013 Gregor Brett. All rights reserved.
//

#import "BNRMapPoint.h"

@implementation BNRMapPoint

@synthesize coordinate, title, subtitle;

- (id)init
{
    return [self initWithCoordinate:CLLocationCoordinate2DMake(43.07, -89.32) title:@"Hometown"];
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t
{
    self = [super init];
    if (self) {
        coordinate = c;
        title = t;
    }
    
    return self;
}

@end
