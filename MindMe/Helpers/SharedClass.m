//
//  SharedClass.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 03/11/15.
//  Copyright © 2015 Stardeep. All rights reserved.
//

#import "SharedClass.h"

@implementation SharedClass

@synthesize isUserCarer,userId,authorizationKey,userAuthId;

static SharedClass *singletonObject = nil;

+ (id)sharedInstance {
    //static MyManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletonObject = [[self alloc] init];
    });
    return singletonObject;
}

- (id)init
{
    if (! singletonObject) {
        
        singletonObject = [super init];
        // Uncomment the following line to see how many times is the init method of the class is called
        // //NSLog(@"%s", __PRETTY_FUNCTION__);
    }
    return singletonObject;
}

- (void) changeRootControllerForIdentifier:(NSString *)viewControllerId forSideMenuController:(LGSideMenuController *)sideMenuController {
    
    UINavigationController *navigationController = (UINavigationController *)sideMenuController.rootViewController;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:viewControllerId];
    
    [navigationController setViewControllers:@[viewController]];
    
    // Rarely you can get some visual bugs when you change view hierarchy and toggle side views in the same iteration
    // You can use delay to avoid this and probably other unexpected visual bugs
    [sideMenuController hideLeftViewAnimated:YES delay:0.0 completionHandler:nil];
    
}

@end
