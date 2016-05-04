//
//  MapViewController.m
//  AnP Salon
//
//  Created by Alain Alzuri on 4/1/16.
//  Copyright © 2016 TeamD. All rights reserved.
//

#import "MapViewController.h"
#import "ReviewViewController.h"
#import "User.h"
@import GoogleMaps;

@interface MapViewController ()
{
    NSString *placeID;
    NSURL* urlSalon;
    User * user;
}
@end

@implementation MapViewController

@synthesize webView;

- (void)viewDidLoad {
    [super viewDidLoad];
}



-(void)viewDidAppear:(BOOL)animated{
    //pre loads business id for salon
    urlSalon = [[NSURL alloc]init];
    placeID = @"ChIJOQAP4-O42YgRJZ6sQpw5qNo";
    
    //makes api call with business id
    GMSPlacesClient *client = [GMSPlacesClient sharedClient];
    [client lookUpPlaceID:placeID callback:^(GMSPlace * place, NSError * error) {
       
        //places location marker on map for business location
        GMSMarker *marker = [[GMSMarker alloc]init];
        marker.position = CLLocationCoordinate2DMake(25.761364, -80.337621);
        //loads marker info from api call data
        marker.title = place.name;
        marker.snippet = place.formattedAddress;
        urlSalon = place.website;
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //loads view with business info from api data
            NSURLRequest *request = [NSURLRequest requestWithURL:urlSalon];
            [webView loadRequest:request];
            
            
        });
     }];
    
    user = [User userData];
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
    
    //goes to camera controller
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CameraViewController"];
    [self presentViewController:viewController animated:YES completion:nil];
}

@end
