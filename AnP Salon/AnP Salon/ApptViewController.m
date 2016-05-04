//
//  ApptViewController.m
//  AnP Salon
//
//  
//  Copyright © 2016 TeamD. All rights reserved.
//

#import "ApptViewController.h"
#import "User.h"
#import "AppDelegate.h"

@interface ApptViewController ()

@end

@implementation ApptViewController
{
    NSString * appType;
    User *user;
}

@synthesize appSwitch,datePicker;


- (void)viewDidLoad {
    [super viewDidLoad];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    
    
    // check if selector available
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    // display error message here
                    //would add to final product
                }
                else if (!granted)
                {
                    // display access denied error message here
                    //would add to final product

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
    
    //add appointent to user object
    user = [User userData];
    NSString * str1 = [NSString stringWithFormat:@"%@",selected];
    NSString *str2 = [str1 substringToIndex:10];
    NSString * appointmentInfo = [NSString stringWithFormat:@"You have a %@ on: %@",appType, str2];
    [user.appointments addObject:appointmentInfo];
    
    
    //adding the appointment to core data
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = [appDelegate managedObjectContext];
    //NSEntityDescription* entity = [NSEntityDescription entityForName:@"Appointments" inManagedObjectContext: context];
    //NSManagedObject* Appointments = [NSEntityDescription insertNewObjectForEntityForName:@"Appointments"inManagedObjectContext:context];
    NSArray *appts = [[NSArray alloc] initWithObjects:appointmentInfo, nil];
    
    
    
    for (int i = 0 ; i < appts.count ; i++)
    {
        NSManagedObject *tagsDB = [NSEntityDescription insertNewObjectForEntityForName:@"Appointments" inManagedObjectContext:context];
        [tagsDB setValue:appts[i] forKey:@"appts"];
        
        
    }
    
    [appDelegate saveContext];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController*vc = (UITabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"UITabBarController"];
    [vc setSelectedIndex:0];
    [self presentViewController:vc animated:YES completion:nil];
    
}


@end
