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
    NSMutableArray * weatherData;
    NSDictionary *jsonSpecialsDict;
    UITextView *txtView;
    UIWebView *webView;
}


@property IBOutlet UILabel *lbl;
@property IBOutlet UIWebView *webView;
@property IBOutlet UITextView * txtView;
@property IBOutlet UITableView * tableView;
@property (nonatomic, retain) NSMutableArray *listData;
@property (nonatomic, retain) NSMutableArray *weatherData;


@end
