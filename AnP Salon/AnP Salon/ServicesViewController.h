//
//  ServicesViewController.h
//  AnP Salon
//
//  
//  Copyright © 2016 TeamD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServicesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate, UINavigationControllerDelegate>
{
    NSMutableArray *listData;
    NSDictionary *jsonServicesDict;
    
}

@property IBOutlet UITableView * tableView;
@property (nonatomic, retain) NSMutableArray *listData;

@end


