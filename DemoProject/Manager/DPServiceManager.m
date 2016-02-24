//
//  DPServiceManager.m
//  DemoProject
//
//  Created by Niranjan K N on 15/07/14.
//  Copyright (c) 2014 Mindtree. All rights reserved.
//

#import "DPServiceManager.h"
#import "DPConstants.h"
#import "DPServiceRequest.h"

@interface DPServiceManager ()

@property (nonatomic, strong) void(^requestCompletionBlock)(BOOL iSucceeded, id iResponseObject);

@end

@implementation DPServiceManager

#pragma mark - Service Request

+ (void)sendSyncRequestWithURL:(NSURL *)iRequestURL method:(DPServiceReqestHTTPMethod)iHTTPMethod body:(NSDictionary *)iBodyParameters header:(NSDictionary *)iHeaderParameters completionBlock:(DPServiceCompletionBlock)iCompletionBlock {
	
	DPServiceManager *aServiceManager = [[[self class] alloc] init];
	aServiceManager.requestCompletionBlock = iCompletionBlock;
	[aServiceManager sendSyncRequestWithURL:iRequestURL method:iHTTPMethod body:iBodyParameters header:iHeaderParameters];
}


+ (void)sendAsynchronousRequestWithURL:(NSURL *)iRequestURL method:(DPServiceReqestHTTPMethod)iHTTPMethod body:(NSDictionary *)iBodyParameters header:(NSDictionary *)iHeaderParameters completionBlock:(DPAsyncRequestCompletionBlock)iCompletionBlock {
    
	DPServiceManager *aServiceManager = [[[self class] alloc] init];
	[aServiceManager sendAsynchronousRequestWithURL:iRequestURL method:iHTTPMethod body:iBodyParameters header:iHeaderParameters completionBlock:(DPAsyncRequestCompletionBlock)iCompletionBlock];
}

#pragma mark - TPMGServiceRequest delegates

- (void)requestDidSucceedWithResponse:(id)iResponse {
	if (self.requestCompletionBlock) {
		self.requestCompletionBlock(YES, iResponse);
	}
}


- (void)requestDidFailWithResponse:(id)iResponse {
	if (self.requestCompletionBlock) {
		self.requestCompletionBlock(NO, iResponse);
	}
}

#pragma mark - Private Methods.

- (NSString *)requestHTTPMethodStringWithType:(DPServiceReqestHTTPMethod)iHTTPMethod {
	NSString *aRequestHTTPMethodString = nil;
	
	switch (iHTTPMethod) {
		case DPServiceReqestHTTPMethodPOST: {
			aRequestHTTPMethodString = kServiceRequestHTTPMethodPOST;
			break;
		}
			
		case DPServiceReqestHTTPMethodGET: {
			aRequestHTTPMethodString = kServiceRequestHTTPMethodGET;
			break;
		}
			
		case DPServiceReqestHTTPMethodPUT: {
			aRequestHTTPMethodString = kServiceRequestHTTPMethodPUT;
			break;
		}
			
		default:
			break;
	}
	
	return aRequestHTTPMethodString;
}

- (void)sendSyncRequestWithURL:(NSURL *)iRequestURL method:(DPServiceReqestHTTPMethod)iHTTPMethod body:(NSDictionary *)iBodyParameters header:(NSDictionary *)iHeaderParameters {
    
	DPServiceRequest *aServiceRequest = [[DPServiceRequest alloc] init];
	aServiceRequest.requestBody = iBodyParameters;
	aServiceRequest.requestHeaders = iHeaderParameters;
	aServiceRequest.delegate = self;
	aServiceRequest.requestHTTPMethod = [self requestHTTPMethodStringWithType:iHTTPMethod];
	
	[aServiceRequest fireSyncRequestWithURL:iRequestURL];
}


- (void)sendAsynchronousRequestWithURL:(NSURL *)iRequestURL method:(DPServiceReqestHTTPMethod)iHTTPMethod body:(NSDictionary *)iBodyParameters header:(NSDictionary *)iHeaderParameters completionBlock:(DPAsyncRequestCompletionBlock)iCompletionBlock {
    
	DPServiceRequest *aServiceRequest = [[DPServiceRequest alloc] init];
	aServiceRequest.requestBody = iBodyParameters;
	aServiceRequest.requestHeaders = iHeaderParameters;
	aServiceRequest.delegate = self;
	aServiceRequest.requestHTTPMethod = [self requestHTTPMethodStringWithType:iHTTPMethod];
	
	[aServiceRequest fireAsynchorousRequestWithURL:iRequestURL completionBlock:iCompletionBlock];
}



@end
