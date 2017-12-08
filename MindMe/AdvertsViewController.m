//
//  AdvertsViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 16/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "AdvertsViewController.h"
#import "AdvertsTableViewCell.h"

@interface AdvertsViewController ()

@end

@implementation AdvertsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    
}

- (void) setupInitialUI {
    
    _createAdvertButton.layer.cornerRadius = 20.0;
    _createAdvertButton.layer.masksToBounds = NO;
    
    _mailLabel.layer.cornerRadius = 5;
    _mailLabel.layer.masksToBounds = NO;
    _mailLabel.layer.borderColor = _createAdvertButton.backgroundColor.CGColor;
    _mailLabel.layer.borderWidth = 1.0;
    
    _advertLabel.layer.cornerRadius = 5;
    _advertLabel.layer.masksToBounds = NO;
    _advertLabel.layer.borderColor = _createAdvertButton.backgroundColor.CGColor;
    _advertLabel.layer.borderWidth = 1.0;
    
    _upgradedLabel.layer.cornerRadius = 5;
    _upgradedLabel.layer.masksToBounds = NO;
    _upgradedLabel.layer.borderColor = _createAdvertButton.backgroundColor.CGColor;
    _upgradedLabel.layer.borderWidth = 1.0;
    
    if (![[SharedClass sharedInstance] isUserCarer]) {
        
        _createAdvertButton.hidden = YES;
        _upgradedLabel.attributedText = [self attributedTextForUpgradedLabel:@"Subscribed\nSubscribe Now"];
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuButtonTapped:(id)sender {
    
    [self.sideMenuController showLeftViewAnimated];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma - mark TableView Datasource and Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"AdvertsTableViewCell";
    AdvertsTableViewCell *cell = (AdvertsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"AdvertsTableViewCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    [self populateContentForAdsCell:cell forIndexPath:indexPath];
    
    return cell;
    
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 120;
    
}


- (void) populateContentForAdsCell:(AdvertsTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (NSMutableAttributedString *) attributedTextForUpgradedLabel:(NSString *) labelText {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    
    return attributedString ;
    
}

@end
