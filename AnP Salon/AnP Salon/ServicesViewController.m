//
//  ServicesViewController.m
//  AnP Salon
//
//  
//  Copyright © 2016 TeamD. All rights reserved.
//

#import "ServicesViewController.h"

@interface ServicesViewController ()

@end

@implementation ServicesViewController
@synthesize tableView,listData;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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





//TableView Methods***********************************


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    NSLog(@"inside number of rows");
    return (NSInteger)arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"inside cell method");
    
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
    
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:35];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"inside number of sections");
    return 1;
}

@end
