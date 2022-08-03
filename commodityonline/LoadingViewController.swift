//
//  LoadingViewController.swift
//  commodityonline
//
//  Created by Netcom on 26/07/22.
//

import UIKit
import Lottie

class LoadingViewController: UIViewController {

    @IBOutlet var loadingView: UIView!
    let loadScreen = "pageNotFound"
    var loadingString = ""
    var checker = false
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if checker == false{
            createAnimation(name: loadScreen )
        }else {
            createAnimation(name: loadingString)
        }
        
        // Do any additional setup after loading the view.
    }

//    "pageNotFound"  "loading"  "networkerror"
    
    public func createAnimation(name:String) {
        
        let animiView = AnimationView(name: name)
        animiView.contentMode = .scaleAspectFit
        animiView.center = self.loadingView.center
        animiView.frame = self.loadingView.bounds
        animiView.loopMode = .loop
        animiView.play()
       self.loadingView.addSubview(animiView)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
