//
//  ViewController.swift
//  LicenseIOSAppByNamedUser_Swift
//
//  Created by maklMac on 2/14/17.
//  Copyright © 2017 esrichina.com. All rights reserved.
//

import UIKit
import ArcGIS

class ViewController: UIViewController{
    
    //let webmapURL = "https://www.arcgis.com/home/webmap/viewer.html?webmap="
    
    @IBOutlet private weak var mapView:AGSMapView!

    @IBOutlet private weak var createOptionsBlurView:UIVisualEffectView!
    @IBOutlet private weak var saveAsBlurView:UIVisualEffectView!
    
    private var portal:AGSPortal!


    @IBOutlet weak var activeLicense: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Auth Manager settings
        
        //Auth Manager settings
        
        
        let map = AGSMap(basemap: AGSBasemap.imagery())
        
        self.mapView.map = map
        
        /*
        let config = AGSOAuthConfiguration(portalURL: URL(string:"https://www.arcgis.com"), clientID: "jpjUoLOxgqjDVr5W", redirectURL: "zssai-create-map://auth")
        
        AGSAuthenticationManager.shared().oAuthConfigurations.add(config)
        AGSAuthenticationManager.shared().credentialCache.removeAllCredentials()
        
        */

        
    }
    
    private func showSuccess(){
        
        let alertController = UIAlertController(title: "用户登录窗口", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        
    }
   
    
    func LoginPortal() {
        self.portal = AGSPortal(url: URL(string: "https://www.arcgis.com")!, loginRequired: true)
        
        self.portal.load { (error) in
            if let error = error {
                
                print("登录portal失败：\(error)")
                
            }
            else {
                //get title etc
                //self.toggleSaveAsView()
                
                print("portal登录成功")
                
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
    
    private func toggleSaveAsView() {
        
        self.saveAsBlurView.isHidden = !self.saveAsBlurView.isHidden
        
        self.view.endEditing(true)
    }

    
    @IBAction func activeLicense(_ sender: Any) {
        
        self.LoginPortal()

    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

