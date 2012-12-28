//
//  NoMoreJamSecondViewController.m
//  NoMoreJam
//
//  Created by Hung Mai on 9/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TrafiicViewController.h"
#import "MapKit/MapKit.h"
#import "JamAnnotation.h"

#define DEFAULT_SPAN 250
#define ANNOTATION_IDENTIFIER @"Annotation"

@interface TrafiicViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,strong) NSArray* jamAnnotations; //of id<MKAnnotation>

@end

@implementation TrafiicViewController
@synthesize mapView = _mapView;
@synthesize jamAnnotations = _jamAnnotations;

-(void)zoomMapView:(MKMapView*)mapView toFitCurrentLocation:(MKUserLocation *)userLocation
{
    if(!userLocation) return;
    
    MKCoordinateRegion zoomRegion = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, DEFAULT_SPAN, DEFAULT_SPAN);
    zoomRegion = [mapView regionThatFits:zoomRegion];
    [mapView setRegion:zoomRegion animated:YES];
}

- (NSArray *)annotationsFromDummy
{
    NSMutableArray *annotations = [NSMutableArray array];
    for (int i=1; i<5; i++)
    {
        CLLocation *location = 
            [[CLLocation alloc] initWithLatitude:(self.mapView.userLocation.coordinate.latitude+(i/4000.0)) longitude:(self.mapView.userLocation.coordinate.longitude+(i/4000.0))];
        NSLog(@"Annotation: %@",location);
        [annotations addObject:[JamAnnotation annotationForLocation:location]];
    }
    return annotations;
}

-(void)zoomToFitMapAnnotations:(MKMapView*)mapView
{
    if([mapView.annotations count] == 0)
        return;
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in mapView.annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        if (MKMapRectIsNull(zoomRect)) {
            zoomRect = pointRect;
        } else {
            zoomRect = MKMapRectUnion(zoomRect, pointRect);
        }
    }
    zoomRect = [mapView mapRectThatFits:zoomRect];
    [mapView setVisibleMapRect:zoomRect edgePadding:UIEdgeInsetsFromString(@"{3,3,3,3}") animated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    self.mapView.showsUserLocation = YES; 
    //self.mapView.zoomEnabled = FALSE;
    //self.mapView.scrollEnabled = FALSE;
    self.mapView.delegate = self;
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *aView = [mapView dequeueReusableAnnotationViewWithIdentifier:ANNOTATION_IDENTIFIER];
    if (!aView)
    {
        aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ANNOTATION_IDENTIFIER];
        aView.canShowCallout = YES;
        UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        aView.rightCalloutAccessoryView = rightButton;
    }
    aView.annotation = annotation;
    return aView;
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"Current location: %@",mapView.userLocation.location);
    [self zoomMapView:mapView toFitCurrentLocation:mapView.userLocation];
    if (self.mapView.annotations) [self.mapView removeAnnotations:self.mapView.annotations];
    self.jamAnnotations = [self annotationsFromDummy];
    [self.mapView addAnnotations:self.jamAnnotations];
    //[self zoomToFitMapAnnotations:self.mapView];
}

-(void)mapViewWillStartLoadingMap:(MKMapView *)mapView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
