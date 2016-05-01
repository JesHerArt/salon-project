//
//  NailsViewController.h
//  AnP Salon
//
//  Created by alain alberto alzuri on 5/1/16.
//  Copyright © 2016 TeamD. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NailsViewController : UIViewController

@property (weak, nonatomic) UIButton *backBtn;
@property (weak, nonatomic) NSMutableArray * colorsArray;

-(IBAction)BackClicked:(id)sender;

@end
