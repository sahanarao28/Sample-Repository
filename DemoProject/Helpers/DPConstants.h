//
//  DPConstants.h
//  DemoProject
//
//  Created by Niranjan K N on 15/07/14.
//  Copyright (c) 2014 Mindtree. All rights reserved.
//

//Webservices URL

#define vLatestQuotationOrderURL [NSURL URLWithString:@"http://mobilespace.mindtree.com/VSSService/messageBoardInfo.json"]

// The HTTP method types.

#define kServiceRequestHTTPMethodPOST @"POST"
#define kServiceRequestHTTPMethodPUT @"PUT"
#define kServiceRequestHTTPMethodGET @"GET"

// This is a logging Utility that any application implementing this TPMGCommon module can use.

#ifdef DEBUG
#define LOG(fmt, ...) NSLog((@"%s %@"), __PRETTY_FUNCTION__, [NSString stringWithFormat:(@fmt), ##__VA_ARGS__])
#else
#define LOG(fmt, ...)
#endif
