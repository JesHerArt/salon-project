//
//  HomeViewController.m
//  AnP Salon
//
//  
//  Copyright © 2016 TeamD. All rights reserved.
//

#import "HomeViewController.h"
#import "User.h"
#import "AppDelegate.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
{
    User *user;
    NSMutableArray * arr;
    NSString *str1, *str2, *str3, *str4, *str5;
    NSString *weatherStr, *icon;
    
}
@synthesize lbl,tableView, listData, webView, weatherData, txtView, appointmentsArray;

//When view loads, it displays a welcome message to the user (Knows who the user is from the Facebook Login)
//Fetches CoreData appointment objects and adds them to the Home View under the welcome message
//Posts user data into external database
- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    arr = [[NSMutableArray alloc] initWithObjects:@"Week of MAY 1st - MAY 7th 2016", nil];
    [self setArrayFromRequest2];

    //loads welcome string with user's name
    user = [User userData];
    NSString *welcome = [NSString stringWithFormat:@"Welcome %@, we hope you are having a beautiful day!\r", user.name];
    lbl.text = welcome;
    
    //CoreData read for appointments
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext* context = [appDelegate managedObjectContext];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"Appointments" inManagedObjectContext: context];
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Appointments"];
    [fetchRequest setEntity:entity];
    
    NSArray* fetchedObjects = [context executeFetchRequest:fetchRequest error: nil];
    appointmentsArray = [[NSMutableArray alloc]init];
    
    if (fetchedObjects.count > 0 ) {
        
        for(int j = 0;j < fetchedObjects.count;j++){
            NSManagedObject *mo = [fetchedObjects objectAtIndex:j];  // assuming that array is not empty
            id value = [mo valueForKey:@"appts"];
            [appointmentsArray addObject:value];
        }
        
        for(int x=0;x<appointmentsArray.count;x++){
            lbl.text = [lbl.text stringByAppendingString:[NSString stringWithFormat:@"\r%@",appointmentsArray[x]]];
        }
        
    }
    
    //Post to external DB name and email
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
    }] resume];
    
    //get weather from api
    [self getWeather];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//pull from external DB .... Weekly Specials

-(void)setArrayFromRequest2{
    
    NSURL * url1 = [NSURL URLWithString:@"http://salonapi.jesherart.design/services/specials"];
    
    NSMutableURLRequest *request1 = [[NSMutableURLRequest alloc] init];
    [request1 setURL:url1];
    [request1 setHTTPMethod:@"GET"];
    [request1 setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request1 setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSession *session1 = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session1 dataTaskWithRequest:request1 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        jsonSpecialsDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        self.listData = [jsonSpecialsDict objectForKey:@"specials"];
        
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

//reload tableview from main thread

- (void) loadTable
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });

}


//weather api call
-(void)getWeather{
    
    NSURL * url = [NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/weather?q=33174&appid=6654780bba568f4c9e3543dead58391e"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        self.weatherData = [jsonDict objectForKey:@"weather"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            weatherStr = [NSString stringWithFormat:@"Current Weather near AnP Salon: \r%@  \rDescription: \r%@", self.weatherData[0][@"main"], self.weatherData[0][@"description"] ];
            icon = [NSString stringWithFormat:@"%@",self.weatherData[0][@"icon"]];
            self.txtView.text = weatherStr;
            NSString *iconStr = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png",icon];
            NSURL * url2 = [NSURL URLWithString:iconStr];
            NSURLRequest *request2 = [NSURLRequest requestWithURL:url2];
            [webView loadRequest:request2];

            
        });
    }] resume];
    
}



//TableView Methods**********************************
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return (NSInteger)arr.count;
}



- (UITableViewCell *)tableView:(UITableView *)aTableView
   cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
    return 1;
}


@end
