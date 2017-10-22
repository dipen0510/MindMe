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

- (void) changeRootControllerForIdentifier:(NSString *)viewControllerId forSideMenuController:(LGSideMenuController *)sideMenuController;

@end
