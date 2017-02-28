//
//  ViewController.m
//  LicenseIOSAppByNamedUser_ObjC
//
//  Created by maklMac on 2/28/17.
//  Copyright © 2017 esrichina.com. All rights reserved.
//

#import "LicenseiOSAppViewController.h"
#import "LoginViewController.h"
#import <ArcGIS/ArcGIS.h>

@interface LicenseiOSAppViewController ()

@property (weak, nonatomic) IBOutlet AGSMapView *mapView;

@property (nonatomic, strong) AGSMap *map;

@property (weak, nonatomic) IBOutlet UIVisualEffectView *saveAsBlurView;


@property (weak, nonatomic) IBOutlet UIToolbar *savingToolbar;

@property(strong,nonatomic) LoginViewController* loginVC;

@property(strong,nonatomic)AGSPortal* portal;



@end

@implementation LicenseiOSAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.map = [[AGSMap alloc] initWithBasemap:[AGSBasemap topographicBasemap]];

    self.mapView.map = self.map;
    
    self.saveAsBlurView.hidden = true;
}

-(void)loginPortalwithName:(NSString *)name key:(NSString *)key{
    
    self.portal = [AGSPortal portalWithURL:[NSURL URLWithString:@"https://www.arcgis.com"] loginRequired:true];
    
    self.portal.credential = [AGSCredential credentialWithUser:name password:key];
    
    [self.portal loadWithCompletion:^(NSError * error){
        
        if (error != nil) {
            
            NSLog(@"Login portal failed: @%@",error);
            
        }else{
            
            NSLog(@"portal login succeed!");
            AGSLicenseInfo* licenseInfo = self.portal.portalInfo.licenseInfo;
            
            @try{
                NSError* err;
                [AGSArcGISRuntimeEnvironment setLicenseInfo:licenseInfo error:&err];
                
            }
            @catch(NSError* error) {
                
                NSLog(@"error:@%@",error);
            }
            
            NSDictionary *licenseDictionary;
            
            @try{
                NSError* err;
                licenseDictionary = [licenseInfo toJSON:&err];
                
            }
            @catch(NSError* error) {
                
                NSLog(@"LicenseInfo not available, error:@%@",error);
            }

            AGSKeychainItem *keychainItem = [[AGSKeychainItem alloc] initWithIdentifier:@"maklesri.LicenseIOSAppByNamedUser" accessGroup:nil acrossDevices:false];
            
            [keychainItem writeObjectToKeychain:licenseDictionary completion:^(NSError * wirteError){
                if(wirteError){
                    NSLog(@"Error writing to the keychain...@%@",wirteError);
                }
            }];
        }
    }];
    
}

//MARK: - Actions
- (IBAction)ActivateLicense:(id)sender {
    
    [self toggleLoginView];
}


//MARK: - hide/show input screen
-(void)toggleLoginView{
    
    self.saveAsBlurView.hidden = !self.saveAsBlurView.hidden;
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    self.loginVC = [segue destinationViewController];
    
    self.loginVC.delegate = self;
}

 //MARK: - LoginVCDelegate
-(void)loginViewController:(LoginViewController*)LoginViewController didInitiateLoginWithName:(NSString *)name key:(NSString*)key{
    
    [self loginPortalwithName:name key:key];
    
    [self toggleLoginView];
    
    
}

-(void)loginViewControllerDidCancel:(LoginViewController*)LoginViewController{
    [self toggleLoginView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
