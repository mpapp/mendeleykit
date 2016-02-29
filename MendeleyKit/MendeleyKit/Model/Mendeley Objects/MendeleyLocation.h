//
//  MendeleyLocation.h
//  version 2 of the API!
//  MendeleyKit
//
//  Created by Schmidt, Peter (ELS) on 29/02/2016.
//  Copyright © 2016 Mendeley. All rights reserved.
//

#import "MendeleyObject.h"
#warning API v2 model
@interface MendeleyLocation : MendeleySecureObject
@property (nonatomic, strong, nullable) NSString *object_ID;
@property (nonatomic, strong, nullable) NSString *city;
@property (nonatomic, strong, nullable) NSString *state;
@property (nonatomic, strong, nullable) NSString *country;
@property (nonatomic, strong, nullable) NSNumber *latitude;
@property (nonatomic, strong, nullable) NSNumber *longitude;
@end
