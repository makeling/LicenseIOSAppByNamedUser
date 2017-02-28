//
//  LoginViewController.m
//  LicenseIOSAppByNamedUser_ObjC
//
//  Created by maklMac on 2/28/17.
//  Copyright © 2017 esrichina.com. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *keyTextField;


@end


@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self resetInputFields];
    
    self.nameTextField.delegate = self;
    self.keyTextField.delegate = self;
    
}



-(void)resetInputFields{
    
    self.nameTextField.text = @"";
    self.keyTextField.text = @"";
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    BOOL result = [textField resignFirstResponder];
    
    return result;
}

//MARK: - Actions
- (IBAction)cancelAction:(id)sender {
    
    [self resetInputFields];
    [self.delegate loginViewControllerDidCancel:self];
}

- (IBAction)saveAction:(id)sender {
    
    NSString* name = self.nameTextField.text;
    NSString* key = self.keyTextField.text;
    
    [self.delegate loginViewController:self didInitiateLoginWithName:name key:key];
    
    [self resetInputFields];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
