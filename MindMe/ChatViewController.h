//
//  ChatViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 19/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QMChatViewController.h"

@interface ChatViewController : QMChatViewController <DataSyncManagerDelegate> {
    NSMutableArray* messagesArr;
    NSString* senderImgUrlStr;
    NSString* receiverImgUrlStr;
}

@property BOOL isSentMessage;
@property (strong, nonatomic) NSMutableDictionary* chatInfoDict;

- (IBAction)backButtonTapped:(id)sender;

@end
