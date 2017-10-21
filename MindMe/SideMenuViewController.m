//
//  SideMenuViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 21/10/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "SideMenuViewController.h"
#import "SideMenuTableViewCell.h"

@interface SideMenuViewController ()

@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    menuItemsArray=[[NSArray alloc]initWithObjects:@"Profile", @"My ADs", @"Search", @"Information", @"News", @"Contact", nil];
    menuImageArray = [[NSArray alloc]initWithObjects:@"ic_avatar",@"my_ads_icon",@"ic_search",@"info_icon",@"news_icon",@"ic_email",nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - mark TableView Datasource and Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return menuItemsArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"SideMenuTableViewCell";
    SideMenuTableViewCell *cell = (SideMenuTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SideMenuTableViewCell" owner:self options:nil];
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
    
    return 70;
    
}


- (void) populateContentForAdsCell:(SideMenuTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.menuImage.image = [UIImage imageNamed:[menuImageArray objectAtIndex:indexPath.row]];
    cell.menuTitle.text = [menuItemsArray objectAtIndex:indexPath.row];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
