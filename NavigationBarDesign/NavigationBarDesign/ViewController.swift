//
//  ViewController.swift
//  NavigationBarDesign
//
//  Created by 재영신 on 2021/10/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationTitleImmage()
        makeBackButton()
    }
    func makeBackButton(){
        guard let backImage = UIImage(named: "bg103.jpg")?.withRenderingMode(.alwaysOriginal )
        else { return }
        //backImage = backImage?.withRenderingMode(.alwaysOriginal )
        let newImage = resizeImage(image: backImage, newWidth: 40, newHeight: 40)
        self.navigationController?.navigationBar.backIndicatorImage = newImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = newImage
        self.navigationController?.navigationBar.tintColor = UIColor.orange
        
        self.navigationItem.backButtonTitle = ""
    }
    
    func resizeImage(image: UIImage,newWidth :CGFloat,newHeight: CGFloat)-> UIImage?{
        let newImageRect = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in:newImageRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysOriginal)
        UIGraphicsEndImageContext()
        
        return newImage
    }
    func setNavigationTitleImmage(){
        //self.navigationItem.title = "메인 화면"
        
//        let logo = UIImageView(image: UIImage(named: "bg103.jpg"))
//
//        logo.contentMode = .scaleAspectFit
//        logo.widthAnchor.constraint(equalToConstant: 120).isActive = true
//        logo.heightAnchor.constraint(equalToConstant: 50).isActive = true
//
//        navigationItem.titleView = logo
        let btn = UIButton()
       // btn.backgroundColor = .orange
        btn.setTitle("custom button", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.widthAnchor.constraint(equalToConstant:120).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        btn.addTarget(self, action: #selector(testAction), for: .touchUpInside)
        self.navigationItem.titleView = btn
    }
    @objc func testAction(){
        print("test action")
    }
    
}
