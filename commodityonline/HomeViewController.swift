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


class HomeViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet var webView: WKWebView!
    
    @IBOutlet var loaderView: UIView!
    let reachability = try! Reachability()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createAnimation(name: k.loadingPage)
        navigationController?.navigationBar.isHidden = true
        let myUrl = URL(string: k.mainURL)
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
        
        
        let appURL = URL(string: k.watzURL)!
        //        let fburl = URL(string:  "https://m.facebook.com/CommodityOnline")
        //        let tweeturl = URL(string: " https://mobile.twitter.com/commodityonline")
        //        let insturl = URL(string: "https://www.instagram.com/commodityonline/?hl=en")
        //
        
        
        
        
        
        if navigationAction.request.url?.scheme == k.phone {
            UIApplication.shared.open(navigationAction.request.url!)
            decisionHandler(.cancel)
        }
        else if navigationAction.request.url?.scheme == k.mail {
            UIApplication.shared.open(navigationAction.request.url!)
            decisionHandler(.cancel)
        }
        
        else if navigationAction.navigationType == .linkActivated  {
            if let url = navigationAction.request.url ,UIApplication.shared.canOpenURL(url) {
                if (url.absoluteString.range(of: k.fb) != nil || url.absoluteString.range(of: k.twit) != nil || url.absoluteString.range(of: k.insta) != nil
                    || url.absoluteString.range(of: k.play) != nil || url.absoluteString.range(of:k.watz) != nil){
                    if (url.absoluteString.range(of: k.watz) != nil) == true {
                        UIApplication.shared.open( appURL, options: [:])
                    }
                    UIApplication.shared.open(url, options: [:])
                    decisionHandler(.cancel)
                    
                }
                else if url.absoluteString.suffix(11) == "mandi-alert"  {
                    UIApplication.shared.open( url, options: [:])
                           decisionHandler(.cancel)
                    
                }
                
                else {
                    decisionHandler(.allow)
                }
            }
        }
        else {
            decisionHandler(.allow)
        }
        
        
        
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
        vc.loadingString = k.networkError
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
