//
//  AppDelegate.m
//  AnP Salon
//
//  Created by Alain Alzuri on 4/1/16.
//  Copyright © 2016 TeamD. All rights reserved.
//

#import "AppDelegate.h"



@import GoogleMaps;

@interface AppDelegate ()

@end

@implementation AppDelegate
{
    User *user;
    UITabBarController *vc;
    UIStoryboard *storyboard;
}

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

//When Application finishes launching, it will create an array of nail colors, and add them to CoreData
//Activates Facebook framework
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    //laoding colors for coredata
    
    NSManagedObjectContext* context = [self managedObjectContext];
    NSManagedObject* Colors = [NSEntityDescription insertNewObjectForEntityForName:@"Colors"inManagedObjectContext:context];
    NSArray *colors = [[NSArray alloc] initWithObjects:@"Red", @"Yellow",@"Blue", @"Black", @"Fuscia", @"Pink",@"Green", @"Clear",@"White", @"Purple",@"Cyan", @"Magenta",@"Grey",
                       @"Orange",@"Violet", @"Amber", @"Beige", @"Brick Red",@"Canary",@"Cafe",@"Chestnut",@"Cobalt",@"Ebony",@"EggPlant",@"Emerald",@"Flirt", @"Blueberry",@"Sonic Blue", @"Kirby Pink", @"Pikachu Yellow", @"Charmander Orange",@"Squirtle Aqua", @"Ginger",@"Panda", @"French Fuzz",@"Iris", nil];
    
    
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Colors"];
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    NSError *deleteError = nil;
    [self.persistentStoreCoordinator executeRequest:delete withContext:context error:&deleteError];
    
    
    for (int i = 0 ; i < colors.count ; i++)
    {
        NSManagedObject *tagsDB = [NSEntityDescription insertNewObjectForEntityForName:@"Colors" inManagedObjectContext:context];
        [tagsDB setValue:colors[i] forKey:@"nailColor"];
        
    }
    
    [self saveContext];
    
    NSError* error;
    if(![context save:&error]) {
        NSLog(@"Save Failed");
    }
    [context deleteObject:Colors];
    
    [request setReturnsObjectsAsFaults:NO];
    
    // Google API Key
    [GMSServices provideAPIKey:@"AIzaSyDPEBON9xkaQWrrI8TT2PTgdXEKmFwMBJE"];
    return YES;
}



- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //fb preperation
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation
                    ];
    // Add any custom logic here.
    return handled;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    //entry point for FB login..move to TABBAR upon login in
    [FBSDKAppEvents activateApp];
    user = [User userData];
    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    vc = (UITabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"UITabBarController"];
    
    if(user.name){
#define ROOTVIEW [[[UIApplication sharedApplication] keyWindow] rootViewController]
        [ROOTVIEW presentViewController:vc animated:YES completion:nil];
        //NSLog(@"inside the if statement");
        
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    
    
}


//**************************************************************
//CoreData methods
//**************************************************************


- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Color" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"AnP Salon.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
