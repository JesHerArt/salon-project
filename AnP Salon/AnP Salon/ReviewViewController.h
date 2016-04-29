//
//  ReviewViewController.h
//  AnP Salon
//
//  Created by alain alberto alzuri on 4/23/16.
//  Copyright © 2016 TeamD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *reviewTxt;
@property (weak, nonatomic) IBOutlet UISlider * slider;
@property (weak, nonatomic) UIButton *sendBtn;
@property (weak, nonatomic) UIButton *cancelBtn;

-(IBAction)SendClicked:(id)sender;
-(IBAction)CancelClicked:(id)sender;

@end
