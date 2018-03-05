//
//  CppInterface.m
//  CppFramework
//
//  Created by RIX on 2018. 3. 3..
//  Copyright © 2018년 Couponpapa. All rights reserved.
//

#import "CppInterface.h"
@import AFNetworking;

// The class extension.
@interface CppInterface()

@property(nonatomic) BOOL isInitialized;
@property(nonatomic, strong) NSString *apiKey;
@property(nonatomic, strong) NSString *host;

+ (AFHTTPSessionManager *) makeRequest:(NSString *)apiKey;
+ (NSArray *) parseError:(NSError *)error;

@end

// The standard implementation.
@implementation CppInterface

@synthesize isInitialized;
@synthesize apiKey;
@synthesize host;

- (void) dealloc {
    self.apiKey = nil;
    self.host = nil;
}

- (instancetype) init {
    if (self = [super init]) {
        self.isInitialized = YES;
    }
    return self;
}

+ (id) sharedInstance {
    static CppInterface * _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

+ (AFHTTPSessionManager *) makeRequest:(NSString *)apiKey {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager.requestSerializer setValue:apiKey forHTTPHeaderField:@"X-Access-Token"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    return manager;
}

+ (NSArray *) parseError:(NSError *)error {
    NSString* ErrorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
    NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:[ErrorResponse dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
    return [jsonObject valueForKey:@"error"];
}

- (void) setCredentials:(NSString *)apiKey mode:(NSString *)mode version:(NSString *)version {
    self.apiKey = apiKey;
    self.host = [NSString stringWithFormat:@"https://%@.couponpapa.io/api/%@", mode, version];
}

- (void) codesCheck:(NSString *)code
         trackingId:(NSString *)trackingId
        totalAmount:(int)totalAmount
         completion:(void (^)(NSArray *result))completion
            failure:(void (^)(NSArray *error))failure {
    
    AFHTTPSessionManager *manager = [CppInterface makeRequest:self.apiKey];
    [manager GET:[NSString stringWithFormat:@"%@/codes/%@/check", self.host, code]
      parameters:@{@"trackingId":trackingId,
                   @"totalAmount":[NSNumber numberWithInt:totalAmount]}
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             if (completion) {
                 completion((NSArray*)responseObject);
             }
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             if (failure) {
                 failure([CppInterface parseError:error]);
             }
         }];
}

- (void) codesUse:(NSString *)code
       trackingId:(NSString *)trackingId
      totalAmount:(int)totalAmount
          orderId:(NSString *)orderId
       parameters:(NSDictionary *)parameters
       completion:(void (^)(NSArray *result))completion
          failure:(void (^)(NSArray *error))failure {
    
    AFHTTPSessionManager *manager = [CppInterface makeRequest:self.apiKey];

    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:trackingId forKey:@"trackingId"];
    [data setObject:[NSNumber numberWithInt:totalAmount] forKey:@"totalAmount"];
    
    if (orderId) {
        [data setObject:orderId forKey:@"orderId"];
    }

    if (parameters) {
        [data setObject:parameters forKey:@"parameters"];
    }

    [manager POST:[NSString stringWithFormat:@"%@/codes/%@/use", self.host, code]
       parameters:data
         progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
              if (completion) {
                  completion((NSArray*)responseObject);
              }
          } failure:^(NSURLSessionTask *operation, NSError *error) {
              if (failure) {
                  failure([CppInterface parseError:error]);
              }
          }];
}

- (void) codesCancel:(NSString *)orderId
          completion:(void (^)(NSArray *result))completion
             failure:(void (^)(NSArray *error))failure {
    
    AFHTTPSessionManager *manager = [CppInterface makeRequest:self.apiKey];
    [manager POST:[NSString stringWithFormat:@"%@/codes/cancel", self.host]
      parameters:@{@"orderId":orderId}
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             if (completion) {
                 completion((NSArray*)responseObject);
             }
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             if (failure) {
                 failure([CppInterface parseError:error]);
             }
         }];
}

- (void) codesFire:(NSString *)tag
         recipient:(NSString *)recipient
        completion:(void (^)(NSArray *result))completion
           failure:(void (^)(NSArray *error))failure {
    
    AFHTTPSessionManager *manager = [CppInterface makeRequest:self.apiKey];
    [manager POST:[NSString stringWithFormat:@"%@/codes/fire", self.host]
       parameters:@{@"tag":tag,
                    @"recipient":recipient}
         progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
              if (completion) {
                  completion((NSArray*)responseObject);
              }
          } failure:^(NSURLSessionTask *operation, NSError *error) {
              if (failure) {
                  failure([CppInterface parseError:error]);
              }
          }];
}

- (void) couponsList:(NSString *)trackingId
          completion:(void (^)(NSArray *result))completion
             failure:(void (^)(NSArray *error))failure {
    
    AFHTTPSessionManager *manager = [CppInterface makeRequest:self.apiKey];
    [manager GET:[NSString stringWithFormat:@"%@/coupons/list", self.host]
      parameters:@{@"trackingId":trackingId}
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             if (completion) {
                 completion((NSArray*)responseObject);
             }
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             if (failure) {
                 failure([CppInterface parseError:error]);
             }
         }];
}

- (void) couponboxesList:(NSString *)trackingId
             totalAmount:(int)totalAmount
              completion:(void (^)(NSArray *result))completion
                 failure:(void (^)(NSArray *error))failure {
    
    AFHTTPSessionManager *manager = [CppInterface makeRequest:self.apiKey];
    [manager GET:[NSString stringWithFormat:@"%@/couponboxes/list", self.host]
      parameters:@{@"trackingId":trackingId,
                   @"totalAmount":[NSNumber numberWithInt:totalAmount]}
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             if (completion) {
                 completion((NSArray*)responseObject);
             }
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             if (failure) {
                 failure([CppInterface parseError:error]);
             }
         }];
}

- (void) analyticsRepurchase:(NSString *)trackingId
                 totalAmount:(int)totalAmount
                  completion:(void (^)(NSArray *result))completion
                     failure:(void (^)(NSArray *error))failure {
    
    AFHTTPSessionManager *manager = [CppInterface makeRequest:self.apiKey];
    [manager POST:[NSString stringWithFormat:@"%@/analytics/repurchase", self.host]
      parameters:@{@"trackingId":trackingId,
                   @"totalAmount":[NSNumber numberWithInt:totalAmount]}
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             if (completion) {
                 completion((NSArray*)responseObject);
             }
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             if (failure) {
                 failure([CppInterface parseError:error]);
             }
         }];
}


@end

