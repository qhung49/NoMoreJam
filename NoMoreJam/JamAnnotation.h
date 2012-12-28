//
//  PlaceAnnotation.h
//  FlickrBrowser
//
//  Created by Hung Mai on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface JamAnnotation : NSObject <MKAnnotation>

+ (JamAnnotation *)annotationForLocation:(CLLocation *)location;

@property (nonatomic,strong) CLLocation *location;

@end
