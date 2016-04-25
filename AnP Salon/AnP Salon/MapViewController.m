//
//  MapViewController.m
//  AnP Salon
//
//  Created by Alain Alzuri on 4/1/16.
//  Copyright © 2016 TeamD. All rights reserved.
//

#import "MapViewController.h"
#import "ReviewViewController.h"
@import GoogleMaps;

@interface MapViewController ()
{
    NSString *placeID;
    NSURL* urlSalon;
}
@end

@implementation MapViewController
@synthesize webView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    
    urlSalon = [[NSURL alloc]init];
    placeID = @"ChIJOQAP4-O42YgRJZ6sQpw5qNo";
    
    
    GMSPlacesClient *client = [GMSPlacesClient sharedClient];
    [client lookUpPlaceID:placeID callback:^(GMSPlace * place, NSError * error) {
        //name
        NSLog(@"place name: %@" , place.name);
        //openNowStatus
        NSLog(@"open now: %ld" , (long)place.openNowStatus);
        if(place.openNowStatus == 1){
            NSLog(@"Open/Closed: Open");
        }
        else if (place.openNowStatus == 2){
            NSLog(@"Open/Closed: Closed");
        }
        //phoneNumber
        NSLog(@"phone number: %@" , place.phoneNumber);
        //formattedAddress
        NSLog(@"address: %@" , place.formattedAddress);
        
        GMSMarker *marker = [[GMSMarker alloc]init];
        marker.position = CLLocationCoordinate2DMake(25.761364, -80.337621);
        marker.title = place.name;
        marker.snippet = place.formattedAddress;
        urlSalon = place.website;
        NSLog(@"URL : %@", urlSalon);
        
        NSURLRequest *request = [NSURLRequest requestWithURL:urlSalon];
        [webView loadRequest:request];
        
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)ReviewClicked:(id)sender{
    
    //goes to review controller
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ReviewViewController"];
    [self presentViewController:viewController animated:YES completion:nil];

}

-(IBAction)CameraClicked:(id)sender{
    
    //camera code goes here
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CameraViewController"];
    [self presentViewController:viewController animated:YES completion:nil];
}

@end
