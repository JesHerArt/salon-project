//
//  ApptViewController.m
//  AnP Salon
//
//  
//  Copyright © 2016 TeamD. All rights reserved.
//

#import "ApptViewController.h"
#import "User.h"

@interface ApptViewController ()

@end

@implementation ApptViewController
{
    NSString * appType;
}

@synthesize appSwitch,datePicker;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)makeApptClicked:(id)sender{
    
   
    NSDate * selected = [datePicker date];
    NSString * hair = @"Hair Appointment";
    NSString * nail = @"Nail Appointment";
    
    
    if(appSwitch.isOn){
        
        appType = nail;
    }else{
        appType = hair;
    }
    
    
    //add appt event to calendar
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        // the selector is available, so we must be on iOS 6 or newer
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    // display error message here
                }
                else if (!granted)
                {
                    // display access denied error message here
                }
                else
                {
                    // access granted
                    NSLog(@"adding event");
                    EKEvent *myEvent = [EKEvent eventWithEventStore:eventStore];
                    myEvent.title = [NSString stringWithFormat:@"%@ at AnP Salon", appType];
                    myEvent.startDate = selected;
                    myEvent.endDate = [myEvent.startDate dateByAddingTimeInterval:60*60];
                    myEvent.allDay = NO;
                    [myEvent setCalendar:[eventStore defaultCalendarForNewEvents]];
                    [eventStore saveEvent:myEvent span:EKSpanThisEvent commit:TRUE error:NULL];
                    
                }
            });
        }];
    }
    
    User *user = [User userData];
    NSString * str1 = [NSString stringWithFormat:@"%@",selected];
    NSString *str2 = [str1 substringToIndex:10];
    NSString * appointmentInfo = [NSString stringWithFormat:@"You have a %@ on: %@",appType, str2];
    [user.appointments addObject:appointmentInfo];
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController*vc = (UITabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"UITabBarController"];
    [vc setSelectedIndex:0];
    [self presentViewController:vc animated:YES completion:nil];
    
}




@end
