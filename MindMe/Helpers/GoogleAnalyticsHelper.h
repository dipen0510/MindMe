//
//  GoogleAnalyticsHelper.h
// 
//
//  Created by Dipen Sekhsaria on 26/11/15.
//  Copyright © 2015. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"

@interface GoogleAnalyticsHelper : NSObject {
    GAI *gai;
    id<GAITracker> tracker;
}

+ sharedInstance;

@end
