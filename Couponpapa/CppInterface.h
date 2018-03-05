//
//  CppInterface.h
//  CppFramework
//
//  Created by RIX on 2018. 3. 3..
//  Copyright © 2018년 Couponpapa. All rights reserved.
//

#ifndef CppInterface_h
#define CppInterface_h

#import <Foundation/Foundation.h>

@interface CppInterface : NSObject
+ (instancetype) sharedInstance;
- (void) setCredentials:(NSString *)apiKey mode:(NSString *)mode version:(NSString *)version;
- (BOOL) isInitialized;

// codes
- (void) codesCheck:(NSString *)code
         trackingId:(NSString *)trackingId
        totalAmount:(int)totalAmount
         completion:(void (^)(NSArray *result))completion
            failure:(void (^)(NSArray *error))failure;

- (void) codesUse:(NSString *)code
       trackingId:(NSString *)trackingId
      totalAmount:(int)totalAmount
          orderId:(NSString *)orderId
       parameters:(NSDictionary *)parameters
       completion:(void (^)(NSArray *result))completion
          failure:(void (^)(NSArray *error))failure;

- (void) codesCancel:(NSString *)orderId
          completion:(void (^)(NSArray *result))completion
             failure:(void (^)(NSArray *error))failure;

- (void) codesFire:(NSString *)tag
         recipient:(NSString *)recipient
        completion:(void (^)(NSArray *result))completion
           failure:(void (^)(NSArray *error))failure;

// coupons
- (void) couponsList:(NSString *)trackingId
          completion:(void (^)(NSArray *result))completion
             failure:(void (^)(NSArray *error))failure;

// couponboxes
- (void) couponboxesList:(NSString *)trackingId
             totalAmount:(int)totalAmount
              completion:(void (^)(NSArray *result))completion
                 failure:(void (^)(NSArray *error))failure;

// analytics
- (void) analyticsRepurchase:(NSString *)trackingId
                 totalAmount:(int)totalAmount
                  completion:(void (^)(NSArray *result))completion
                     failure:(void (^)(NSArray *error))failure;

@end

#endif /* CppInterface_h */
