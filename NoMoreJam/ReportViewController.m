//
//  NoMoreJamFirstViewController.m
//  NoMoreJam
//
//  Created by Hung Mai on 9/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ReportViewController.h"
#import "CoreLocation/CoreLocation.h"

@interface ReportViewController ()

@property (strong,nonatomic) CLLocationManager *locationManager;

@end

@implementation ReportViewController
@synthesize locationManager = _locationManager;

-(CLLocationManager *)locationManager
{
    if (!_locationManager)
    {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
- (IBAction)buttonPressed:(UIButton *)sender
{
    CLLocation *location = self.locationManager.location;
    if ([sender.titleLabel.text isEqualToString:@"Jam"]) {
        NSLog(@"[Jam]Current Location: %@",location);
    } else if ([sender.titleLabel.text isEqualToString:@"Dodge"]) {
        NSLog(@"[Dodge]Current Location: %@",location);        
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
