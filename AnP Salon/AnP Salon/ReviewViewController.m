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
    //NSString* formattedNumber = [NSString stringWithFormat:@"%.01f", slider.value];
    //user.rating = (int)formattedNumber;
    user.rating = (int)slider.value;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *vc = (UITabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"UITabBarController"];
    [vc setSelectedIndex:3];
    
    //test id
    user.uId = 9;
    
    NSString *reviewDataStr = [NSString stringWithFormat:@"[{ \"user_id\":%i\,\"comment\":\"%@\" ,\"rating\":%i}]", user.uId, user.review, user.rating];
    
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:@"http://salonapi.jesherart.design/users/user"];
    
    NSData * strData = [reviewDataStr dataUsingEncoding:NSUTF8StringEncoding];
    //NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:[reviewDataStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
    NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:strData options:0 error:NULL];

    NSLog(@"%@", reviewDataStr);
    NSLog(@"%@", jsonObject);
    
    
//    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
//    [urlRequest setHTTPMethod:@"POST"];
//    [urlRequest setHTTPBody:[reviewDataString dataUsingEncoding:NSUTF8StringEncoding]];
//    
    
    
    
    
    
    
    [self presentViewController:vc animated:YES completion:nil];
}



@end
