//
//  SelectLanguageViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 19/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectLanguageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *bgTapView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextField *languageTextField;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

- (void) hideDrivingLicenseInfo:(id)sender;

@end
