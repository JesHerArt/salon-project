//
//  ApptViewController.h
//  AnP Salon
//
//  
//  Copyright © 2016 TeamD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>



@interface ApptViewController : UIViewController
{
    UISwitch *appSwitch;
    UIDatePicker *datePicker;
}

@property IBOutlet UISwitch *appSwitch;
@property IBOutlet UIDatePicker *datePicker;


-(IBAction)makeApptClicked:(id)sender;

@end
