//
//  ReviewViewController.h
//  AnP Salon
//
//  Created by alain alberto alzuri on 4/23/16.
//  Copyright © 2016 TeamD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONSerializable.h"

@interface ReviewViewController : UIViewController<UITextViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextView *reviewTxt;
@property (weak, nonatomic) IBOutlet UISlider * slider;
@property (weak, nonatomic) IBOutlet UITextView * txtView;
@property (weak, nonatomic) UIButton *sendBtn;
@property (weak, nonatomic) UIButton *cancelBtn;
@property NSMutableArray *listData;

-(IBAction)SendClicked:(id)sender;
-(IBAction)CancelClicked:(id)sender;

@end
