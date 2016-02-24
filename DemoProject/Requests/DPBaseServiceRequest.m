//
//  DPBaseServiceRequest.m
//  DemoProject
//
//  Created by Niranjan K N on 15/07/14.
//  Copyright (c) 2014 Mindtree. All rights reserved.
//

#import "DPBaseServiceRequest.h"

@implementation DPBaseServiceRequest

#pragma mark - Private Methods.

- (void)createHeaderForRequest:(NSMutableURLRequest *)iRequestURL {
	if (self.requestHeaders && [self.requestHeaders count] > 0) {
		NSArray *aHeaderKeyList = [self.requestHeaders allKeys];
		
		for (NSString *aKey in aHeaderKeyList) {
			[iRequestURL setValue:[self.requestHeaders valueForKey:aKey] forHTTPHeaderField:aKey];
		}
	}
}

- (void)createBodyForRequest:(NSMutableURLRequest *)iRequestURL {
	if (self.requestBody) {
		NSArray *aListOfKeys = [self.requestBody allKeys];
		NSString *aBodyString = nil;
		
		for (NSString *aBodyKey in aListOfKeys) {
			if (!aBodyString) {
				aBodyString = [NSString stringWithFormat:@"%@=%@", aBodyKey, [self.requestBody valueForKey:aBodyKey]];
			} else {
				aBodyString = [aBodyString stringByAppendingString:[NSString stringWithFormat:@"&%@=%@", aBodyKey, [self.requestBody valueForKey:aBodyKey]]];
			}
		}
		
		[iRequestURL setHTTPBody:[aBodyString dataUsingEncoding:NSUTF8StringEncoding]];
	}
}

- (NSMutableURLRequest *)generateRequestWithURL:(NSURL *)iRequestURL {
	NSMutableURLRequest *aNetworkRequest = [[NSMutableURLRequest alloc] init];
    [aNetworkRequest setURL:iRequestURL];
    [aNetworkRequest setHTTPMethod:self.requestHTTPMethod];
	
	[self createHeaderForRequest:aNetworkRequest];
	[self createBodyForRequest:aNetworkRequest];
	
	return aNetworkRequest;
}

- (BOOL)isNetworkReachable {
    // Making the reachability check
	Reachability * reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    return remoteHostStatus;
}


@end
