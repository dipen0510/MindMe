//
//  YourInformationViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 18/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "YourInformationViewController.h"
#import "ProfileActivitiesCollectionViewCell.h"
#import "CreateAdvertsCollectionViewCell.h"
#import "SelectLanguageViewController.h"
#import "ActionSheetPicker.h"
#import "YourAdvertViewController.h"

@interface YourInformationViewController () {
    
    SelectLanguageViewController* selectLanguageController;
    
}

@end

@implementation YourInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    [self setupActionSheet];
    [self setupUIForEditingAdvert];
    
}

- (void) setupInitialUI {
    
    _profileImgView.layer.cornerRadius = _profileImgView.frame.size.height/2.;
    _profileImgView.layer.masksToBounds = YES;
    _profileImgView.userInteractionEnabled = YES;
    [_profileImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnProfileImageButton)]];
    
    _nextButton.layer.cornerRadius = 17.5;
    _nextButton.layer.masksToBounds = NO;
    
    _cancelButton.layer.cornerRadius = 17.5;
    _cancelButton.layer.masksToBounds = NO;
    _cancelButton.layer.borderWidth = 1.0;
    _cancelButton.layer.borderColor = _cancelButton.titleLabel.textColor.CGColor;
    
    [self.languagesCollectionView registerNib:[UINib nibWithNibName:@"ProfileActivitiesCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"ProfileActivitiesCollectionViewCell"];
    [self.miscCollectionView registerNib:[UINib nibWithNibName:@"CreateAdvertsCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"CreateAdvertsCollectionViewCell"];
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    tapGesture.cancelsTouchesInView = NO;
    [_contentScrollView addGestureRecognizer:tapGesture];
    
    _preferredRateTextField.delegate = self;
    
    selectedLanguageArr = [[NSMutableArray alloc] init];
    
    _requiredRegularlyLabel.userInteractionEnabled = YES;
    [_requiredRegularlyLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(requiredRegulartlyButtonTapped:)]];
    
    _requiredOccasionallyLabel.userInteractionEnabled = YES;
    [_requiredOccasionallyLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(requiredOccassionalyButtonTapped:)]];
    
    _addYourBioTextView.delegate = self;
    
    if (![[SharedClass sharedInstance] isUserCarer]) {
        _numberOfExperienceStaticLabel.text = @"Experience in years required";
        _bioStaticLabel.text = @"Job Description";
        
        _addYourBioTextView.text = [NSString stringWithFormat:@"Your description should tell the %@ your general requirements",_selectedCareType];
        _languageStaticLabel.text = @"Languages required";
        
    }
    else {
        
        _requiredRegularlyLabel.hidden = YES;
        _requiredRegularlyButton.hidden = YES;
        _requiredOccasionallyLabel.hidden = YES;
        _requiredOcassionalyButton.hidden = YES;
        
        _numberOfExperienceStaticLabelTopConstraint.constant = -20.;
        
        _bioStaticLabel.text = @"Enter Bio";
        _addYourBioTextView.text = [NSString stringWithFormat:@"Your description should tell your story and why you would make a great %@. Be friendly but professional.",_selectedCareType];
        _rateStaticLabel.text = @"Preferred hourly rate required.";
        
    }
    
    _headerLabel.font = [UIFont fontWithName:@"Montserrat-SemiBold" size:(22.5/667)*kScreenHeight];
    
    _bioStaticLabel.font = _rateStaticLabel.font = _numberOfExperienceStaticLabel.font = _languageStaticLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:(17.5/667)*kScreenHeight];
    
    _addYourBioTextView.font = _preferredRateTextField.font = _requiredRegularlyLabel.font = _requiredOccasionallyLabel.font = [UIFont fontWithName:@"Montserrat-Light" size:(17.5/667)*kScreenHeight];
    
    _experienceLabel.font = [UIFont fontWithName:@"Montserrat-Light" size:(17.5/667)*kScreenHeight];
    
    _nextButton.titleLabel.font = _cancelButton.titleLabel.font = [UIFont fontWithName:@"Montserrat-Medium" size:(17.5/667)*kScreenHeight];
    
}

- (void) setupUIForEditingAdvert {
    
    if (_advertDictToBeEdited) {
        
        if (![[_advertDictToBeEdited valueForKey:@"image_path"] isEqualToString:@""]) {
            __weak UIImageView* weakImageView = _profileImgView;
            [_profileImgView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@/%@",WebServiceURL,[_advertDictToBeEdited valueForKey:@"image_path"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
                                                                     cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                                 timeoutInterval:60.0] placeholderImage:[UIImage imageNamed:@"profile_icon"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                
                weakImageView.alpha = 0.0;
                weakImageView.image = image;
                profileImage = image;
                [UIView animateWithDuration:0.25
                                 animations:^{
                                     weakImageView.alpha = 1.0;
                                 }];
            } failure:NULL];
        }
        
        _addYourBioTextView.text = [_advertDictToBeEdited valueForKey:@"about_you"];
        _preferredRateTextField.text = [_advertDictToBeEdited valueForKey:@"pay"];
        
        if ([[_advertDictToBeEdited valueForKey:@"frequency"] isEqualToString:@"Ocassional"]) {
            _requiredOcassionalyButton.selected = YES;
        }
        else {
            _requiredRegularlyButton.selected = YES;
        }
        
        _experienceLabel.text = [NSString stringWithFormat:@"%@ years",[_advertDictToBeEdited valueForKey:@"experience"]];
        
        selectedLanguageArr = [[NSMutableArray alloc] initWithArray:[[_advertDictToBeEdited valueForKey:@"languages"] componentsSeparatedByString:@","]];
        
    }
    else {
        selectedLanguageArr = [[NSMutableArray alloc] initWithObjects:@"English", nil];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if ([identifier isEqualToString:@"showYourAdvertSegue"]) {
        
        if (![[SharedClass sharedInstance] isUserCarer]) {
            if (!_requiredRegularlyButton.isSelected && !_requiredOcassionalyButton.isSelected) {
                [SVProgressHUD showErrorWithStatus:@"Select at least one frequency - Regularly or Occassionally"];
                return NO;
            }
        }
        
        if (selectedLanguageArr.count == 0) {
            [SVProgressHUD showErrorWithStatus:@"Select at least one language to proceed"];
            return NO;
        }
        
    }
    
    return YES;
    
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showYourAdvertSegue"]) {
        
        YourAdvertViewController* controller = (YourAdvertViewController*)[segue destinationViewController];
        controller.advertDetailsDict = [self prepareDictionaryForYourAdvert];
        
        if (_advertDictToBeEdited) {
            controller.isAdvertInEditingMode = YES;
        }
        
    }
    
}

- (NSMutableDictionary *) prepareDictionaryForYourAdvert {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    if (_advertDictToBeEdited) {
        dict = [[NSMutableDictionary alloc] initWithDictionary:_advertDictToBeEdited];
    }
    
    [dict setObject:_selectedCareType forKey:@"care_type"];
    
    if (profileImage) {
        [dict setObject:profileImage forKey:@"image_path"];
    }
    else {
        [dict setObject:@"" forKey:@"image_path"];
    }
    
    [dict setObject:[[SharedClass sharedInstance] filterOutMobileAndEmail:_addYourBioTextView.text] forKey:@"about_you"];
    [dict setObject:_preferredRateTextField.text forKey:@"pay"];
    [dict setObject:[[_experienceLabel.text componentsSeparatedByString:@" "] firstObject] forKey:@"experience"];
    
    if (_requiredRegularlyButton.selected) {
        [dict setObject:@"Regular" forKey:@"frequency"];
    }
    else {
        [dict setObject:@"Occasional" forKey:@"frequency"];
    }
    
    [dict setObject:[selectedLanguageArr componentsJoinedByString:@","] forKey:@"languages"];
    
    NSString* additions = @"";
    for (int i = 0; i<4; i++) {
        CreateAdvertsCollectionViewCell* cell = (CreateAdvertsCollectionViewCell *)[_miscCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (cell.toggleButton.isSelected) {
            if ([additions isEqualToString:@""]) {
                additions = [NSString stringWithFormat:@"%@",cell.titleLabel.text];
            }
            else {
                additions = [NSString stringWithFormat:@"%@,%@",additions,cell.titleLabel.text];
            }
        }
    }
    
    [dict setObject:additions forKey:@"Additionals"];
    
    return dict;
    
    
}


- (IBAction)requiredOccassionalyButtonTapped:(UIButton *)sender {
    _requiredOcassionalyButton.selected = !_requiredOcassionalyButton.isSelected;
    _requiredRegularlyButton.selected = NO;
}

- (IBAction)requiredRegulartlyButtonTapped:(UIButton *)sender {
    _requiredRegularlyButton.selected = !_requiredRegularlyButton.isSelected;
    _requiredOcassionalyButton.selected = NO;
}

- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addLanguagesButtonTapped:(id)sender {
    
    selectLanguageController = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectLanguageViewController"];
    selectLanguageController.view.frame = self.view.bounds;
    selectLanguageController.languageTextField.delegate = self;
    [selectLanguageController.addButton addTarget:self action:@selector(languagePopupAddButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectLanguageController.view];
    
}

- (IBAction)experienceMinusButtonTapped:(id)sender {
    
    int years = [[[_experienceLabel.text componentsSeparatedByString:@" "] firstObject] intValue];
    
    if (years>0) {
        years--;
    }
    _experienceLabel.text = [NSString stringWithFormat:@"%d years",years];
    
}

- (IBAction)experiencePlusButtonTapped:(id)sender {
    
    int years = [[[_experienceLabel.text componentsSeparatedByString:@" "] firstObject] intValue];
    _experienceLabel.text = [NSString stringWithFormat:@"%d years",++years];
    
}

-(void)didTapOnProfileImageButton {
    
    if ([actSheet isVisible]) {
        [actSheet dismissWithClickedButtonIndex:0 animated:YES];
    }
    else {
        [actSheet showInView:self.view];
    }
    
}

- (void) hourlyRateFieldTapped {
    
    [self.view endEditing:YES];
    
    [ActionSheetStringPicker showPickerWithTitle:@"Select Rate" rows:[NSArray arrayWithObjects:@"Negotiable", @"5 to 10 Euro", @"10 to 20 Euro", @"20 to 30 Euro", @"30 to 40 Euro", @"40 to 50 Euro", @"50+ Euro", nil] initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        
        _preferredRateTextField.text = selectedValue;
        
    } cancelBlock:^(ActionSheetStringPicker *picker) {
        
    } origin:self.view];

    
}

- (void) languageTextFieldTapped {
    
    [ActionSheetStringPicker showPickerWithTitle:@"Select Language" rows:[NSArray arrayWithObjects:@"English", @"Irish", @"French", @"German", @"Spanish", @"Italian", @"Afrikaans", @"Arabic", @"Bulgarian", @"Cantonese", @"Chinese(Mandarin)", @"Czech", @"Danish", @"Dutch", @"Estonian", @"Finnish", @"Greek", @"Hebrew", @"Hindi", @"Hungarian", @"Japanese", @"Mandarin", @"Polish", @"Portuguese", @"Punjabi", @"Romanian", @"Russian", @"Sign", @"Slovak", @"Spanish", @"Swedish", @"Tagalog", @"Turkish", @"Urdu", @"Welsh", nil] initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        
        selectLanguageController.languageTextField.text = selectedValue;
        
        
    } cancelBlock:^(ActionSheetStringPicker *picker) {
        
    } origin:self.view];
    
    
}

- (void) languagePopupAddButtonTapped {
    
    if (![selectedLanguageArr containsObject:selectLanguageController.languageTextField.text]) {
        [selectedLanguageArr addObject:selectLanguageController.languageTextField.text];
    }
    
    [_languagesCollectionView reloadData];
    [selectLanguageController hideDrivingLicenseInfo:nil];
    
}

- (void) languageCollectionViewDeleteButtonTapped:(UIButton *)sender {
    
    [selectedLanguageArr removeObjectAtIndex:sender.tag];
    [_languagesCollectionView reloadData];
    
}


#pragma mark - CollectionView Datasource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView == _miscCollectionView) {
        return 4;
    }
    return selectedLanguageArr.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_miscCollectionView == collectionView) {
        static NSString *CellIdentifier = @"CreateAdvertsCollectionViewCell";
        CreateAdvertsCollectionViewCell *cell = (CreateAdvertsCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (cell == nil) {
            // Load the top-level objects from the custom cell XIB.
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CreateAdvertsCollectionViewCell" owner:self options:nil];
            // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
            cell = [topLevelObjects objectAtIndex:0];
        }
        
        [self populateContentForMiscCollectionViewCell:cell atIndexPath:indexPath];
        
        return cell;
    }
    
    static NSString *CellIdentifier = @"ProfileActivitiesCollectionViewCell";
    ProfileActivitiesCollectionViewCell *cell = (ProfileActivitiesCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ProfileActivitiesCollectionViewCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    [self populateContentForCell:cell atIndexPath:indexPath];
    
    return cell;
    
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView == _miscCollectionView) {
        return CGSizeMake((collectionView.frame.size.width) - 50., 30);
    }
    
    return CGSizeMake(100.,44.);
    
}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

#pragma mark - CollectionView Delegates

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


#pragma mark - Populate Content

- (void) populateContentForMiscCollectionViewCell:(CreateAdvertsCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            cell.leadingConstraint.constant = 8;
            cell.trailingConstraint.constant = 0;
            cell.titleLabel.text = @"Accept online payments";
            
            if (_advertDictToBeEdited) {
                if ([[_advertDictToBeEdited valueForKey:@"additionals"] containsString:cell.titleLabel.text]) {
                    cell.toggleButton.selected = YES;
                }
                else {
                    cell.toggleButton.selected = NO;
                }
            }
            
            break;
            
        case 1:
            cell.titleLabel.text = @"Non-smoker";
            cell.leadingConstraint.constant = 8;
            cell.trailingConstraint.constant = 16;
            
            if (_advertDictToBeEdited) {
                if ([[_advertDictToBeEdited valueForKey:@"additionals"] containsString:cell.titleLabel.text]) {
                    cell.toggleButton.selected = YES;
                }
                else {
                    cell.toggleButton.selected = NO;
                }
            }
            
            break;
            
        case 2:
            cell.leadingConstraint.constant = 8;
            cell.trailingConstraint.constant = 0;
            cell.titleLabel.text = @"Have a car";
            
            if (_advertDictToBeEdited) {
                if ([[_advertDictToBeEdited valueForKey:@"additionals"] containsString:cell.titleLabel.text]) {
                    cell.toggleButton.selected = YES;
                }
                else {
                    cell.toggleButton.selected = NO;
                }
            }
            
            break;
            
        case 3:
            cell.leadingConstraint.constant = 8;
            cell.trailingConstraint.constant = 16;
            cell.titleLabel.text = @"Comfortable with pets";
            
            if (_advertDictToBeEdited) {
                if ([[_advertDictToBeEdited valueForKey:@"additionals"] containsString:cell.titleLabel.text]) {
                    cell.toggleButton.selected = YES;
                }
                else {
                    cell.toggleButton.selected = NO;
                }
            }
            
            break;
            
        default:
            break;
    }
    
    cell.titleLabel.textColor = _requiredRegularlyLabel.textColor;
    
    
}

- (void) populateContentForCell:(ProfileActivitiesCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.activityLabel.text = [selectedLanguageArr objectAtIndex:indexPath.row];
    cell.deleteButton.tag = indexPath.row;
    [cell.deleteButton addTarget:self action:@selector(languageCollectionViewDeleteButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    cell.activityLabel.textColor = _requiredRegularlyLabel.textColor;
    
}

- (void) dismissKeyboard {
    
    [self.view endEditing:YES];
    
}

#pragma mark - Profile Image Change

- (void) setupActionSheet {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        actSheet = [[UIActionSheet alloc] initWithTitle:nil
                                               delegate:self
                                      cancelButtonTitle:@"Cancel"
                                 destructiveButtonTitle:nil
                                      otherButtonTitles:@"Photo Library", nil];
    }
    else {
        actSheet = [[UIActionSheet alloc] initWithTitle:nil
                                               delegate:self
                                      cancelButtonTitle:@"Cancel"
                                 destructiveButtonTitle:nil
                                      otherButtonTitles:@"Photo Library", @"Camera", nil];
    }
    
}



- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (actionSheet == actSheet) {
        //FLOG(@"Button %d", buttonIndex);
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            
            switch (buttonIndex) {
                    
                case 0:
                {
                    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
                    imgPicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
                    imgPicker.delegate = self;
                    [self presentViewController:imgPicker animated:YES completion:nil];
                    break;
                }
                    
                default:
                    
                    break;
            }
            
        }
        else {
            
            switch (buttonIndex) {
                    
                case 0:
                {
                    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
                    imgPicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
                    imgPicker.delegate = self;
                    [self presentViewController:imgPicker animated:YES completion:nil];
                    break;
                }
                    
                case 1:
                {
                    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
                    imgPicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
                    imgPicker.delegate = self;
                    [self presentViewController:imgPicker animated:YES completion:nil];
                    break;
                }
                    
                default:
                    
                    break;
            }
            
        }
        
        
        
        
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image1 = info[UIImagePickerControllerOriginalImage];
    [_profileImgView setImage:image1];
    
    //    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //
    //        [self openEditor:nil];
    //
    //    } else {
    [picker dismissViewControllerAnimated:YES completion:^{
        [self openEditor:nil];
    }];
    //    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - PECropViewControllerDelegate methods

-(void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage {
    
    [_profileImgView setImage:croppedImage];
    profileImage = croppedImage;
    
    [controller dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // [self updateEditButtonEnabled];
    }
    
    [controller dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - Action methods
//#GD: 2015_0318 added method to crop the profile pic
- (IBAction)openEditor:(id)sender
{
    PECropViewController *controller = [[PECropViewController alloc] init];
    controller.delegate = self;
    controller.image = _profileImgView.image;
    
    UIImage *image = _profileImgView.image;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat length = MIN(width, height);
    controller.imageCropRect = CGRectMake((width - length) / 2,
                                          (height - length) / 2,
                                          length,
                                          length);
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    
    [self presentViewController:navigationController animated:YES completion:NULL];
    
    
}

#pragma mark - UITextField Delegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == _preferredRateTextField) {
        [self hourlyRateFieldTapped];
        return NO;
    }
    if (textField == selectLanguageController.languageTextField) {
        [self languageTextFieldTapped];
        return NO;
    }
    
    return YES;
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    if (textView == _addYourBioTextView && ([textView.text containsString:@"Experienced flexible mature minder needed to work 3 full days a week"] || [textView.text containsString:@"Your description should tell"])) {
        textView.text = @"";
    }
    
    return YES;
    
}

@end
