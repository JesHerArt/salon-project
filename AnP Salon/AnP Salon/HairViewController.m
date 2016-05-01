//
//  HairViewController.m
//  AnP Salon
//
//  Created by alain alberto alzuri on 5/1/16.
//  Copyright © 2016 TeamD. All rights reserved.
//

#import "HairViewController.h"

@implementation HairViewController


- (void) viewDidLoad {
    
    
    [super viewDidLoad];
}
-(IBAction)BackClicked:(id)sender{
    
    //goes back to services controller
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *vc = (UITabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"UITabBarController"];
    [vc setSelectedIndex:1];
    
    [self presentViewController:vc animated:YES completion:nil];
}


@end
