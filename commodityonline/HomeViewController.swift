//
//  ViewController.swift
//  commodityonline
//
//  Created by Netcom on 26/07/22.
//

import UIKit
import WebKit
import Lottie
import Reachability
import Alamofire

class HomeViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet var webView: WKWebView!
    let phoneNumber = +918448090300
    @IBOutlet var loaderView: UIView!
    let reachability = try! Reachability()
    let networkError = "networkerror"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createAnimation(name: "loading")
        navigationController?.navigationBar.isHidden = true
        let myUrl = URL(string: "https://www.commodityonline.com/?utm_source=mobile-app&utm_campaign=mobile-app")
        let myRequest = URLRequest(url: myUrl!)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.load(myRequest)
        webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        webView.configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
        
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
            dismiss(animated: false, completion: nil)
        case .cellular:
            print("Reachable via Cellular")
            dismiss(animated: false, completion: nil)
        case .unavailable:
            print("Network not reachable")
            let vc = storyboard?.instantiateViewController(withIdentifier: "LoadingViewController") as! LoadingViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        default: break
        }
    }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        
        let appURL = URL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")!
        let fburl = URL(string:  "https://m.facebook.com/CommodityOnline")
        let tweeturl = URL(string: " https://mobile.twitter.com/commodityonline")
        let insturl = URL(string: "https://www.instagram.com/commodityonline/?hl=en")
        

   
        
        
    
        if navigationAction.request.url?.scheme == "tel" {
                UIApplication.shared.open(navigationAction.request.url!)
                decisionHandler(.cancel)
            }
        else if navigationAction.request.url?.scheme == "mailto" {
                UIApplication.shared.open(navigationAction.request.url!)
                decisionHandler(.cancel)
            }
        else if navigationAction.navigationType == .linkActivated {
                if let url = navigationAction.request.url,
                    let host = url.host, !host.hasPrefix("facebook.com"),
                    UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:])
                    print(url)
                    print("No need to open it locally")
                    decisionHandler(.cancel)
                }
        }
//            if let url = navigationAction.request.url ,UIApplication.shared.canOpenURL(url){
//                if (url.absoluteString.range(of: "facebook.com") != nil || url.absoluteString.range(of: "twitter.com") != nil || url.absoluteString.range(of: "instagram.com") != nil
//                    || url.absoluteString.range(of: "googleplay.com") != nil){
//                    UIApplication.shared.open(url, options: [:])
////                    decisionHandler(.cancel)
//            }
//        }
//            let url = navigationAction.request.url!
//            UIApplication.shared.canOpenURL(url)
//            decisionHandler(.cancel)
//        }
//
//        else if navigationAction.request.url?.scheme == "wa.me" {
//            if UIApplication.shared.canOpenURL(appURL) {
//                if #available(iOS 10.0, *) {
//                    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
//                }
//                else {
//                    UIApplication.shared.openURL(appURL)
//                }
//            }
//
//            decisionHandler(.cancel)
//
//        }
        else {
            decisionHandler(.allow)
        }
//
        
        
        

        
        
        
    }
    
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loaderView.isHidden = true
        print("content finished loading")
        
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loaderView.isHidden = true
        print("loading Error Noted")
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoadingViewController") as! LoadingViewController
        vc.checker = true
        vc.loadingString =  networkError
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
        
    }
    
    
    
    func createAnimation(name:String) {
        guard loaderView != nil
        else{
            print("load not taken")
            return
            
        }
        webView.addSubview(loaderView)
        let animiView = AnimationView(name: name)
        animiView.contentMode = .center
        animiView.center = loaderView.center
        animiView.frame = loaderView.bounds
        animiView.loopMode = .loop
        animiView.play()
        loaderView.addSubview(animiView)
        
    }
    
    
    
    
}
