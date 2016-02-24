//
//  DPBaseServiceRequest.h
//  DemoProject
//
//  Created by Niranjan K N on 15/07/14.
//  Copyright (c) 2014 Mindtree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "DPConstants.h"

@interface DPBaseServiceRequest : NSObject

@property (nonatomic, strong) NSDictionary *requestBody;
@property (nonatomic, strong) NSDictionary *requestHeaders;
@property (nonatomic, strong) NSString *requestHTTPMethod;
@property (nonatomic, strong) NSURLConnection *requestURLConnection;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) Reachability *serviceReachability;

- (void)createHeaderForRequest:(NSMutableURLRequest *)iRequestURL;
- (void)createBodyForRequest:(NSMutableURLRequest *)iRequestURL;
- (NSMutableURLRequest *)generateRequestWithURL:(NSURL *)iRequestURL;
- (BOOL)isNetworkReachable;

@end
