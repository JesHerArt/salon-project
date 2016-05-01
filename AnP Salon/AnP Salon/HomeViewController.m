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
    NSString *str1;
}
@synthesize lbl,tableView, listData;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    arr = [[NSMutableArray alloc] initWithObjects:@"Sleepy", @"Sneezy", @"Bashful", @"Happy", nil];
    
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
    
   
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            //NSLog(@"requestReply1: %@", requestReply);
            
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            //NSLog(@"JSON Dict user: %@", jsonDict);
            
            user = [User userData];
            user.uId = jsonDict[@"user_id"];
            //NSLog(@"%@",user.uId);
            
        }] resume];
    
    
    
    
    NSURL * url1 = [NSURL URLWithString:@"http://salonapi.jesherart.design/services/specials"];
    
    NSMutableURLRequest *request1 = [[NSMutableURLRequest alloc] init];
    [request1 setURL:url1];
    [request1 setHTTPMethod:@"GET"];
    [request1 setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request1 setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    
    NSURLSession *session1 = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session1 dataTaskWithRequest:request1 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        //NSLog(@"requestReply2: %@", requestReply);
        
        jsonSpecialsDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        //NSLog(@"JSON Dict Specials: %@", jsonSpecialsDict);
        //NSLog(@"JSON Dict Specials count: %lu", [[jsonSpecialsDict[@"specials"] allObjects] count]);
        
        self.listData = [jsonSpecialsDict objectForKey:@"specials"];
        
//        for ( NSDictionary *eachEntry in jsonSpecialsDict){
//            NSString *name = [eachEntry objectForKey:@"name"];
//            [self.listData addObject:name];
//            NSLog(@"name: %@", name);
//        }
        
//        for ( id key in jsonSpecialsDict[@"specials"]) {
//            [self.listData addObject:[key objectForKey:@"name"]];
//        }
        
//        NSLog(@"list Data from dict: %lu",self.listData.count);
//        
//        NSLog(@"list Data from dict: %@",self.listData[1][@"name"]);
        str1 = self.listData[1][@"name"];
        NSLog(@"String inside block: %@",str1);
        [arr addObject:@"Jess"];
//        arr = [[NSMutableArray alloc] initWithObjects:str1, nil];
//        arr = [[NSMutableArray alloc] init];
//        [arr addObject:str1];
        
//        NSLog(@"arrString: %@",arr);
        
    
    }] resume];
    NSLog(@"list Data from dict outside: %@",self.listData[1][@"name"]);
    [arr addObject:@"Alain"];
     NSLog(@"String outside block: %@",str1);
    //[arr addObject:str1];
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


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    //return [[jsonSpecialsDict[@"specials"] allObjects] count];
    NSLog(@"inside number of rows");
    return (NSInteger)arr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"inside cell method");
    
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleDefault
                 reuseIdentifier:SimpleTableIdentifier];
    }
   
    NSUInteger row = [indexPath row];
    cell.textLabel.text = arr[row];
    
    
//    cell.textLabel.font = [UIFont boldSystemFontOfSize:50];
    
//    NSDictionary *specialsDictionary = [listData objectAtIndex:indexPath.row];
//    cell.textLabel.text = [specialsDictionary objectForKey:@"name"];

    return cell;
}


//- (NSInteger)tableView:(UITableView *)tableView
//indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"inside indentation level");
//    NSUInteger row = [indexPath row];
//    return row;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"inside number of sections");
    return 1;
}


@end
