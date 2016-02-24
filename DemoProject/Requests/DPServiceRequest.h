//
//  DPServiceRequest.h
//  DemoProject
//
//  Created by Niranjan K N on 15/07/14.
//  Copyright (c) 2014 Mindtree. All rights reserved.
//

#import "DPBaseServiceRequest.h"

@protocol DPServiceRequestDelegate <NSObject>

- (void)requestDidSucceedWithResponse:(id)iResponse;
- (void)requestDidFailWithResponse:(id)iResponse;

@end

@interface DPServiceRequest : DPBaseServiceRequest

@property (nonatomic, strong) id<DPServiceRequestDelegate> delegate;

- (void)fireSyncRequestWithURL:(NSURL *)iRequestURL;
- (void)fireAsynchorousRequestWithURL:(NSURL *)iRequestURL completionBlock:(void(^)(NSURLResponse *iResponse, NSData *iData, NSError *iError))iCompletionBlock;

@end
