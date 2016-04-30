//
//  JSONSerializable.h
//  AnP Salon
//
//  Created by alain alberto alzuri on 4/30/16.
//  Copyright © 2016 TeamD. All rights reserved.
//

#ifndef JSONSerializable_h
#define JSONSerializable_h


#endif /* JSONSerializable_h */


#import <Foundation/Foundation.h>

@protocol JSONSerializable <NSObject>

- (void) readFromJSONDictionary:(NSDictionary *) d;

@end