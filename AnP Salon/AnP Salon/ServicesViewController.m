//
//  ServicesViewController.m
//  AnP Salon
//
//  
//  Copyright © 2016 TeamD. All rights reserved.
//

#import "ServicesViewController.h"
#import "HairViewController.h"
#import "NailsViewController.h"

@interface ServicesViewController ()

@end

@implementation ServicesViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



-(IBAction)HairClicked:(id)sender{
    
    //goes to hair controller
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"HairViewController"];
    [self presentViewController:viewController animated:YES completion:nil];
    
}



-(IBAction)NailsClicked:(id)sender{
    
    //goes to nails controller
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"NailsViewController"];
    [self presentViewController:viewController animated:YES completion:nil];
}

@end
