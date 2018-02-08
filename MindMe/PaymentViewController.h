//
//  PaymentViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 16/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentViewController : UIViewController <DataSyncManagerDelegate, UITextFieldDelegate> {
    NSString* cardToken;
    NSString* customerId;
    NSString* subscriptionId;
}

@property (nonatomic, strong) NSMutableDictionary* subscriptionDict;

@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (weak, nonatomic) IBOutlet UITextField *monthTextField;
@property (weak, nonatomic) IBOutlet UITextField *yearTextField;
@property (weak, nonatomic) IBOutlet UITextField *cvvTextField;
@property (weak, nonatomic) IBOutlet UITextField *cardNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *cardNameTextField;

- (IBAction)payButtonTapped:(id)sender;
- (IBAction)cancelButtonTapped:(id)sender;
- (IBAction)backButtonTapped:(id)sender;

@end
