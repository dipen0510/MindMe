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

- (void) startPOSTingFormDataForRefreshingUserToken:(id)postData {
    
    NSURL* url;
    url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",WebServiceURL]];
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    [manager.requestSerializer setValue:@"24ad1dc1-c5e2-4bbc-a261-9de40fa7d7c7" forHTTPHeaderField:@"Auth-Key"];
    [manager.requestSerializer setValue:@"frontend-client" forHTTPHeaderField:@"Client-Service"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",[[SharedClass sharedInstance] userId]] forHTTPHeaderField:@"User-ID"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",[[SharedClass sharedInstance] authorizationKey]] forHTTPHeaderField:@"Authorization"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",[[SharedClass sharedInstance] userAuthId]] forHTTPHeaderField:@"User-Auth-Id"];
    
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
                else {
                    [self prepareResponseObjectForServiceKey:self.serviceKey withData:responseObject];
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
    
    UIImage* profileImage = [self compressImage:[postData valueForKey:@"image_path"]];
    [postData removeObjectForKey:@"image_path"];
    
    
    [manager POST:self.serviceKey parameters:postData constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if (profileImage && ![profileImage isEqual:@""]) {
            NSData* data = UIImageJPEGRepresentation(profileImage,1.);
            
            [formData appendPartWithFileData:data
                                        name:@"image_path"
                                    fileName:[NSString stringWithFormat:@"%@_profile.jpg",[[NSUUID UUID] UUIDString]] mimeType:@"image/jpeg"];
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

- (void) startStripeAPIWithsData:(id)postData {
    
    NSURL* url;
    url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",StripeBaseURL]];
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"sk_test_VgD8PsQ4E4DW9FB3Sdo0UnMu" password:@""];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer.acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 300)];
    manager.requestSerializer.timeoutInterval = 60;
    
    
    [manager POST:self.serviceKey parameters:postData progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if ([[responseObject allKeys] containsObject:@"id"]) {
                if ([delegate respondsToSelector:@selector(didFinishServiceWithSuccess:andServiceKey:)]) {
                    [delegate didFinishServiceWithSuccess:[self prepareResponseObjectForServiceKey:self.serviceKey withData:responseObject] andServiceKey:self.serviceKey];
                }
            }
            else {
                if ([delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
                    [delegate didFinishServiceWithFailure:NSLocalizedString(@"An issue occured while processing your request. Please try again later.", nil)];
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


- (void) startStripeAPIToFetchSubscriptionIdWithsData:(id)postData {
    
    NSURL* url;
    url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/customers",StripeBaseURL]];
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"sk_test_VgD8PsQ4E4DW9FB3Sdo0UnMu" password:@""];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer.acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 300)];
    manager.requestSerializer.timeoutInterval = 60;
    
    
    [manager POST:[postData valueForKey:@"customer"] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if ([[responseObject allKeys] containsObject:@"id"]) {
                if ([delegate respondsToSelector:@selector(didFinishServiceWithSuccess:andServiceKey:)]) {
                    [delegate didFinishServiceWithSuccess:[self prepareResponseObjectForServiceKey:self.serviceKey withData:responseObject] andServiceKey:self.serviceKey];
                }
            }
            else {
                if ([delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
                    [delegate didFinishServiceWithFailure:NSLocalizedString(@"An issue occured while processing your request. Please try again later.", nil)];
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

- (void) startStripeAPIToDeleteSubscriptionWithsData:(id)postData {
    
    NSURL* url;
    url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",StripeBaseURL,self.serviceKey]];
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"sk_test_VgD8PsQ4E4DW9FB3Sdo0UnMu" password:@""];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer.acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 300)];
    manager.requestSerializer.timeoutInterval = 60;
    
    NSString* subId = [postData valueForKey:@"subId"];
    [postData removeObjectForKey:@"subId"];
    
    [manager DELETE:subId parameters:postData success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if ([[responseObject allKeys] containsObject:@"id"]) {
                if ([delegate respondsToSelector:@selector(didFinishServiceWithSuccess:andServiceKey:)]) {
                    [delegate didFinishServiceWithSuccess:[self prepareResponseObjectForServiceKey:self.serviceKey withData:responseObject] andServiceKey:self.serviceKey];
                }
            }
            else {
                if ([delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
                    [delegate didFinishServiceWithFailure:NSLocalizedString(@"An issue occured while processing your request. Please try again later.", nil)];
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
    
    
//    [manager DELETE:subId parameters:postData progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            
//            if ([[responseObject allKeys] containsObject:@"id"]) {
//                if ([delegate respondsToSelector:@selector(didFinishServiceWithSuccess:andServiceKey:)]) {
//                    [delegate didFinishServiceWithSuccess:[self prepareResponseObjectForServiceKey:self.serviceKey withData:responseObject] andServiceKey:self.serviceKey];
//                }
//            }
//            else {
//                if ([delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
//                    [delegate didFinishServiceWithFailure:NSLocalizedString(@"An issue occured while processing your request. Please try again later.", nil)];
//                }
//            }
//            
//        }
//        else {
//            if ([delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
//                [delegate didFinishServiceWithFailure:NSLocalizedString(@"An issue occured while processing your request. Please try again later.", nil)];
//            }
//        }
//        
//    } failure:^(NSURLSessionTask *task, NSError *error) {
//        
//        if ([delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
//            [delegate didFinishServiceWithFailure:NSLocalizedString(@"Verify your internet connection and try again", nil)];
//        }
//        
//    }];
    
    
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
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isEditProfileMenuButtonHidden"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isProfileUpdated"];
        [[SharedClass sharedInstance] setUserId:[responseObj valueForKey:@"Userid"]];
        [[SharedClass sharedInstance] setAuthorizationKey:[responseObj valueForKey:@"token"]];
        [[SharedClass sharedInstance] setUserAuthId:[responseObj valueForKey:@"User_auth_id"]];
        
        [[NSUserDefaults standardUserDefaults] setObject:[responseObj valueForKey:@"Userid"] forKey:@"Userid"];
        [[NSUserDefaults standardUserDefaults] setObject:[responseObj valueForKey:@"token"] forKey:@"token"];
        [[NSUserDefaults standardUserDefaults] setBool:[[SharedClass sharedInstance] isUserCarer] forKey:@"isUserCarer"];
        [[NSUserDefaults standardUserDefaults] setObject:[responseObj valueForKey:@"User_auth_id"] forKey:@"User_auth_id"];
        
        if ([responseServiceKey isEqualToString:RegisterServiceKey] || [responseServiceKey isEqualToString:FBRegisterServiceKey]) {
            if ([responseObj valueForKey:@"data"] && ![[responseObj valueForKey:@"data"] isEqual:[NSNull null]]) {
                NSArray* arr = [[NSArray alloc] initWithArray:[responseObj valueForKey:@"data"]];
                
                NSMutableDictionary* dict = [[NSMutableDictionary alloc] initWithDictionary:[arr objectAtIndex:0]];
                [dict setObject:[[responseObj valueForKey:@"userdata"] valueForKey:@"user_email"] forKey:@"user_email"];
                [dict setObject:[[responseObj valueForKey:@"userdata"] valueForKey:@"Sub_active"] forKey:@"Sub_active"];
                [dict setObject:[[responseObj valueForKey:@"userdata"] valueForKey:@"reference_id"] forKey:@"sub_id"];
                
                [dict setObject:[[responseObj valueForKey:@"userdata"] valueForKey:@"mail_counter"] forKey:@"mail_counter"];
                
                NSArray* limitArr = [[NSArray alloc] initWithArray:[responseObj valueForKey:@"free_limit"]];
                if (limitArr.count>0) {
                    [dict setObject:[[limitArr objectAtIndex:0] valueForKey:@"value"] forKey:@"free_limit"];
                }
                
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
                [dict setObject:[[responseObj valueForKey:@"userdata"] valueForKey:@"reference_id"] forKey:@"sub_id"];
                
                NSArray* limitArr = [[NSArray alloc] initWithArray:[responseObj valueForKey:@"free_limit"]];
                if (limitArr.count>0) {
                    [dict setObject:[[limitArr objectAtIndex:0] valueForKey:@"value"] forKey:@"free_limit"];
                }
                
                [dict setObject:[[responseObj valueForKey:@"userdata"] valueForKey:@"mail_counter"] forKey:@"mail_counter"];
                
                
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
                [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"profileDetails"];
                
                NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:dict];
                [[NSUserDefaults standardUserDefaults] setObject:data1 forKey:@"profileDetailsCopy"];
                
            }
        }
        
    }
    
    
    
    if ([responseServiceKey isEqualToString:GetUserPersonalDetails]) {
        
        if ([[responseObj valueForKey:@"flag"] isEqualToString:@"users"]) {
            [[SharedClass sharedInstance] setIsUserCarer:NO];
        }
        else {
            [[SharedClass sharedInstance] setIsUserCarer:YES];
        }
        
        [[SharedClass sharedInstance] setIsGuestUser:NO];
        
        [[SharedClass sharedInstance] setUserId:[responseObj valueForKey:@"Userid"]];
        [[SharedClass sharedInstance] setAuthorizationKey:[responseObj valueForKey:@"token"]];
        [[SharedClass sharedInstance] setUserAuthId:[responseObj valueForKey:@"User_auth_id"]];
        
        [[NSUserDefaults standardUserDefaults] setObject:[responseObj valueForKey:@"Userid"] forKey:@"Userid"];
        [[NSUserDefaults standardUserDefaults] setObject:[responseObj valueForKey:@"token"] forKey:@"token"];
        [[NSUserDefaults standardUserDefaults] setBool:[[SharedClass sharedInstance] isUserCarer] forKey:@"isUserCarer"];
        [[NSUserDefaults standardUserDefaults] setObject:[responseObj valueForKey:@"User_auth_id"] forKey:@"User_auth_id"];
        
        
        if ([responseObj valueForKey:@"data"] && ![[responseObj valueForKey:@"data"] isEqual:[NSNull null]]) {
                
                NSMutableDictionary* dict = [[NSMutableDictionary alloc] initWithDictionary:[responseObj valueForKey:@"data"]];
                [dict setObject:[[responseObj valueForKey:@"userdata"] valueForKey:@"user_email"] forKey:@"user_email"];
                [dict setObject:[[responseObj valueForKey:@"userdata"] valueForKey:@"Sub_active"] forKey:@"Sub_active"];
            [dict setObject:[[responseObj valueForKey:@"userdata"] valueForKey:@"reference_id"] forKey:@"sub_id"];
            
            NSArray* limitArr = [[NSArray alloc] initWithArray:[responseObj valueForKey:@"free_limit"]];
            if (limitArr.count>0) {
                [dict setObject:[[limitArr objectAtIndex:0] valueForKey:@"value"] forKey:@"free_limit"];
            }
            
            [dict setObject:[[responseObj valueForKey:@"userdata"] valueForKey:@"mail_counter"] forKey:@"mail_counter"];
            
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
                [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"profileDetails"];
                
                NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:dict];
                [[NSUserDefaults standardUserDefaults] setObject:data1 forKey:@"profileDetailsCopy"];
                
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

-(UIImage *)compressImage:(UIImage *)image{
    
    NSData *imgData = UIImageJPEGRepresentation(image, 1); //1 it represents the quality of the image.
    NSLog(@"Size of Image(bytes):%ld",(unsigned long)[imgData length]);
    
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float maxHeight = 600.0;
    float maxWidth = 800.0;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 0.5;//50 percent compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth){
        if(imgRatio < maxRatio){
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio){
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else{
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    
    NSLog(@"Size of Image(bytes):%ld",(unsigned long)[imageData length]);
    
    return [UIImage imageWithData:imageData];
}

@end
