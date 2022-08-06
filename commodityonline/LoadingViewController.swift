//
//  LoadingViewController.swift
//  commodityonline
//
//  Created by Netcom on 26/07/22.
//

import UIKit
import Lottie

class LoadingViewController: UIViewController {
    let network = NetworkManager.sharedInstance
    
    @IBOutlet var loadingView: UIView!
    var loadingString = ""
    var checker = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        network.reachability.whenReachable = { _ in
            self.showMainController()
        }
        
        if checker == false{
            createAnimation(name: k.loadScreen )
        }else {
            createAnimation(name: loadingString)
        }
        
        // Do any additional setup after loading the view.
    }
    
    func showMainController() {
          DispatchQueue.main.async {
//              self.performSegue(withIdentifier: "MainController", sender: self)
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier:"HomeViewController") as!  HomeViewController
        vc.modalPresentationStyle  = .fullScreen
        self.present(vc, animated: false, completion: nil)

          }

      }

    
    public func createAnimation(name:String) {
        
        let animiView = AnimationView(name: name)
        animiView.contentMode = .scaleAspectFit
        animiView.center = self.loadingView.center
        animiView.frame = self.loadingView.bounds
        animiView.loopMode = .loop
        animiView.play()
        self.loadingView.addSubview(animiView)
        
    }
    
    
}




//
//
//if navigationAction.request.url?.scheme == k.phone {
//    UIApplication.shared.open(navigationAction.request.url!)
//    decisionHandler(.cancel)
//}
//else if navigationAction.request.url?.scheme == k.mail {
//    UIApplication.shared.open(navigationAction.request.url!)
//    decisionHandler(.cancel)
//}
//
//else if navigationAction.navigationType == .linkActivated  {
//    if let url = navigationAction.request.url ,UIApplication.shared.canOpenURL(url) {
//        if (url.absoluteString.range(of: k.fb) != nil || url.absoluteString.range(of: k.twit) != nil || url.absoluteString.range(of: k.insta) != nil
//            || url.absoluteString.range(of: k.play) != nil || url.absoluteString.range(of:k.watz) != nil){
//            if (url.absoluteString.range(of: k.watz) != nil) == true {
//                UIApplication.shared.open( appURL, options: [:])
//                decisionHandler(.cancel)
//            }
//            UIApplication.shared.open(url, options: [:])
//            decisionHandler(.cancel)
//        }
////                else if url.host?.hasPrefix("Get Free mandi Alert") == true {
////                    UIApplication.shared.open( appURL, options: [:])
//////                    decisionHandler(.cancel)
////                }
//        } else {
//            decisionHandler(.allow)
//        }
//      
//    
//}
//else {
//    decisionHandler(.allow)
//}
//
//

