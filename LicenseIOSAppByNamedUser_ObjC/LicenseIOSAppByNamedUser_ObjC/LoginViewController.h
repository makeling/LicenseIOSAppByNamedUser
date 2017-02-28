//
//  LoginViewController.h
//  LicenseIOSAppByNamedUser_ObjC
//
//  Created by maklMac on 2/28/17.
//  Copyright © 2017 esrichina.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginVCDelegate;

@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property(weak,nonatomic) id<LoginVCDelegate> delegate;

@end

@protocol LoginVCDelegate <NSObject>

-(void)loginViewController:(LoginViewController*)LoginViewController didInitiateLoginWithName:(NSString *)name key:(NSString*)key;

-(void)loginViewControllerDidCancel:(LoginViewController*)LoginViewController;



@end
