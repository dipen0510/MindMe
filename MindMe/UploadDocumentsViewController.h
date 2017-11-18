//
//  UploadDocumentsViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 19/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadDocumentsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *documentsCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;

- (IBAction)backButtonTapped:(id)sender;
@end
