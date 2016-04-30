//
//  HomeViewController.m
//  AnP Salon
//
//  
//  Copyright © 2016 TeamD. All rights reserved.
//

#import "HomeViewController.h"
#import "User.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
{
    User *user;
}
@synthesize lbl;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    //Alain
    user = [User userData];
    NSLog(@"User name: %@",user.name);
    NSString *welcome = [NSString stringWithFormat:@"Welcome %@ we hope you are having a beautiful day!", user.name];
    lbl.text = welcome;
    
    
    NSDictionary *dict = @{@"name" : user.name ,
                           @"email" : user.email };
    
    NSData * jsonU = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    
    
    NSURL * url = [NSURL URLWithString:@"http://salonapi.jesherart.design/users/user"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonU];
    
//    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//    [connection start];
//    
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            NSLog(@"requestReply: %@", requestReply);
            
            
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSLog(@"JSON Dict: %@", jsonDict);
                                     
                                     
            
            user = [User userData];
            user.uId = jsonDict[@"user_id"];
            NSLog(@"%@",user.uId);
            
        }] resume];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
