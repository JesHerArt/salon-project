//
//  LoginViewController.m
//  AnP Salon
//
//  
//  Copyright © 2016 TeamD. All rights reserved.
//

#import "LoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKCoreKit/FBSDKAccessToken.h>
#import <FBSDKCoreKit/FBSDKProfile.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "User.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
{
    User *user;
    UITabBarController *vc;
    UIStoryboard *storyboard;
}

@synthesize name, email, imgView,lblTxt, lblTxt2;

//When viewDidLoad launches, it will create a Facebook login button and place it in the user's screen.
//The facebook login button, will make you sign in with Facebook, and ask for permission to read the user's
//public profile and email in order to add it as a database entry.
- (void)viewDidLoad {
    [super viewDidLoad];
    lblTxt.attributedText = [[NSAttributedString alloc] initWithString:@"A & P" attributes:@{ NSStrokeColorAttributeName : [UIColor blackColor], NSForegroundColorAttributeName : [UIColor whiteColor], NSStrokeWidthAttributeName : @-1.0 }];
    lblTxt2.attributedText = [[NSAttributedString alloc] initWithString:@"Beauty Salon" attributes:@{ NSStrokeColorAttributeName : [UIColor blackColor], NSForegroundColorAttributeName : [UIColor whiteColor], NSStrokeWidthAttributeName : @-1.0 }];
    
    //image array for animated login screen
    
    NSArray *imageNames = @[@"pics/tmp-0.gif", @"pics/tmp-1.gif", @"pics/tmp-2.gif", @"pics/tmp-3.gif", @"pics/tmp-4.gif", @"pics/tmp-5.gif", @"pics/tmp-6.gif", @"pics/tmp-7.gif", @"pics/tmp-8.gif", @"pics/tmp-9.gif", @"pics/tmp-10.gif", @"pics/tmp-11.gif", @"pics/tmp-12.gif"
                            , @"pics/tmp-13.gif", @"pics/tmp-14.gif", @"pics/tmp-15.gif", @"pics/tmp-16.gif", @"pics/tmp-17.gif", @"pics/tmp-18.gif", @"pics/tmp-19.gif", @"pics/tmp-20.gif", @"pics/tmp-21.gif", @"pics/tmp-22.gif", @"pics/tmp-23.gif", @"pics/tmp-24.gif", @"pics/tmp-25.gif"
                            , @"pics/tmp-26.gif", @"pics/tmp-27.gif", @"pics/tmp-28.gif", @"pics/tmp-29.gif", @"pics/tmp-30.gif", @"pics/tmp-31.gif", @"pics/tmp-32.gif", @"pics/tmp-33.gif", @"pics/tmp-34.gif", @"pics/tmp-35.gif", @"pics/tmp-36.gif", @"pics/tmp-37.gif", @"pics/tmp-38.gif"
                            , @"pics/tmp-39.gif", @"pics/tmp-40.gif", @"pics/tmp-41.gif", @"pics/tmp-42.gif", @"pics/tmp-43.gif", @"pics/tmp-44.gif", @"pics/tmp-45.gif", @"pics/tmp-46.gif", @"pics/tmp-47.gif", @"pics/tmp-48.gif", @"pics/tmp-49.gif", @"pics/tmp-50.gif", @"pics/tmp-51.gif"
                            , @"pics/tmp-52.gif", @"pics/tmp-53.gif", @"pics/tmp-54.gif", @"pics/tmp-55.gif", @"pics/tmp-56.gif", @"pics/tmp-57.gif", @"pics/tmp-58.gif", @"pics/tmp-59.gif", @"pics/tmp-60.gif", @"pics/tmp-61.gif", @"pics/tmp-62.gif", @"pics/tmp-63.gif", @"pics/tmp-64.gif"
                            , @"pics/tmp-65.gif", @"pics/tmp-66.gif", @"pics/tmp-67.gif", @"pics/tmp-68.gif", @"pics/tmp-69.gif", @"pics/tmp-70.gif", @"pics/tmp-71.gif", @"pics/tmp-72.gif", @"pics/tmp-73.gif", @"pics/tmp-74.gif", @"pics/tmp-75.gif", @"pics/tmp-76.gif", @"pics/tmp-77.gif"
                            , @"pics/tmp-78.gif", @"pics/tmp-79.gif", @"pics/tmp-80.gif", @"pics/tmp-81.gif", @"pics/tmp-82.gif", @"pics/tmp-83.gif", @"pics/tmp-84.gif", @"pics/tmp-85.gif", @"pics/tmp-86.gif", @"pics/tmp-87.gif", @"pics/tmp-88.gif", @"pics/tmp-89.gif", @"pics/tmp-90.gif"
                            , @"pics/tmp-91.gif", @"pics/tmp-92.gif", @"pics/tmp-93.gif", @"pics/tmp-94.gif", @"pics/tmp-95.gif", @"pics/tmp-96.gif", @"pics/tmp-97.gif", @"pics/tmp-98.gif", @"pics/tmp-99.gif", @"pics/tmp-100.gif", @"pics/tmp-101.gif", @"pics/tmp-102.gif", @"pics/tmp-103.gif"
                            , @"pics/tmp1-0.gif", @"pics/tmp1-1.gif", @"pics/tmp1-2.gif", @"pics/tmp1-3.gif", @"pics/tmp1-4.gif", @"pics/tmp1-5.gif", @"pics/tmp1-6.gif", @"pics/tmp1-7.gif", @"pics/tmp1-8.gif", @"pics/tmp1-9.gif", @"pics/tmp1-10.gif", @"pics/tmp1-11.gif", @"pics/tmp1-12.gif"
                            , @"pics/tmp1-13.gif", @"pics/tmp1-14.gif", @"pics/tmp1-15.gif", @"pics/tmp1-16.gif", @"pics/tmp1-17.gif", @"pics/tmp1-18.gif", @"pics/tmp1-19.gif", @"pics/tmp1-20.gif", @"pics/tmp1-21.gif", @"pics/tmp1-22.gif", @"pics/tmp1-23.gif", @"pics/tmp1-24.gif", @"pics/tmp1-25.gif"
                            , @"pics/tmp1-26.gif", @"pics/tmp1-27.gif", @"pics/tmp1-28.gif", @"pics/tmp1-29.gif", @"pics/tmp1-30.gif", @"pics/tmp1-31.gif", @"pics/tmp1-32.gif", @"pics/tmp1-33.gif", @"pics/tmp1-34.gif", @"pics/tmp1-35.gif", @"pics/tmp1-36.gif", @"pics/tmp1-37.gif", @"pics/tmp1-38.gif"
                            , @"pics/tmp1-39.gif", @"pics/tmp1-40.gif", @"pics/tmp1-41.gif", @"pics/tmp1-42.gif", @"pics/tmp1-43.gif", @"pics/tmp1-44.gif", @"pics/tmp1-45.gif", @"pics/tmp1-46.gif", @"pics/tmp1-47.gif", @"pics/tmp1-48.gif", @"pics/tmp1-49.gif", @"pics/tmp1-50.gif", @"pics/tmp1-51.gif"
                            , @"pics/tmp1-52.gif", @"pics/tmp1-53.gif", @"pics/tmp1-54.gif", @"pics/tmp1-55.gif", @"pics/tmp1-56.gif", @"pics/tmp1-57.gif", @"pics/tmp1-58.gif", @"pics/tmp1-59.gif", @"pics/tmp1-60.gif", @"pics/tmp1-61.gif", @"pics/tmp1-62.gif", @"pics/tmp1-63.gif", @"pics/tmp1-64.gif"
                            , @"pics/tmp1-65.gif", @"pics/tmp1-66.gif", @"pics/tmp1-67.gif", @"pics/tmp1-68.gif", @"pics/tmp1-69.gif", @"pics/tmp1-70.gif", @"pics/tmp1-71.gif", @"pics/tmp1-72.gif", @"pics/tmp1-73.gif", @"pics/tmp1-74.gif", @"pics/tmp1-75.gif", @"pics/tmp1-76.gif", @"pics/tmp1-77.gif"
                            , @"pics/tmp1-78.gif", @"pics/tmp1-79.gif", @"pics/tmp1-80.gif", @"pics/tmp1-81.gif", @"pics/tmp1-82.gif", @"pics/tmp1-83.gif", @"pics/tmp1-84.gif", @"pics/tmp1-85.gif", @"pics/tmp1-86.gif", @"pics/tmp1-87.gif", @"pics/tmp1-88.gif", @"pics/tmp1-89.gif", @"pics/tmp1-90.gif"
                            , @"pics/tmp1-91.gif", @"pics/tmp1-92.gif", @"pics/tmp1-93.gif", @"pics/tmp1-94.gif", @"pics/tmp1-95.gif", @"pics/tmp1-96.gif", @"pics/tmp1-97.gif", @"pics/tmp1-98.gif", @"pics/tmp1-99.gif"];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageNames.count; i++)
    {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    
    // Normal Animation
    imgView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    imgView.animationImages = images;
    imgView.animationDuration = 10.0;
    
    [self.view insertSubview:imgView belowSubview:viewLoginFB];
    [imgView startAnimating];
    
    //adds FB login button
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    // Optional: Place the button in the center of your view.
    loginButton.frame = CGRectMake(0, 0, 200, 50);
    loginButton.readPermissions =
    @[@"public_profile", @"email"];
    
    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    vc = (UITabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"UITabBarController"];
    
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    
    
    
    [viewLoginFB addSubview:loginButton];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//Adds user information (ID, NAME, EMAIL) into a dictionary
//Dictionary is used as a parameter for a Facebook call in order to retrieve Facebook User Data
//Sets data retrieved into a User object
-(void)viewWillAppear:(BOOL)animated{

    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    
     NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"id,name,email" forKey:@"fields"];
    
    //pull full name and email from FB and set user object's attributes
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                  id result, NSError *error) {

         
         name = result[@"name"];
         email = result[@"email"];
        
         
         user = [User userData];
         [user setName:name];
         [user setEmail:email];
         
     }];
    
     
    
    [self login];
    
}


//If user data doesn't match, doesn't log in.
-(void)login{
    
    if(!user.name){
                
        [self presentViewController:vc animated:YES completion:nil];
    }
}


@end
