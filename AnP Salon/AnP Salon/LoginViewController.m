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

@synthesize name, email;

- (void)viewDidLoad {
    [super viewDidLoad];
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    // Optional: Place the button in the center of your view.
    loginButton.frame = CGRectMake(20, 0, 200, 50);
    loginButton.readPermissions =
    @[@"public_profile", @"email"];
    
    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    vc = (UITabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"UITabBarController"];
    
    [viewLoginFB addSubview:loginButton];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    
     NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"id,name,email" forKey:@"fields"];
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                  id result, NSError *error) {
         //         aHandler(result, error);
         NSLog(@"%@", result);
         name = result[@"name"];
         email = result[@"email"];
         NSLog(@"name: %@", name);
         NSLog(@"email: %@", email);
         
         user = [User userData];
         
         [user setName:name];
         [user setEmail:email];
         
     }];
    
    [self login];
    
}

-(void)login{
    if(!user.name){
        [self presentViewController:vc animated:YES completion:nil];
    }
    
}

-(IBAction)LoginClicked:(id)sender{
    
//    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
//    
////    if(FBSDKAccessToken.currentAccessToken != nil) {
////        NSLog((@"%@", FBSDKAccessToken.currentAccessToken.userID)); //works
////    }
//    
//    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
//    [parameters setValue:@"id,name,email" forKey:@"fields"];
//    
//    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
//     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
//                                  id result, NSError *error) {
////         aHandler(result, error);
//         NSLog(@"%@", result);
//         name = result[@"name"];
//         email = result[@"email"];
//         NSLog(@"name: %@", name);
//         NSLog(@"email: %@", email);
//         
//          user = [User userData];
//        
//         [user setName:name];
//         [user setEmail:email];
//         [self presentViewController:vc animated:YES completion:nil];
//         
//     }];
    
    
}


@end
