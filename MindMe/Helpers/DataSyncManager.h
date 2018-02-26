//
//  DataSyncManager.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 15/11/15.
//  Copyright (c) 2015 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <AFNetworking.h>

@protocol DataSyncManagerDelegate <NSObject>

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey;
-(void) didFinishServiceWithFailure:(NSString *)errorMsg;

@end

@interface DataSyncManager : NSObject {
    
    NSString* endDownTime;
    
}

@property (nonatomic, weak)  id <DataSyncManagerDelegate> delegate;
@property (nonatomic, strong) NSString* serviceKey;

- (void) startPOSTingFormData:(id)postData;
- (void) startPOSTingFormDataAfterLogin:(id)postData;
- (void) startPOSTingAdverDetails:(id)postData;
- (void) startPOSTingFormDataForRefreshingUserToken:(id)postData;
- (void) startStripeAPIWithsData:(id)postData;
- (void) startGoogleAPIGeocodeWebService:(NSString *)param;

@end
