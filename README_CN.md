# ArcGIS Runtime for iOS SDK100.0.0 使用 Named User激活许可示范工程

##概览

这个样例是为了示范，在使用ArcGIS Runtime SDK for iOS 100.0.0开发iOS地图应用时，如何通过Portal for ArcGIS 或者 ArcGIS Online的Named User来激活许可。示范工程包含Swift和Objective-C两个版本。您可以直接从链接中下载工程，然后在Xcode中打开，并在模拟器或者真机设备上调试运行。工程基于Xcode8.2版本开发，支持iOS9以上的系统部署。

##使用向导

1， 在Xcode中打开项目（LicenseIOSAppByNamedUser_ObjC or LicenseIOSAppByNamedUser_Swift），build成功后，运行工程；  

2， 在应用中，点击"ActivateLicense"按钮，跳转到登陆视窗，输入portal或online账户的用户名及密码；
  
![](https://raw.githubusercontent.com/serverteamCN/TechnicalArticles/master/pictures/LicenseIOSAppByNamedUser01.png)    

3， 输入结束后，点击“Done”按钮，登录窗口将自动关闭，进入等待...，过一会儿，你就可以见证开发者水印自动消失。

![](https://raw.githubusercontent.com/serverteamCN/TechnicalArticles/master/pictures/LicenseIOSAppByNamedUser02.png)

##系统需求：

1. ArcGIS Runtime SDK for iOS 100.0
2. Xcode 8(或更高)
3. iOS 10 SDK（或更高）

##工程下载地址：
[LicenseIOSAppByNamedUser](https://github.com/makeling/LicenseIOSAppByNamedUser.git)
