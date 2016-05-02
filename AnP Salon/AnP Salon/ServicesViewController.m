//
//  ServicesViewController.m
//  AnP Salon
//
//  
//  Copyright © 2016 TeamD. All rights reserved.
//

#import "ServicesViewController.h"
#import "HairViewController.h"
#import "NailsViewController.h"

@interface ServicesViewController ()

@end

@implementation ServicesViewController


- (void)viewDidLoad {
   /*
    self.title = @"Services";
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    // Hair Button
    HairViewController *hairButtonController =
    [[HairViewController alloc] initWithStyle:UITableViewStylePlain];
    hairButtonController.title = @"Hair";
    [array addObject:hairButtonController];
    
    // Nail Button
    NailsViewController *nailsButtonController =
    [[NailsViewController alloc] initWithStyle:UITableViewStylePlain];
    nailsButtonController.title = @"Nails";
    [array addObject:nailsButtonController];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.controllers = array;
    */
    
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)HairClicked:(id)sender{
    
    //goes to hair controller
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"HairViewController"];
    [self presentViewController:viewController animated:YES completion:nil];
    
}

-(IBAction)NailsClicked:(id)sender{
    
    //goes to nails controller
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"NailsViewController"];
    [self presentViewController:viewController animated:YES completion:nil];
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

/*
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"inside number of rows");
    NSLog(@"Number of controllers/table items: %lu", [self.controllers count]);
    return [self.controllers count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *FirstLevelCell= @"FirstLevelCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FirstLevelCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:FirstLevelCell];
    }

    // Configure the cell
    NSUInteger row = [indexPath row];
    SecondViewController *controller = [controllers objectAtIndex:row];
    cell.textLabel.text = controller.title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"inside number of sections");
    return 1;
}
 */

@end
