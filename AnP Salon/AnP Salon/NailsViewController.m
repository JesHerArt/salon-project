//
//  NailsViewController.m
//  AnP Salon
//
//  Created by alain alberto alzuri on 5/1/16.
//  Copyright © 2016 TeamD. All rights reserved.
//

#import "NailsViewController.h"
#import "AppDelegate.h"

@implementation NailsViewController{
    NSMutableArray * searchColors;
}
@synthesize colorsArray, tableView, searchBar;


- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    searchBar.delegate = self;
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext* context = [appDelegate managedObjectContext];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"Colors" inManagedObjectContext: context];
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Colors"];
    [request setEntity:entity];
    

    
    NSArray* fetchedObjects = [context executeFetchRequest:request error: nil];
    colorsArray = [[NSMutableArray alloc]init];
    
    for(int j = 0;j < fetchedObjects.count;j++){
    NSManagedObject *mo = [fetchedObjects objectAtIndex:j];  // assuming that array is not empty
        id value = [mo valueForKey:@"nailColor"];
        [colorsArray addObject:value];
       // textView.text = [textView.text stringByAppendingString:value];
       // textView.text = [textView.text stringByAppendingString:@"\r\r"];
    }
    
    
    searchColors = [[NSMutableArray alloc]initWithArray:colorsArray];
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if([searchText length]== 0){
        [searchColors removeAllObjects];
        [searchColors addObjectsFromArray:colorsArray];
        
    }else{
        [searchColors removeAllObjects];
        for(NSString * string in colorsArray){
            NSRange r = [string rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(r.location != NSNotFound){
                [searchColors addObject:string];
            }
        }
    }
    [tableView reloadData];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [searchBar resignFirstResponder];

}

-(void)searchBarSearchButtonClicked:(UISearchBar *)aSearchBar{
    [searchBar resignFirstResponder];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [searchBar resignFirstResponder];
}

-(IBAction)BackClicked:(id)sender{
    
    //goes back to services controller
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *vc = (UITabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"UITabBarController"];
    [vc setSelectedIndex:1];
    
    [self presentViewController:vc animated:YES completion:nil];}


//tableView methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return (NSInteger)searchColors.count;
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
    cell.textLabel.text = searchColors[row];
    
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:24];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //NSLog(@"inside number of sections");
    return 1;
}


@end
