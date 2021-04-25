//
//  AnimationVC.swift
//  AlamofireCollection
//
//  Created by Farhana Khan on 25/04/21.
//

import UIKit
import Lottie

class AnimationVC: UIViewController {
    let animationV = AnimationView()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationCall()
        self.navigationController?.navigationBar.isHidden = true
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (t) in
            print("timer fire")
            self.count = self.count+1
            if(self.count == 3)
            {
                showVC()
                t.invalidate()
            }
        }
    }
    func animationCall(){
        
        animationV.animation = Animation.named("jewels")
        animationV.frame = view.bounds
        animationV.contentMode = .scaleAspectFit
        animationV.loopMode = .loop
        animationV.play()
        view.addSubview(animationV)
    }
    func showVC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "BrandVC") as! BrandVC
        let sceneDel = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        sceneDel.window?.rootViewController = vc
    }
}
