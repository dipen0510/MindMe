//
//  Settings.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 21/12/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#ifndef Settings_h
#define Settings_h

#define WebServiceURL @"https://mindme.ie/appapi"
#define WebServiceImageURL @"https://mindme.ie"

#define HomeAdvertsBaseURL @"http://mindmecare.com/appapi"

#define StripeBaseURL @"https://api.stripe.com/v1"

#define StripeSubscriptionKey @"subscriptions"
#define StripeGetSubscriptionKey @"getsubscriptions"
#define StripeCustomerKey @"customers"

#define RegisterServiceKey @"index.php/auth/register"
#define FBRegisterServiceKey @"index.php/auth/registerfb"
#define LoginServiceKey @"auth/login"
#define FBLoginServiceKey @"auth/loginfb"

#define UpdateParentPersonalDetails @"auth/updateParent"
#define UpdateCarerPersonalDetails @"auth/updatecarer"
#define GetUserPersonalDetails @"GetUserDetails"
#define ForgotPasswordKey @"auth/forgotPassword"
#define ChangePasswordKey @"auth/changePassword"
#define GetPostedAdverts @"profile/getProfileDetails"
#define ToggleAdvertActive @"index.php/profile/toggleProfileDets"
#define DeleteAdvert @"profile/delProfileDetails"
#define AddCarerAdvert @"profile/updateCarerProfileDetails"
#define AddParentAdvert @"advert/updateParentProfileDetails"
#define GetAllHomeAdverts @"fetchAll_profile"
#define ContactUs @"emailManage/contactUs"
#define IncrementAdvertViews @"profile/incrementview"
#define GetSubscriptions @"subscribe/getallsubscriptions"
#define GetVouchers @"subscribe/getallvouchers"
#define PostSubscriptionReceipt @"subscribe/dosubscribe"
#define GetFavoriteAdverts @"advert/getLikedAdvert"
#define LikeDislikeAdvert @"likeOrDislike/savelikeordislike"
#define CheckLikedDisliked @"likeOrDislike/checkLikeOrDislike"
#define ReviewAdvert @"likeOrDislike/saveReviewByParent"
#define GetAllReviews @"likeOrDislike/getallreview"

#define SendMessage @"conversations/sendsms"
#define GetAllMessageList @"conversations/index"
#define ArchiveMessage @"conversations/archive"
#define GetAllConversations @"conversations/getAllMessagesInConversations"
#define GetUnreadMessageCount @"conversations/total_count"
#define UpdateStatus @"conversations/statusupdate"

#define GetSingleAdvertDetails @"advert/getDetailsOfSingleAdvert"
#define DowngradeAccount @"auth/downgradeRequest"
#define DeleteAccount @"auth/accountDeactivate"

#define SendOTP @"ValidatePhone/send_sms"
#define VerifyOTP @"ValidatePhone/verify_code"

#define GoogleAPIGeocode @"GoogleAPIGeocode"
#define GoogleAPIAddressGeocode @"GoogleAPIAddressGeocode"

#endif /* Settings_h */
