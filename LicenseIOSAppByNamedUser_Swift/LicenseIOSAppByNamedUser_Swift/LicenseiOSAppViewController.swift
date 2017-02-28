//
//  AppDelegate.swift
//  LicenseIOSAppByNamedUser_Swift
//
//  Created by maklMac on 2/14/17.
//  Copyright © 2017 esrichina.com. All rights reserved.
//

import UIKit
import ArcGIS


class LicenseiOSAppViewController: UIViewController,LoginVCDelegate {
    
    
    @IBOutlet private weak var mapView:AGSMapView!

    @IBOutlet private weak var saveAsBlurView:UIVisualEffectView!
    @IBOutlet private weak var savingToolbar:UIToolbar!
    
    
    
    private var loginVC:LoginViewController!
    
    private var portal:AGSPortal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        let map = AGSMap(basemap: AGSBasemap.imagery())
        
        self.mapView.map = map
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
  
    
    private func toggleLoginView() {
        
        self.saveAsBlurView.isHidden = !self.saveAsBlurView.isHidden
        
    }
    
    //MARK: - Actions
    @IBAction func ActivateLicense(_ sender: Any) {
        
        self.toggleLoginView()
        
    }
    
    func LoginPortal(withname name:String,key:String) {
        
        self.portal = AGSPortal(url: URL(string: "https://www.arcgis.com")!, loginRequired: true)
        
        self.portal.credential = AGSCredential(user: name, password: key)
        
        self.portal.load { (error) in
            if let error = error {
                
                print("Login portal failded：\(error)")
                
            }
            else {
                
                //get title etc
                print("portal login succeed!")
                
                //get the users license info from the portal info
                let licenseInfo = self.portal.portalInfo?.licenseInfo
                
                
                //set the license using the Named Users licenseInfo
                do {
                    
                    let result = try AGSArcGISRuntimeEnvironment.setLicenseInfo(licenseInfo!)
                    
                }
                catch let error as NSError {
                    print("error: \(error.localizedDescription)")
                }
                    
                
                
                //The app is now licensed
                
                // Save the license information so that the app can be started and licensed offline
                // In this example the licenseDictionary is stored in keychain
                
                var licenseDictionary: NSDictionary?
                
                do {licenseDictionary = try licenseInfo?.toJSON() as! NSDictionary?
                } catch {
                    print("LicenseInfo not available")
                }
                
                
                let keychainItem = AGSKeychainItem(identifier: "maklesri.LicenseIOSAppByNamedUser", accessGroup: nil, acrossDevices: false)
                
                keychainItem.writeObject(toKeychain: licenseDictionary!, completion: { (writeError) in
                    if let error = writeError {
                        print("Error writing to the Keychain... \(error)")
                    }
                })
                
            }
            
        }
    }

    
    
    @IBAction private func cancelAction() {
        self.view.endEditing(true)
        self.toggleLoginView()
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "LoginEmbedSegue" {
            
            print("正在初始化LoginViewController")
            
            self.loginVC = segue.destination as! LoginViewController
            
            
            self.loginVC.delegate = self
            
        }
        
    }
    
    
    //MARK: - LoginVCDelegate
    
    func loginViewController(_ loginViewController:LoginViewController, didInitiateLoginWithName name:String, key:String){
        
        self.LoginPortal(withname:name,key:key)
        
        self.toggleLoginView()
    }
    
    func loginViewControllerDidCancel(_ saveAsViewController:LoginViewController){
        
        self.toggleLoginView()
    }
    
    
    

}
