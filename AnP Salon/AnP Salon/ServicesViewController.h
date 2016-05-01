//
//  ServicesViewController.h
//  AnP Salon
//
//  
//  Copyright © 2016 TeamD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServicesViewController : UIViewController


@property (weak, nonatomic) UIButton *hairBtn;
@property (weak, nonatomic) UIButton *nailsBtn;

-(IBAction)HairClicked:(id)sender;
-(IBAction)NailsClicked:(id)sender;

@end


