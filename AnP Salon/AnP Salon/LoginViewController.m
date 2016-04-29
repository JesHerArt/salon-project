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

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize name, email;

- (void)viewDidLoad {
    [super viewDidLoad];
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    // Optional: Place the button in the center of your view.
    loginButton.frame = CGRectMake(20, 0, 200, 50);
    loginButton.readPermissions =
    @[@"public_profile", @"email"];
    
    [viewLoginFB addSubview:loginButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)LoginClicked:(id)sender{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *vc = (UITabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"UITabBarController"];
    
    
    
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    
//    if(FBSDKAccessToken.currentAccessToken != nil) {
//        NSLog((@"%@", FBSDKAccessToken.currentAccessToken.userID)); //works
//    }
    
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
     }];
    
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)loginButtonClicked
{
//    FBSDKProfile *profile = [[FBSDKProfile alloc] init];
//    
//    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
