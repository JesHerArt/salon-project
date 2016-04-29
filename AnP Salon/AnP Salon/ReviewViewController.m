//
//  ReviewViewController.m
//  AnP Salon
//
//  Created by alain alberto alzuri on 4/23/16.
//  Copyright © 2016 TeamD. All rights reserved.
//

#import "ReviewViewController.h"
#import "User.h"

@interface ReviewViewController ()

@end

@implementation ReviewViewController
{
    User *user;
}
@synthesize reviewTxt,cancelBtn,sendBtn, slider;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)CancelClicked:(id)sender{
    
    //goes back to map controller
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *vc = (UITabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"UITabBarController"];
    [vc setSelectedIndex:3];
    
    [self presentViewController:vc animated:YES completion:nil];
}

//post review to DB
-(IBAction)SendClicked:(id)sender{
    
    // add review to user object
    user = [User userData];
    user.review = reviewTxt.text;
    NSString* formattedNumber = [NSString stringWithFormat:@"%.01f", slider.value];
    user.rating = formattedNumber;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *vc = (UITabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"UITabBarController"];
    [vc setSelectedIndex:3];
    
    [self presentViewController:vc animated:YES completion:nil];
}



@end
