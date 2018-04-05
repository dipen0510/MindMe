//
//  ChatViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 19/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "ChatViewController.h"
#import <Quickblox/Quickblox.h>
#import "UIColor+QM.h"
#import "UIImage+QM.h"
#import "UIImage+fixOrientation.h"
#import "AdsDetailViewController.h"

@interface ChatViewController ()

@end

NS_ENUM(NSUInteger, QMMessageType) {
    
    QMMessageTypeText = 0,
    QMMessageTypeCreateGroupDialog = 1,
    QMMessageTypeUpdateGroupDialog = 2,
    
    QMMessageTypeContactRequest = 4,
    QMMessageTypeAcceptContactRequest,
    QMMessageTypeRejectContactRequest,
    QMMessageTypeDeleteContactRequest
};

@implementation ChatViewController

- (NSTimeInterval)timeIntervalBetweenSections {
    return 300.0f;
}

- (CGFloat)heightForSectionHeader {
    return 40.0f;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    
    self.senderID = [[_chatInfoDict valueForKey:@"from"] intValue];
    
    if (!_isSentMessage) {
        self.senderID = [[_chatInfoDict valueForKey:@"Userid"] intValue];
    }
    
    self.senderDisplayName = [NSString stringWithFormat:@"%@ %@.",[_chatInfoDict valueForKey:@"first_name"],[[_chatInfoDict valueForKey:@"second_name"] substringToIndex:1]];
    self.title = @"Chat";
    
    senderImgUrlStr = @"";
    receiverImgUrlStr = @"";
    if (![[_chatInfoDict valueForKey:@"image_path"] isEqual:[NSNull null]]) {
        if (![[_chatInfoDict valueForKey:@"image_path"] isEqualToString:@""]) {
            senderImgUrlStr = [_chatInfoDict valueForKey:@"image_path"];
        }
    }

    
    [QBSettings setAuthKey:@"xxx"];
    [QBSettings setAccountKey:@"xxx"];
    
    // Create test data source
//    QBChatMessage *message1 = [QBChatMessage message];
//    message1.senderID = QMMessageTypeContactRequest;
//    message1.text = @"IGNALY\nwould like to chat with you";
//    message1.dateSent = [NSDate dateWithTimeInterval:-12.0f sinceDate:[NSDate date]];
    //
//    QBChatMessage *message2 = [QBChatMessage message];
//    message2.senderID = self.senderID;
//    message2.text = @"Why Q-municate is a right choice?";
//    message2.dateSent = [NSDate dateWithTimeInterval:-9.0f sinceDate:[NSDate date]];
//    //
//    QBChatMessage *message3 = [QBChatMessage message];
//    message3.senderID = 20001;
//    message3.text = @"Q-municate comes with powerful instant messaging right out of the box. Powered by the flexible XMPP protocol and Quickblox signalling technologies, with compatibility for server-side chat history, group chats, attachments and user avatars, it's pretty powerful. It also has chat bubbles and user presence (online/offline).";
//    message3.dateSent = [NSDate dateWithTimeInterval:-6.0f sinceDate:[NSDate date]];
//    // message with an attachment
//    QBChatMessage *message4 = [QBChatMessage message];
//    message4.ID = @"4";
//    message4.senderID = 20001;
    
//    QBChatAttachment *attachment = [QBChatAttachment new];
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"quickblox-image" ofType:@"png"];
//    attachment.url = imagePath;
//    message4.attachments = @[attachment];
//    message4.dateSent = [NSDate dateWithTimeInterval:-3.0f sinceDate:[NSDate date]];
    
//    [self.chatDataSource addMessages:@[message2, message3]];
    
    [self startGetMessageService];
    
}

#pragma mark Tool bar Actions

- (void)didPressSendButton:(UIButton *)button
           withMessageText:(NSString *)text
                  senderId:(NSUInteger)senderId
         senderDisplayName:(NSString *)senderDisplayName
                      date:(NSDate *)date {
//    
    QBChatMessage *message = [QBChatMessage message];
    message.text = text;
    message.senderID = senderId;
    message.dateSent = [NSDate date];
    
    [self.chatDataSource addMessage:message];
    
    [self finishSendingMessageAnimated:YES];
    
    [self startSendMessageServiceForMessage:text];
    [self startUpdateMessageStatusServiceWhileSendingMessage];
    
}

- (void)didPickAttachmentImage:(UIImage *)image {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *resizedImage = [self resizedImageFromImage:[image fixOrientation]];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
        
        NSData *binaryImageData = UIImagePNGRepresentation(resizedImage);
        NSString *imageName = [NSString stringWithFormat:@"%f-attachment.png", [[NSDate date] timeIntervalSince1970]];
        NSString *imagePath = [basePath stringByAppendingPathComponent:imageName];
        
        [binaryImageData writeToFile:imagePath atomically:YES];
        
        QBChatMessage* message = [QBChatMessage new];
        message.senderID = self.senderID;
        
        QBChatAttachment *attacment = [[QBChatAttachment alloc] init];
        attacment.url = imagePath;
        
        message.attachments = @[attacment];
        
        [self.chatDataSource addMessage:message];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self finishSendingMessageAnimated:YES];
        });
    });
}


- (Class)viewClassForItem:(QBChatMessage *)item {
    
    if (item.senderID == QMMessageTypeContactRequest) {
        
        if (item.senderID != self.senderID) {
            
            return [QMChatContactRequestCell class];
        }
    }
    
    else if (item.senderID == QMMessageTypeRejectContactRequest) {
        
        return [QMChatNotificationCell class];
    }
    
    else if (item.senderID == QMMessageTypeAcceptContactRequest) {
        
        return [QMChatNotificationCell class];
    }
    else {
        
        if (item.senderID != self.senderID) {
            if ((item.attachments != nil && item.attachments.count > 0)) {
                return [QMChatAttachmentIncomingCell class];
            } else {
                return [QMChatIncomingCell class];
            }
        } else {
            if ((item.attachments != nil && item.attachments.count > 0)) {
                return [QMChatAttachmentOutgoingCell class];
            } else {
                return [QMChatOutgoingCell class];
            }
        }
    }
    
    return nil;
}

- (CGSize)collectionView:(QMChatCollectionView *)collectionView dynamicSizeAtIndexPath:(NSIndexPath *)indexPath maxWidth:(CGFloat)maxWidth {
    
    QBChatMessage *item = [self.chatDataSource messageForIndexPath:indexPath];
    Class viewClass = [self viewClassForItem:item];
    CGSize size;
    
    if (viewClass == [QMChatAttachmentIncomingCell class] || viewClass == [QMChatAttachmentOutgoingCell class]) {
        size = CGSizeMake(MIN(200, maxWidth), 200);
    } else {
        NSAttributedString *attributedString = [self attributedStringForItem:item];
        
        size = [TTTAttributedLabel sizeThatFitsAttributedString:attributedString
                                                withConstraints:CGSizeMake(maxWidth, MAXFLOAT)
                                         limitedToNumberOfLines:0];
    }
    
    if (viewClass == [QMChatOutgoingCell class] && size.width < 50) {
        
        if (size.width>30) {
            size.width = size.width + 25;
        }
        else {
            size.width = size.width + 45;
        }
        
    }
    
    return size;
}

- (CGFloat)collectionView:(QMChatCollectionView *)collectionView minWidthAtIndexPath:(NSIndexPath *)indexPath {
    
    QBChatMessage *item = [self.chatDataSource messageForIndexPath:indexPath];
    
    CGSize size;
    
    if (item != nil) {
        
        NSAttributedString *attributedString =
        [item senderID] == self.senderID ?  [self bottomLabelAttributedStringForItem:item] : [self topLabelAttributedStringForItem:item];
        
        size = [TTTAttributedLabel sizeThatFitsAttributedString:attributedString
                                                withConstraints:CGSizeMake(1000, 10000)
                                         limitedToNumberOfLines:1];
    }
    
    return size.width;
}

- (void)collectionView:(QMChatCollectionView *)collectionView configureCell:(UICollectionViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    QBChatMessage* message = [self.chatDataSource messageForIndexPath:indexPath];
    
    if ([cell conformsToProtocol:@protocol(QMChatAttachmentCell)]) {
        
        if (message.attachments != nil) {
            QBChatAttachment* attachment = message.attachments.firstObject;
            NSData *imageData = [NSData dataWithContentsOfFile:attachment.url];
            [(UICollectionViewCell<QMChatAttachmentCell> *)cell setAttachmentImage:[UIImage imageWithData:imageData]];
            
            [cell updateConstraints];
        }
    }
    
    QMChatCell* cell1 = (QMChatCell *)cell;
    
    NSString* avatarImgStr = @"";
    
    if (message.senderID == [[_chatInfoDict valueForKey:@"from"] intValue]) {
        avatarImgStr = senderImgUrlStr;
    }
    else {
        avatarImgStr = receiverImgUrlStr;
    }
    
    if ([cell1 isKindOfClass:[QMChatOutgoingCell class]]) {
        
        switch (message.recipientID) {
                
            case 0:
                ((QMChatOutgoingCell*)cell1).statusImgView.image = [UIImage imageNamed:@"singleTick"];
                break;
                
            case 1:
                ((QMChatOutgoingCell*)cell1).statusImgView.image = [UIImage imageNamed:@"blackDoubleTick"];
                break;
                
            case 2:
                ((QMChatOutgoingCell*)cell1).statusImgView.image = [UIImage imageNamed:@"greenDoubleTick"];
                break;
                
            default:
                ((QMChatOutgoingCell*)cell1).statusImgView.image = [UIImage imageNamed:@"block"];
                break;
                
        }
        
    }
    
    __weak UIImageView* weakImageView = cell1.avatarView;
    [cell1.avatarView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@/%@",WebServiceURL,avatarImgStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
                                                              cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                          timeoutInterval:60.0] placeholderImage:[UIImage imageNamed:@"profile_icon"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        weakImageView.alpha = 0.0;
        weakImageView.image = image;
        [UIView animateWithDuration:0.25
                         animations:^{
                             weakImageView.alpha = 1.0;
                         }];
    } failure:NULL];
    
    cell1.avatarView.layer.cornerRadius = cell1.avatarView.frame.size.height/2.;
    cell1.avatarView.layer.masksToBounds = YES;
    
    
    
    [super collectionView:collectionView configureCell:cell forIndexPath:indexPath];
}

- (QMChatCellLayoutModel)collectionView:(QMChatCollectionView *)collectionView layoutModelAtIndexPath:(NSIndexPath *)indexPath {
    
    QMChatCellLayoutModel layoutModel = [super collectionView:collectionView layoutModelAtIndexPath:indexPath];
    QBChatMessage *item = [self.chatDataSource messageForIndexPath:indexPath];
    
    layoutModel.avatarSize = CGSizeMake(35.0f, 35.0f);
    
    if (item!= nil) {
        
        NSAttributedString *topLabelString = [self topLabelAttributedStringForItem:item];
        CGSize size = [TTTAttributedLabel sizeThatFitsAttributedString:topLabelString
                                                       withConstraints:CGSizeMake(CGRectGetWidth(self.collectionView.frame), CGFLOAT_MAX)
                                                limitedToNumberOfLines:1];
        layoutModel.topLabelHeight = size.height;
    }
    
    return layoutModel;
}

- (NSAttributedString *)attributedStringForItem:(QBChatMessage *)messageItem {
    
    UIColor *textColor = [messageItem senderID] == self.senderID ? [UIColor colorWithWhite:0.290 alpha:1.000] : [UIColor colorWithWhite:0.290 alpha:1.000];
    UIFont *font = [UIFont fontWithName:@"Montserrat-Light" size:14];
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName : textColor,
                                 NSFontAttributeName : font};
    
    NSMutableAttributedString *attrStr;
    
    if ([messageItem.text length] > 0) {
        
        attrStr = [[NSMutableAttributedString alloc] initWithString:messageItem.text attributes:attributes];
    }
    
    return attrStr;
}

- (NSAttributedString *)topLabelAttributedStringForItem:(QBChatMessage *)messageItem {
    
    UIFont *font = [UIFont fontWithName:@"Montserrat-Light" size:12];
    
    if ([messageItem senderID] == self.senderID) {
        return nil;
    }
    
    NSDictionary *attributes = @{ NSForegroundColorAttributeName:[UIColor colorWithRed:0.184 green:0.467 blue:0.733 alpha:1.000], NSFontAttributeName:font};
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@.",[_chatInfoDict valueForKey:@"first_name"],[[_chatInfoDict valueForKey:@"second_name"] substringToIndex:1]] attributes:attributes];
    
    return attrStr;
}

- (NSAttributedString *)bottomLabelAttributedStringForItem:(QBChatMessage *)messageItem {
    
    UIColor *textColor = [messageItem senderID] == self.senderID ? [UIColor colorWithWhite:0.000 alpha:0.490] : [UIColor colorWithWhite:0.000 alpha:0.490];
    UIFont *font = [UIFont fontWithName:@"Montserrat-Light" size:12];
    
    NSDictionary *attributes = @{ NSForegroundColorAttributeName:textColor, NSFontAttributeName:font};
    NSMutableAttributedString *attrStr =
    [[NSMutableAttributedString alloc] initWithString:[self timeStampWithDate:messageItem.dateSent]
                                           attributes:attributes];
    
    return attrStr;
}

- (NSString *)timeStampWithDate:(NSDate *)date {
    
    static NSDateFormatter *dateFormatter = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"HH:mm";
    });
    
    NSString *timeStamp = [dateFormatter stringFromDate:date];
    
    return timeStamp;
}

- (UIImage *)resizedImageFromImage:(UIImage *)image
{
    CGFloat largestSide = image.size.width > image.size.height ? image.size.width : image.size.height;
    CGFloat scaleCoefficient = largestSide / 560.0f;
    CGSize newSize = CGSizeMake(image.size.width / scaleCoefficient, image.size.height / scaleCoefficient);
    
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:(CGRect){0, 0, newSize.width, newSize.height}];
    UIImage* resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resizedImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - API Helpers

- (void) startGetMessageService {
    
    [SVProgressHUD showWithStatus:@"Refreshing List"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = GetAllConversations;
    manager.delegate = self;
    
    if (_isSentMessage) {
        [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForGetSentMessage]];
    }
    else {
        [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForGetInboxMessage]];
    }
    
    
}

- (void) startSendMessageServiceForMessage:(NSString *)message {
    
//    [SVProgressHUD showWithStatus:@"Sending Message"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = SendMessage;
    manager.delegate = nil;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForSendMesssage:message]];
    
}

- (void) startGetSingleAdvertDetailsService {
    
    [SVProgressHUD showWithStatus:@"Fetching details"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = GetSingleAdvertDetails;
    manager.delegate = self;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForGetSingleAdvertDetails]];
    
}

- (void) startUpdateMessageStatusService {
    
    //    [SVProgressHUD showWithStatus:@"Sending Message"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = UpdateStatus;
    manager.delegate = nil;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForUpdateMessageStatus]];
    
}

- (void) startUpdateMessageStatusServiceWhileSendingMessage {
    
    //    [SVProgressHUD showWithStatus:@"Sending Message"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = UpdateStatus;
    manager.delegate = nil;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForUpdateMessageStatusWhileSendingMessage]];
    
}


#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    if ([requestServiceKey isEqualToString:GetAllConversations]) {
        
        [SVProgressHUD showSuccessWithStatus:@"List refreshed successfully"];
        
        if ([[responseData valueForKey:@"message"] isKindOfClass:[NSArray class]]) {
            
            messagesArr = [[NSMutableArray alloc] initWithArray:[responseData valueForKey:@"message"]];
            [self setupMessageDataSource];
            
            [self startUpdateMessageStatusService];
            
        }
        
//        [_listTableView reloadData];
        
    }
    if ([requestServiceKey isEqualToString:SendMessage]) {
        
        [SVProgressHUD showSuccessWithStatus:@"Message sent successfully"];
        [self startGetMessageService];
        
    }
    
    if ([requestServiceKey isEqualToString:GetSingleAdvertDetails]) {
        
        [SVProgressHUD showSuccessWithStatus:@"Details fetched successfully"];
        
        if (((NSMutableArray *)[responseData valueForKey:@"message"]).count>0) {
            selectedAdvertDict = [[NSMutableDictionary alloc] initWithDictionary:[[responseData valueForKey:@"message"] objectAtIndex:0]];
            
            if ([[SharedClass sharedInstance] isUserCarer]) {
                [self performSegueWithIdentifier:@"showAdsDetailSegue" sender:nil];
            }
            else {
                [self performSegueWithIdentifier:@"showParentAdsDetailSegue" sender:nil];
            }
        }
        else {
            [SVProgressHUD showErrorWithStatus:@"No details found."];
        }
        
        
    }
    
}


- (void) didFinishServiceWithFailure:(NSString *)errorMsg {
    
    
    [SVProgressHUD dismiss];
    
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:nil
                                                  message:NSLocalizedString(@"An issue occured while processing your request. Please try again later.", nil)
                                                 delegate:self
                                        cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                        otherButtonTitles: nil];
    
    if (![errorMsg isEqualToString:@""]) {
        [alert setMessage:errorMsg];
    }
    
    if ([errorMsg isEqualToString:NSLocalizedString(@"Verify your internet connection and try again", nil)]) {
        [alert setTitle:NSLocalizedString(@"Connection unsuccessful", nil)];
    }
    
    [alert show];
    
    return;
    
}




#pragma mark - Modalobject

- (NSMutableDictionary *) prepareDictionaryForGetInboxMessage {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        [dict setObject:[_chatInfoDict valueForKey:@"sender_profile_id"] forKey:@"parent_advert_id"];
        [dict setObject:[_chatInfoDict valueForKey:@"refer_id"] forKey:@"carer_advert_id"];
        [dict setObject:[_chatInfoDict valueForKey:@"Userid"] forKey:@"carer_id"];
        [dict setObject:[_chatInfoDict valueForKey:@"from"] forKey:@"parent_id"];
    }
    else {
        [dict setObject:[_chatInfoDict valueForKey:@"refer_id"] forKey:@"parent_advert_id"];
        [dict setObject:[_chatInfoDict valueForKey:@"sender_profile_id"] forKey:@"carer_advert_id"];
        [dict setObject:[_chatInfoDict valueForKey:@"from"] forKey:@"carer_id"];
        [dict setObject:[_chatInfoDict valueForKey:@"Userid"] forKey:@"parent_id"];
    }
    
    return dict;
    
}

- (NSMutableDictionary *) prepareDictionaryForGetSentMessage {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    if (![[SharedClass sharedInstance] isUserCarer]) {
        [dict setObject:[_chatInfoDict valueForKey:@"sender_profile_id"] forKey:@"parent_advert_id"];
        [dict setObject:[_chatInfoDict valueForKey:@"refer_id"] forKey:@"carer_advert_id"];
        [dict setObject:[_chatInfoDict valueForKey:@"Userid"] forKey:@"carer_id"];
        [dict setObject:[_chatInfoDict valueForKey:@"from"] forKey:@"parent_id"];
    }
    else {
        [dict setObject:[_chatInfoDict valueForKey:@"refer_id"] forKey:@"parent_advert_id"];
        [dict setObject:[_chatInfoDict valueForKey:@"sender_profile_id"] forKey:@"carer_advert_id"];
        [dict setObject:[_chatInfoDict valueForKey:@"from"] forKey:@"carer_id"];
        [dict setObject:[_chatInfoDict valueForKey:@"Userid"] forKey:@"parent_id"];
    }
    
    return dict;
    
}

- (NSMutableDictionary *) prepareDictionaryForSendMesssage:(NSString *)message {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        [dict setObject:@"carer" forKey:@"user_type"];
        if (_isSentMessage) {
            [dict setObject:[_chatInfoDict valueForKey:@"refer_id"] forKey:@"refer_id"];
            [dict setObject:[_chatInfoDict valueForKey:@"sender_profile_id"] forKey:@"sender_profile_id"];
            [dict setObject:[_chatInfoDict valueForKey:@"Userid"] forKey:@"Userid"];
            [dict setObject:[NSString stringWithFormat:@"%@",[[SharedClass sharedInstance] userId]] forKey:@"from"];
        }
        else {
            [dict setObject:[_chatInfoDict valueForKey:@"sender_profile_id"] forKey:@"refer_id"];
            [dict setObject:[_chatInfoDict valueForKey:@"refer_id"] forKey:@"sender_profile_id"];
            [dict setObject:[_chatInfoDict valueForKey:@"from"] forKey:@"Userid"];
            [dict setObject:[NSString stringWithFormat:@"%@",[[SharedClass sharedInstance] userId]] forKey:@"from"];
        }

    }
    else {
        [dict setObject:@"parent" forKey:@"user_type"];
        if (_isSentMessage) {
            [dict setObject:[_chatInfoDict valueForKey:@"refer_id"] forKey:@"refer_id"];
            [dict setObject:[_chatInfoDict valueForKey:@"sender_profile_id"] forKey:@"sender_profile_id"];
            [dict setObject:[_chatInfoDict valueForKey:@"Userid"] forKey:@"Userid"];
            [dict setObject:[NSString stringWithFormat:@"%@",[[SharedClass sharedInstance] userId]] forKey:@"from"];
        }
        else {
            [dict setObject:[_chatInfoDict valueForKey:@"sender_profile_id"] forKey:@"refer_id"];
            [dict setObject:[_chatInfoDict valueForKey:@"refer_id"] forKey:@"sender_profile_id"];
            [dict setObject:[_chatInfoDict valueForKey:@"from"] forKey:@"Userid"];
            [dict setObject:[NSString stringWithFormat:@"%@",[[SharedClass sharedInstance] userId]] forKey:@"from"];
        }

    }
    
    [dict setObject:message forKey:@"message"];
    [dict setObject:[_chatInfoDict valueForKey:@"message_title"] forKey:@"message_title"];
    
    
    return dict;
    
}

- (NSMutableDictionary *) prepareDictionaryForUpdateMessageStatus {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    NSMutableArray* tmpArr = [[NSMutableArray alloc] init];
    
    for (NSDictionary* msg in messagesArr) {
        if ([[msg valueForKey:@"from"] intValue]!=self.senderID && [[msg valueForKey:@"status"] isEqualToString:@"0"]) {
            [tmpArr addObject:[msg valueForKey:@"ID"]];
        }
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tmpArr options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    if (![[SharedClass sharedInstance] isUserCarer]) {
        [dict setObject:jsonString forKey:@"parent"];
        [dict setObject:@"[]" forKey:@"carer"];
    }
    else {
        [dict setObject:@"[]" forKey:@"parent"];
        [dict setObject:jsonString forKey:@"carer"];
    }
    
    [dict setObject:[NSNumber numberWithInt:1] forKey:@"status"];
    
    return dict;
    
}

- (NSMutableDictionary *) prepareDictionaryForUpdateMessageStatusWhileSendingMessage {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    NSMutableArray* tmpArr = [[NSMutableArray alloc] init];
    
    for (NSDictionary* msg in messagesArr) {
        if ([[msg valueForKey:@"from"] intValue]!=self.senderID && ([[msg valueForKey:@"status"] isEqualToString:@"0"] || [[msg valueForKey:@"status"] isEqualToString:@"1"])) {
            [tmpArr addObject:[msg valueForKey:@"ID"]];
        }
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tmpArr options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    if (![[SharedClass sharedInstance] isUserCarer]) {
        [dict setObject:jsonString forKey:@"parent"];
        [dict setObject:@"[]" forKey:@"carer"];
    }
    else {
        [dict setObject:@"[]" forKey:@"parent"];
        [dict setObject:jsonString forKey:@"carer"];
    }
    
    [dict setObject:[NSNumber numberWithInt:2] forKey:@"status"];
    
    return dict;
    
}


- (NSMutableDictionary *) prepareDictionaryForGetSingleAdvertDetails {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    if (![[SharedClass sharedInstance] isUserCarer]) {
        [dict setObject:@"carer" forKey:@"flag"];
        
    }
    else {
        [dict setObject:@"parent" forKey:@"flag"];
        
    }
    
    if (_isSentMessage) {
        [dict setObject:[_chatInfoDict valueForKey:@"refer_id"] forKey:@"ad_id"];
    }
    else {
        [dict setObject:[_chatInfoDict valueForKey:@"sender_profile_id"] forKey:@"ad_id"];
    }
    
    
    return dict;
    
}

- (void) setupMessageDataSource {
    
    [self.chatDataSource deleteMessages:[self.chatDataSource allMessages]];
    
    for (NSMutableDictionary* dict in messagesArr) {
        
        QBChatMessage *message = [QBChatMessage message];
        message.text = [dict valueForKey:@"message1"];
        message.senderID = [[dict valueForKey:@"from"] intValue];
        
        message.recipientID = [[dict valueForKey:@"status"] intValue]; //For delivery status
        
        NSDateFormatter* dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate* date = [dateformatter dateFromString:[dict valueForKey:@"created"]];
        
        message.dateSent = date;
        
        [self.chatDataSource addMessage:message];
        
        if (message.senderID==self.senderID) {
            if (![[dict valueForKey:@"image_path"] isEqual:[NSNull null]]) {
                if (![[dict valueForKey:@"image_path"] isEqualToString:@""]) {
                    receiverImgUrlStr = [dict valueForKey:@"image_path"];
                }
            }
        }
        
    }
    
}


- (IBAction)viewAdvertsButtonTapped:(id)sender {
    
    [self startGetSingleAdvertDetailsService];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showAdsDetailSegue"] || [segue.identifier isEqualToString:@"showParentAdsDetailSegue"]) {
        
        AdsDetailViewController* controller = (AdsDetailViewController *)[segue destinationViewController];
        controller.advertDict = selectedAdvertDict;
        
    }
    
}

@end
