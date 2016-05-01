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
    NSMutableArray *listData;
    NSDictionary *jsonSpecialsDict;
}


@property IBOutlet UILabel *lbl;
@property IBOutlet UITableView * tableView;
@property (nonatomic, retain) NSMutableArray *listData;

@end
