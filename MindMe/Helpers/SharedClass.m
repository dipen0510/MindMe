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

- (NSString *) filterOutMobileAndEmail:(NSString *) searchString {
    
    NSString* returnString = [[NSString alloc] initWithString:searchString];
    
    // regex string for emails
    NSString *regexString = @"([A-Za-z0-9_\\-\\.\\+])+\\@([A-Za-z0-9_\\-\\.])+\\.([A-Za-z]+)";
    
    // track regex error
    NSError *error = NULL;
    
    // create regular expression
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:0 error:&error];
    
    // make sure there is no error
    if (!error) {
        
        // get all matches for regex
        NSArray *matches = [regex matchesInString:searchString options:0 range:NSMakeRange(0, searchString.length)];
        
        // loop through regex matches
        for (NSTextCheckingResult *match in matches) {
            
            // get the current text
            NSString *matchText = [searchString substringWithRange:match.range];
            
            returnString = [returnString stringByReplacingOccurrencesOfString:matchText withString:@"[removed]"];
            
            NSLog(@"Extracted: %@", matchText);
            
        }
        
    }
    
    
    //PHONE VALIDATION
    
    NSError *error1 = NULL;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber error:&error1];
    NSArray *matches = [detector matchesInString:searchString options:0 range:NSMakeRange(0, [searchString length])];
    if (matches != nil) {
        for (NSTextCheckingResult *match in matches) {
            if ([match resultType] == NSTextCheckingTypePhoneNumber) {
                NSString *matchText = [searchString substringWithRange:match.range];
                
                returnString = [returnString stringByReplacingOccurrencesOfString:matchText withString:@"[removed]"];
                
                NSLog(@"Extracted: %@", matchText);
            }
        }
    }
    
    
    return returnString;
    
}

- (NSString *) filterNumbersAndPostCodeFromAddressString:(NSString *) text {
    
    NSString* retText = [[NSString alloc] initWithString:text];
    int flag = 0;
    
    // regex string for emails
    NSString *regexString = @"[A-Za-z]\\d{2}\\s[A-Za-z\\d]{4}";
    
    // track regex error
    NSError *error = NULL;
    
    // create regular expression
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:0 error:&error];
    
    // make sure there is no error
    if (!error) {
        
        // get all matches for regex
        NSArray *matches = [regex matchesInString:text options:0 range:NSMakeRange(0, text.length)];
        
        // loop through regex matches
        for (NSTextCheckingResult *match in matches) {
            
            // get the current text
            NSString *matchText = [text substringWithRange:match.range];
            
            retText = [retText stringByReplacingOccurrencesOfString:matchText withString:[matchText substringToIndex:3]];
            
            if (match.range.location == 0 || match.range.location == 1 || match.range.location == 2 || match.range.location == 3 || match.range.location == 4 || match.range.location == 5) {
                flag = 1;
            }
            
            NSLog(@"Extracted: %@", matchText);
            
        }
        
    }
    
    
    NSString* newRetText = @"";
    
    
    for(NSInteger i = 0; i < 6 && flag == 0; i++)
    {
        NSString *character = [retText substringWithRange:NSMakeRange(i, 1)];
        if ([character rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789"]].location != NSNotFound) {
            newRetText = [newRetText stringByAppendingString:@""];
        }
        else {
            newRetText = [newRetText stringByAppendingString:character];
        }
    }
    
    if (flag == 0) {
        newRetText = [newRetText stringByAppendingString:[retText substringWithRange:NSMakeRange(6, retText.length-6)]];
        newRetText = [newRetText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
    else {
        return retText;
    }
    
    return newRetText;
    
}


@end
