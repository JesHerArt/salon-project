//
//  HomeViewController.h
//  AnP Salon
//
//  
//  Copyright © 2016 TeamD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *listData;
    NSDictionary *jsonSpecialsDict;
}


@property IBOutlet UILabel *lbl;
@property IBOutlet UITableView * tableView;
@property (nonatomic, retain) NSArray *listData;

@end
