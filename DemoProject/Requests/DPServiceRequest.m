//
//  DPServiceRequest.m
//  DemoProject
//
//  Created by Niranjan K N on 15/07/14.
//  Copyright (c) 2014 Mindtree. All rights reserved.
//

#import "DPServiceRequest.h"

@implementation DPServiceRequest

#pragma mark - Request

- (void)fireSyncRequestWithURL:(NSURL *)iRequestURL {
	NSMutableURLRequest *aNetworkRequest = [self generateRequestWithURL:iRequestURL];
	
	if ([self isNetworkReachable]) {
		// Clear the request whenever you fire a new one.
		[self purgeRequest];
        
        NSError *error = nil;
        NSURLResponse *urlResponse = nil;
        NSData *aData = [NSURLConnection sendSynchronousRequest:aNetworkRequest returningResponse:&urlResponse error:&error];
        
        if (error) {
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestDidFailWithResponse:)]) {
                [self.delegate requestDidFailWithResponse:error];
            }
        }
        
        else {
            
            self.responseData = [aData mutableCopy];
            [self parseResponse];
        }
        
        
	} else {
		// TODO: Throw a generic no network connection error from here.
	}
}


- (void)fireAsynchorousRequestWithURL:(NSURL *)iRequestURL completionBlock:(void(^)(NSURLResponse *iResponse, NSData *iData, NSError *iError))iCompletionBlock {
	NSMutableURLRequest *aNetworkRequest = [self generateRequestWithURL:iRequestURL];
	
	if ([self isNetworkReachable]) {
		NSOperationQueue *anOperationQueue = [[NSOperationQueue alloc] init];
		[NSURLConnection sendAsynchronousRequest:aNetworkRequest queue:anOperationQueue completionHandler:iCompletionBlock];
	}  else {
		// TODO: Throw a generic no network connection error from here.
	}
}


#pragma mark - Private Methods.

- (void)parseResponse {
	if (self.responseData) {
		NSError *anError = nil;
		NSDictionary *aResponseDictionary = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingAllowFragments error:&anError];
		
		if (anError != nil) {
			// If the parsing of the data fails, read the data in the NSISOLatin1StringEncoding and reconvert it to NSUTF8StringEncoding.
			anError = nil;
			NSString *aJsonString = [[NSString alloc] initWithData:self.responseData encoding:NSISOLatin1StringEncoding];
			aResponseDictionary = [NSJSONSerialization JSONObjectWithData:[aJsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&anError];
			
			if (anError != nil) {
				LOG("Parsing the response failed : Error : %@", [anError localizedDescription]);
				
				if (self.delegate && [self.delegate respondsToSelector:@selector(requestDidFailWithResponse:)]) {
					[self.delegate requestDidFailWithResponse:anError];
				}
				
				[self purgeRequest];
			} else {
				if (self.delegate && [self.delegate respondsToSelector:@selector(requestDidSucceedWithResponse:)]) {
					[self.delegate requestDidSucceedWithResponse:aResponseDictionary];
				}
			}
		} else {
			if (self.delegate && [self.delegate respondsToSelector:@selector(requestDidSucceedWithResponse:)]) {
				[self.delegate requestDidSucceedWithResponse:aResponseDictionary];
			}
		}
	}
}


- (void)purgeRequest {
	// Cancel the request
	[self.requestURLConnection cancel];
	
	// Clear the response data.
	self.responseData = [NSMutableData dataWithLength:0];
}


#pragma mark - NSURLConnection Delegates

- (void)connectionDidFinishLoading:(NSURLConnection *)iConnection {
	[self parseResponse];
}


- (void)connection:(NSURLConnection *)iConnection didReceiveResponse:(NSURLResponse *)iResponse {
    
}


- (void)connection:(NSURLConnection *)iConnection didReceiveData:(NSData *)iData {
	[self.responseData appendData:iData];
}


- (void)connection:(NSURLConnection *)iConnection didFailWithError:(NSError *)iError {
	if (self.delegate && [self.delegate respondsToSelector:@selector(requestDidFailWithResponse:)]) {
		[self.delegate requestDidFailWithResponse:iError];
	}
	
	[self purgeRequest];
}



@end
