//
//  SharedClass.h
//  PampersRewards
//
//  Created by Dipen Sekhsaria on 03/11/15.
//  Copyright © 2015 ProcterAndGamble. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LGSideMenuController.h"
#import "UIViewController+LGSideMenuController.h"

@interface SharedClass : NSObject {
}

+ sharedInstance;

@property BOOL isGuestUser;
@property BOOL isUserCarer;
@property NSString* userId;
@property NSString* authorizationKey;
@property BOOL isChangePasswordOpenedFromSideMenu;
@property BOOL isEditProfileMenuButtonHidden;

- (void) changeRootControllerForIdentifier:(NSString *)viewControllerId forSideMenuController:(LGSideMenuController *)sideMenuController;

@end
