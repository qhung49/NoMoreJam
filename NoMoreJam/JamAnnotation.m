//
//  PlaceAnnotation.m
//  FlickrBrowser
//
//  Created by Hung Mai on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JamAnnotation.h"

@interface JamAnnotation ()

@end

@implementation JamAnnotation

@synthesize location = _location;

+ (JamAnnotation *)annotationForLocation:(CLLocation *)location;
{
    JamAnnotation *annotation = [[JamAnnotation alloc] init];
    annotation.location = location;
    return annotation;
}

- (NSString *)title
{
    return @"Title";
}

- (NSString *) subtitle
{
    return @"Subtitle";
}

- (CLLocationCoordinate2D)coordinate
{
    return self.location.coordinate;
}

@end
