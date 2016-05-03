//
//  HairViewController.h
//  AnP Salon
//
//  Created by alain alberto alzuri on 5/1/16.
//  Copyright © 2016 TeamD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HairViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView * nameView;
@property (weak, nonatomic) IBOutlet UITextView * priceView;
@property NSMutableArray *listData;
@property (weak, nonatomic) UIButton *backBtn;

-(IBAction)BackClicked:(id)sender;

@end