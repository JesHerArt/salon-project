//
//  HairViewController.m
//  AnP Salon
//
//  Created by alain alberto alzuri on 5/1/16.
//  Copyright © 2016 TeamD. All rights reserved.
//

#import "HairViewController.h"

@implementation HairViewController
@synthesize nameView, listData, priceView;


- (void) viewDidLoad {
    
    
    [super viewDidLoad];
    
    NSURL * url = [NSURL URLWithString:@"http://salonapi.jesherart.design/services/hairstyles"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        self.listData = [jsonDict objectForKey:@"hairstyles"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            for(int x=0; x<listData.count; x++){
                NSString *newName = [NSString stringWithFormat:@"%@ \r\r", self.listData[x][@"name"] ];
                NSString *newPrice = [NSString stringWithFormat:@"%@ \r\r", self.listData[x][@"price"] ];
                
                nameView.text = [nameView.text stringByAppendingString: newName ];
                priceView.text = [priceView.text stringByAppendingString: newPrice ];
                
            }
        });
    }] resume];
    
}


-(IBAction)BackClicked:(id)sender{
    
    //goes back to services controller
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *vc = (UITabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"UITabBarController"];
    [vc setSelectedIndex:1];
    
    [self presentViewController:vc animated:YES completion:nil];
}

@end