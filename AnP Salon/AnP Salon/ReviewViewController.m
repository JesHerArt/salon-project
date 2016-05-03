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

@synthesize reviewTxt,cancelBtn,sendBtn, slider, txtView, listData;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL * url = [NSURL URLWithString:@"http://salonapi.jesherart.design/salon/reviews"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
       
        self.listData = [jsonDict objectForKey:@"reviews"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            for(int x=0; x<listData.count; x++){
                NSString *newComment = [NSString stringWithFormat:@"%@  \rRating: %@ / 5 \rComment: %@\r\r", self.listData[x][@"date"], self.listData[x][@"rating"], self.listData[x][@"comment"] ];
                txtView.text = [txtView.text stringByAppendingString: newComment ];
            }
        });
    }] resume];
    
}



-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}



- (BOOL)textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
    }
    return YES;
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [reviewTxt resignFirstResponder];
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
                           
    NSData * jsonR = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    
    NSURL * url = [NSURL URLWithString:@"http://salonapi.jesherart.design/salon/review"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonR];
    
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
    }] resume];
    
//    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//    [connection start];
    
    [self presentViewController:vc animated:YES completion:nil];
}



@end
