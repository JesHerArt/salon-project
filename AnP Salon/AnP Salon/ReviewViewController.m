//
//  ReviewViewController.m
//  AnP Salon
//
//  Created by alain alberto alzuri on 4/23/16.
//  Copyright © 2016 TeamD. All rights reserved.
//

#import "ReviewViewController.h"
#import "User.h"
#import "JSONSerializable.h"

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
    user.rating = [NSNumber numberWithFloat:slider.value];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *vc = (UITabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"UITabBarController"];
    [vc setSelectedIndex:3];
    
    //test ID
    //user.uId = [NSNumber numberWithInt:9];

    
    NSDictionary *dict = @{@"user_id" : user.uId ,
                           @"comment" : user.review ,
                           @"rating"  : user.rating};
                           
    
//    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
//    
    
//    
    
    //NSData * strData = [reviewDataStr dataUsingEncoding:NSUTF8StringEncoding];
    //NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:[reviewDataStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
    //NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:strData options:0 error:NULL];

    NSData * jsonR = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    
    NSLog(@"%@", dict);
    NSLog(@"%@", jsonR);
    
    NSURL * url = [NSURL URLWithString:@"http://salonapi.jesherart.design/salon/review"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonR];
    
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
//        NSLog(@"requestReply: %@", requestReply);
//    }] resume];
//    
    [self presentViewController:vc animated:YES completion:nil];
}



@end
