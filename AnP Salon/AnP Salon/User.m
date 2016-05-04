//
//  User.m
//  AnP Salon
//
//  Created by alain alberto alzuri on 4/29/16.
//  Copyright © 2016 TeamD. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize name,email,imgStr,review, rating, appointments,uId;

//singleton USER


+(instancetype)userData{
    static User * userData = nil;
    if(!userData){
        userData = [[User alloc]init];
        userData.appointments = [[NSMutableArray alloc]init];
    }
    return userData;
    
}

-(instancetype)init{
    self = [super init];
    
    return self;
    
}




@end
