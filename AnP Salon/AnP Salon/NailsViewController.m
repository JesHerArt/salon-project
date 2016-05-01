//
//  NailsViewController.m
//  AnP Salon
//
//  Created by alain alberto alzuri on 5/1/16.
//  Copyright © 2016 TeamD. All rights reserved.
//

#import "NailsViewController.h"
#import "AppDelegate.h"

@implementation NailsViewController
@synthesize colorsArray;


- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext* context = [appDelegate managedObjectContext];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"Colors" inManagedObjectContext: context];
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Colors"];
    [request setEntity:entity];
    NSArray* fetchedObjects = [context executeFetchRequest:request error: nil];
    NSString* colorStr = fetchedObjects[0];
    
    
    
    NSLog(@"colors: %@",colorStr);
    
    
    
    
    
    
    //NSLog(@"color 1: %@",mySmallerString);
    
//colors: <NSManagedObject: 0x145510b60>
//    (entity: Colors;
//     id: 0xd0000000039c0000
//     <x-coredata://5119F945-0107-4203-B544-C33F1E37273F/Colors/p231> ;
//     data: {
//        nailColor = yellow;
//            }
//     
//     )
    
        
}




-(IBAction)BackClicked:(id)sender{
    
    //goes back to services controller
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *vc = (UITabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"UITabBarController"];
    [vc setSelectedIndex:1];
    
    [self presentViewController:vc animated:YES completion:nil];}

@end
