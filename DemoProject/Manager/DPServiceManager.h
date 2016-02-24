//
//  DPServiceManager.h
//  DemoProject
//
//  Created by Niranjan K N on 15/07/14.
//  Copyright (c) 2014 Mindtree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPServiceRequest.h"

typedef enum {
	DPServiceReqestHTTPMethodPOST,
	DPServiceReqestHTTPMethodPUT,
	DPServiceReqestHTTPMethodGET
} DPServiceReqestHTTPMethod;

/* The iSucceeded flag will tell whether the request went through or failed.
 * The iResponseObject can contain an NSDictionary, NSArray or NSError as applicable.
 * The implementing application has to validate the type of the response object on receipt.
 */
typedef void (^DPServiceCompletionBlock)(BOOL iSucceeded, id iResponseObject);

/* This block is for the asynchronous request.
 */
typedef void (^DPAsyncRequestCompletionBlock)(NSURLResponse *iResponse, NSData *iData, NSError *iError);

@interface DPServiceManager : NSObject<DPServiceRequestDelegate>

/* This method can be invoked to fire a request to get the required data.
 * This method will return the NSDictionary or NSArray objects if the request is successful.
 * This method will return the NSError object or an Error dictionary if the request fails.
 */

+ (void)sendSyncRequestWithURL:(NSURL *)iRequestURL method:(DPServiceReqestHTTPMethod)iHTTPMethod body:(NSDictionary *)iBodyParameters header:(NSDictionary *)iHeaderParameters completionBlock:(DPServiceCompletionBlock)iCompletionBlock;

// Asynchronous request
+ (void)sendAsynchronousRequestWithURL:(NSURL *)iRequestURL method:(DPServiceReqestHTTPMethod)iHTTPMethod body:(NSDictionary *)iBodyParameters header:(NSDictionary *)iHeaderParameters completionBlock:(DPAsyncRequestCompletionBlock)iCompletionBlock;

@end
