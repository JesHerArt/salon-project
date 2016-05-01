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
    NSMutableArray * arr;
    NSString *str1, *str2, *str3, *str4, *str5;
    
}
@synthesize lbl,tableView, listData, weatherImg;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    arr = [[NSMutableArray alloc] initWithObjects:@"Week of MAY 1st - MAY 7th 2016", nil];
    [self setArrayFromRequest2];
    //NSLog(@"Array after init: %@", arr);
    
    
    //Alain
    user = [User userData];
    //NSLog(@"User name: %@",user.name);
    NSString *welcome = [NSString stringWithFormat:@"Welcome %@ we hope you are having a beautiful day!", user.name];
    lbl.text = welcome;
    
    //Alain post to external DB name and email
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
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            //NSLog(@"JSON Dict user: %@", jsonDict);
    user = [User userData];
    user.uId = jsonDict[@"user_id"];
            //NSLog(@"%@",user.uId);
    }] resume];
    //post user to ext DB
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setArrayFromRequest2{
    
    NSURL * url1 = [NSURL URLWithString:@"http://salonapi.jesherart.design/services/specials"];
    
    NSMutableURLRequest *request1 = [[NSMutableURLRequest alloc] init];
    [request1 setURL:url1];
    [request1 setHTTPMethod:@"GET"];
    [request1 setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request1 setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSession *session1 = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session1 dataTaskWithRequest:request1 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        //NSLog(@"requestRepy string: : %@", requestReply);
        
        jsonSpecialsDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        //NSLog(@"JSON Dict Specials: %@", jsonSpecialsDict);
        //NSLog(@"JSON Dict Specials count: %lu", [[jsonSpecialsDict[@"specials"] allObjects] count]);
        
        self.listData = [jsonSpecialsDict objectForKey:@"specials"];

        
        //NSLog(@"list Data from list data array: %@",self.listData[1][@"name"]);
        
        str1 = [NSString stringWithFormat:@"%@                                            %@", self.listData[0][@"name"], self.listData[0][@"special_price"] ];
        str2 = [NSString stringWithFormat:@"%@                                            %@", self.listData[1][@"name"], self.listData[1][@"special_price"] ];
        str3 = [NSString stringWithFormat:@"%@                                            %@", self.listData[2][@"name"], self.listData[2][@"special_price"] ];
        str4 = [NSString stringWithFormat:@"%@                          %@", self.listData[3][@"name"], self.listData[3][@"special_price"] ];
        str5 = [NSString stringWithFormat:@"%@                             %@", self.listData[4][@"name"], self.listData[4][@"special_price"] ];
        
        
        [arr addObject:str1];
        [arr addObject:str2];
        [arr addObject:str3];
        [arr addObject:str4];
        [arr addObject:str5];
        
        
        [self loadTable];
        
    }] resume];
    
}

- (void) loadTable
{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    
    
    //NSLog(@"inside load table");
}






//TableView Methods***********************************


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"inside number of rows");
    return (NSInteger)arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"inside cell method");
    
    static NSString *SimpleCellIdentifier = @"Cell";
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:
                             SimpleCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleDefault
                 reuseIdentifier:SimpleCellIdentifier];
    }
   
    NSUInteger row = [indexPath row];
    cell.textLabel.text = arr[row];
    
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:24];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //NSLog(@"inside number of sections");
    return 1;
}


@end
