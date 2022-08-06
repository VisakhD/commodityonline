//
//  LaunchViewController.swift
//  commodityonline
//
//  Created by Visakh on 06/08/22.
//

import UIKit

class LaunchViewController: UIViewController {
    let network: NetworkManager = NetworkManager.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.isUnreachable { _ in
            print("connection gone")
            self.showOfflinePage()
        }
        NetworkManager.isReachable { _ in
            print("connection came")
            self.showMainPage()
        }

        // Do any additional setup after loading the view.
    }
    
    private func showOfflinePage()  {
        DispatchQueue.main.async {
//            self.performSegue(
//                withIdentifier: "NetworkUnavailable",
//                sender: self
//            )
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as! LoadingViewController
        vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    func showMainPage() {
        DispatchQueue.main.async {
//            self.performSegue(
//                withIdentifier: "MainController",
//                sender: self
//            )
            let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            let vc = storyboard.instantiateViewController(withIdentifier:"HomeViewController") as!  HomeViewController
            vc.modalPresentationStyle  = .fullScreen
            self.present(vc, animated: false, completion: nil)
        }
        

    }


}
