//
//  User.h
//  AnP Salon
//
//  Created by alain alberto alzuri on 4/29/16.
//  Copyright © 2016 TeamD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface User : NSObject

@property NSNumber * uId;
@property NSString *name;
@property NSString *email;
@property NSString *imgStr;
@property NSString *review;
@property NSNumber *rating;
@property NSMutableArray * appointments;


+(instancetype)userData;


@end
