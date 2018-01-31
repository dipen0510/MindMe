//
//  DataSyncManager.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 15/11/15.
//  Copyright (c) 2015 Stardeep. All rights reserved.
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

- (void) startPOSTingFormDataAfterLogin:(id)postData {
    
    NSURL* url;
    url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",WebServiceURL]];
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    [manager.requestSerializer setValue:@"24ad1dc1-c5e2-4bbc-a261-9de40fa7d7c7" forHTTPHeaderField:@"Auth-Key"];
    [manager.requestSerializer setValue:@"frontend-client" forHTTPHeaderField:@"Client-Service"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",[[SharedClass sharedInstance] userId]] forHTTPHeaderField:@"User-ID"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",[[SharedClass sharedInstance] authorizationKey]] forHTTPHeaderField:@"Authorization"];
    
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

- (void) startPOSTingAdverDetails:(id)postData {
    
    NSURL* url;
    url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",WebServiceURL]];
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    [manager.requestSerializer setValue:@"24ad1dc1-c5e2-4bbc-a261-9de40fa7d7c7" forHTTPHeaderField:@"Auth-Key"];
    [manager.requestSerializer setValue:@"frontend-client" forHTTPHeaderField:@"Client-Service"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",[[SharedClass sharedInstance] userId]] forHTTPHeaderField:@"User-ID"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",[[SharedClass sharedInstance] authorizationKey]] forHTTPHeaderField:@"Authorization"];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer.acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 300)];
    manager.requestSerializer.timeoutInterval = 60;
    
    UIImage* profileImage = [postData valueForKey:@"profileImage"];
    [postData removeObjectForKey:@"profileImage"];
    
    
    [manager POST:self.serviceKey parameters:postData constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if (profileImage && ![profileImage isEqual:@""]) {
            NSData* data = UIImagePNGRepresentation(profileImage);
            
            [formData appendPartWithFileData:data
                                        name:@"image_path"
                                    fileName:[NSString stringWithFormat:@"%@_profile.png",[[NSUUID UUID] UUIDString]] mimeType:@"image/png"];
        }
        
        
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

- (void) startGoogleAPIGeocodeWebService:(NSString *)param
{
    
    NSURL* url;
    url = [NSURL URLWithString:@"https://maps.googleapis.com/maps/api/geocode"];
    
    NSString* finalParams = [NSString stringWithFormat:@"json?address=%@&key=AIzaSyDr_kpZrjTFwpVwZ3PYpjxVhcJiKFcfnD8&components=country:IE",param];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.requestSerializer.timeoutInterval = 30;
    
    [manager GET:finalParams parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[responseObject valueForKey:@"status"] isEqualToString:@"OK"]) {
            if ([delegate respondsToSelector:@selector(didFinishServiceWithSuccess:andServiceKey:)]) {
                [delegate didFinishServiceWithSuccess:[self prepareResponseObjectForServiceKey:self.serviceKey withData:responseObject] andServiceKey:self.serviceKey];
            }
            
        }
        else {
            
            NSLog(@"%@",responseObject);
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
    
    
}

- (id) prepareResponseObjectForServiceKey:(NSString *) responseServiceKey withData:(id)responseObj {
    
    if ([responseServiceKey isEqualToString:RegisterServiceKey] || [responseServiceKey isEqualToString:LoginServiceKey]  || [responseServiceKey isEqualToString:FBRegisterServiceKey]  || [responseServiceKey isEqualToString:FBLoginServiceKey]) {
        
        if ([[responseObj valueForKey:@"flag"] isEqualToString:@"users"]) {
            [[SharedClass sharedInstance] setIsUserCarer:NO];
        }
        else {
            [[SharedClass sharedInstance] setIsUserCarer:YES];
        }
        
        [[SharedClass sharedInstance] setIsGuestUser:NO];
        [[SharedClass sharedInstance] setIsEditProfileMenuButtonHidden:YES];
        [[SharedClass sharedInstance] setUserId:[responseObj valueForKey:@"Userid"]];
        [[SharedClass sharedInstance] setAuthorizationKey:[responseObj valueForKey:@"token"]];
        
        [[NSUserDefaults standardUserDefaults] setObject:[responseObj valueForKey:@"Userid"] forKey:@"Userid"];
        [[NSUserDefaults standardUserDefaults] setObject:[responseObj valueForKey:@"token"] forKey:@"token"];
        [[NSUserDefaults standardUserDefaults] setBool:[[SharedClass sharedInstance] isUserCarer] forKey:@"isUserCarer"];
        
        if ([responseServiceKey isEqualToString:RegisterServiceKey] || [responseServiceKey isEqualToString:FBRegisterServiceKey]) {
            if ([responseObj valueForKey:@"data"] && ![[responseObj valueForKey:@"data"] isEqual:[NSNull null]]) {
                NSArray* arr = [[NSArray alloc] initWithArray:[responseObj valueForKey:@"data"]];
                
                NSMutableDictionary* dict = [[NSMutableDictionary alloc] initWithDictionary:[arr objectAtIndex:0]];
                [dict setObject:[[responseObj valueForKey:@"userdata"] valueForKey:@"user_email"] forKey:@"user_email"];
                [dict setObject:[[responseObj valueForKey:@"userdata"] valueForKey:@"Sub_active"] forKey:@"Sub_active"];
                
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
                [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"profileDetails"];
                
                NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:dict];
                [[NSUserDefaults standardUserDefaults] setObject:data1 forKey:@"profileDetailsCopy"];
                
            }
        }
        else {
            if ([responseObj valueForKey:@"data"] && ![[responseObj valueForKey:@"data"] isEqual:[NSNull null]]) {
                
                NSMutableDictionary* dict = [[NSMutableDictionary alloc] initWithDictionary:[responseObj valueForKey:@"data"]];
                [dict setObject:[[responseObj valueForKey:@"userdata"] valueForKey:@"user_email"] forKey:@"user_email"];
                [dict setObject:[[responseObj valueForKey:@"userdata"] valueForKey:@"Sub_active"] forKey:@"Sub_active"];
                
                
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
                [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"profileDetails"];
                
                NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:dict];
                [[NSUserDefaults standardUserDefaults] setObject:data1 forKey:@"profileDetailsCopy"];
                
            }
        }
        
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
