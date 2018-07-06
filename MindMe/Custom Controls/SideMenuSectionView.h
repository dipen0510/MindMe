//
//  SideMenuSectionView.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 16/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuSectionView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *menuImage;
@property (weak, nonatomic) IBOutlet UILabel *menuTitle;
@property (weak, nonatomic) IBOutlet UIImageView *chevronImgView;
@property (weak, nonatomic) IBOutlet UILabel *messageCounterLabel;

@end
