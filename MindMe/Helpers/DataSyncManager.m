//
//  DataSyncManager.m
//  PampersRewards
//
//  Created by Dipen Sekhsaria on 15/11/15.
//  Copyright (c) 2015 ProcterAndGamble. All rights reserved.
//

#import "DataSyncManager.h"

@implementation DataSyncManager
@synthesize delegate,serviceKey;

 - (void) startPOSTingFormData:(id)postData {
     
     NSURL* url;
       url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",WebServiceURL]];
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
     
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    [manager.requestSerializer setValue:@"24ad1dc1-c5e2-4bbc-a261-9de40fa7d7c7" forHTTPHeaderField:@"Auth-Key"];
     [manager.requestSerializer setValue:@"frontend-client" forHTTPHeaderField:@"Client-Service"];
     
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer.acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 300)];
     manager.requestSerializer.timeoutInterval = 60;
     
     
     [manager POST:self.serviceKey parameters:postData constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
         
         
         
     } progress:nil success:^(NSURLSessionTask *task, id responseObject) {
         
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             
             if ([[responseObject valueForKey:@"status"] intValue] == 200) {
                 if ([delegate respondsToSelector:@selector(didFinishServiceWithSuccess:andServiceKey:)]) {
                     [delegate didFinishServiceWithSuccess:[self prepareResponseObjectForServiceKey:self.serviceKey withData:responseObject] andServiceKey:self.serviceKey];
                 }
                 
             }
             else {
                 
                 if ([delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
                         [delegate didFinishServiceWithFailure:[self errorStringForService:self.serviceKey withData:responseObject]];
                     }
                     
                 }
             
         }
         else {
             if ([delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
                 [delegate didFinishServiceWithFailure:NSLocalizedString(@"An issue occured while processing your request. Please try again later.", nil)];
             }
         }
         
     } failure:^(NSURLSessionTask *task, NSError *error) {
         
         if ([delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
             [delegate didFinishServiceWithFailure:NSLocalizedString(@"Verify your internet connection and try again", nil)];
         }
         
     }];
     
    
}

- (id) prepareResponseObjectForServiceKey:(NSString *) responseServiceKey withData:(id)responseObj {
    
    if ([responseServiceKey isEqualToString:RegisterServiceKey] || [responseServiceKey isEqualToString:LoginServiceKey]) {
        
        if ([[responseObj valueForKey:@"flag"] isEqualToString:@"users"]) {
            [[SharedClass sharedInstance] setIsUserCarer:NO];
        }
        else {
            [[SharedClass sharedInstance] setIsUserCarer:YES];
        }
        
        [[SharedClass sharedInstance] setUserId:[responseObj valueForKey:@"Userid"]];
        
    }
    
    return responseObj;
    
}





- (NSString *) errorStringForService:(NSString *) responseServiceKey withData:(id)responseObj {
    
    return [responseObj valueForKey:@"message"];
    
}


- (BOOL)isNetworkRechable {
    
    if ([AFNetworkReachabilityManager sharedManager].reachable) {
        
        if ([AFNetworkReachabilityManager sharedManager].isReachableViaWiFi)
            NSLog(@"Network reachable via WWAN");
        else
            NSLog(@"Network reachable via Wifi");
        
        return YES;
    }
    else {
        
        NSLog(@"Network is not reachable");
        return NO;
    }
}

@end
