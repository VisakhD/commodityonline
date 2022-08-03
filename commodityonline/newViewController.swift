////
////  newViewController.swift
////  commodityonline
////
////  Created by Netcom on 03/08/22.
////
//
//import UIKit
//
//class newViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//    
//
//    if navigationAction.request.url?.scheme == "tel" {
//        UIApplication.shared.open(navigationAction.request.url!)
//        decisionHandler(.cancel)
//    } else if navigationAction.request.url?.scheme == "mailto" {
//        UIApplication.shared.open(navigationAction.request.url!)
//        decisionHandler(.cancel)
//    }else if navigationAction.request.url?.scheme == "wa.me"{
//        UIApplication.shared.canOpenURL(appURL)
//            if #available(iOS 10.0, *) {
//                   UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
//               }
//               else {
//                   UIApplication.shared.openURL(appURL)
//               }
//        
//        decisionHandler(.cancel)
//    }else {
//        decisionHandler(.allow)
//    }
// 
//    
//    
//    
//    
//    
//    
//    
//    if navigationAction.navigationType == .linkActivated  {
//                if let url = navigationAction.request.url,
//                    let host = url.host, !host.hasPrefix("facebook.com"),
//                    UIApplication.shared.canOpenURL(url) {
//                    UIApplication.shared.open(url, options: [:])
//                    print(url)
//                    print("No need to open it locally")
//                    decisionHandler(.cancel)
//                } else {
//                    print("Open it locally")
//                    decisionHandler(.allow)
//                }
//            } else {
//                print("not a user click")
//                decisionHandler(.allow)
//            }
//
//    
//    
//    
//    
//    
//    
//
//}
