//
//  SharedClass.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 03/11/15.
//  Copyright © 2015 Stardeep. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LGSideMenuController.h"
#import "UIViewController+LGSideMenuController.h"

@interface SharedClass : NSObject {
}

+ sharedInstance;

@property BOOL isRegisterTappedOnStart;
@property BOOL isGuestUser;
@property BOOL isUserCarer;
@property NSString* userId;
@property NSString* authorizationKey;
@property NSString* userAuthId;
@property BOOL isChangePasswordOpenedFromSideMenu;

@property BOOL isFeaturedFilterApplied;
@property BOOL isLastMinuiteCareFilterApplied;

@property (strong, nonatomic) NSString* unreadMessageCount;

- (void) changeRootControllerForIdentifier:(NSString *)viewControllerId forSideMenuController:(LGSideMenuController *)sideMenuController;
- (NSString *) filterOutMobileAndEmail:(NSString *) searchString;
- (NSString *) filterNumbersAndPostCodeFromAddressString:(NSString *) text;
- (void) removePluralsFromCareTypeLabel:(UILabel *)label;

@end
