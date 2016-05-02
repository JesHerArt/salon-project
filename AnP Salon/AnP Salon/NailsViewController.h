//
//  NailsViewController.h
//  AnP Salon
//
//  Created by alain alberto alzuri on 5/1/16.
//  Copyright © 2016 TeamD. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NailsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) UIButton *backBtn;
@property NSMutableArray * colorsArray;
@property IBOutlet UITableView * tableView;
@property IBOutlet UISearchBar * searchBar;


-(IBAction)BackClicked:(id)sender;

@end
