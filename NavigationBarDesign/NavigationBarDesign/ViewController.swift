//
//  ViewController.swift
//  NavigationBarDesign
//
//  Created by 재영신 on 2021/10/26.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        if let hasStatusBar = self.statusBar{
            window?.addSubview(hasStatusBar)
        }
        setNavigationTitleImmage()
        //makeBackButton()
        navigationBackgroundDesingn()
        makeRightAlarmButton()
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationBackgroundDesingn()
    }
    
    func makeRightAlarmButton(){
//        let image = UIImage(systemName: "alarm.fill")?.withRenderingMode(.alwaysOriginal)
//        let rightItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(rightItemClick))
//        let image2 = UIImage(systemName: "alarm")?.withRenderingMode(.alwaysOriginal)
//        let rightItem2 = UIBarButtonItem(image: image2, style: .done, target: self, action: #selector(rightItemClick))
//
//        rightItem2.imageInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: -20)
        
        let config = UIImage.SymbolConfiguration(pointSize: 40)
        let btn1 = UIButton()
        btn1.setImage(UIImage(systemName: "alarm",withConfiguration: config), for: .normal)
        btn1.addTarget(self, action: #selector(rightItemClick), for: .touchUpInside)
        let btn2 = UIButton()
        btn2.setImage(UIImage(systemName: "alarm.fill",withConfiguration: config), for: .normal)
        btn2.addTarget(self, action: #selector(rightItemClick), for: .touchUpInside)
        let stackView = UIStackView(arrangedSubviews: [btn1,btn2])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        let customItem = UIBarButtonItem(customView: stackView)
        self.navigationItem.rightBarButtonItem = customItem
    }
    @objc func rightItemClick(){
        print("right item click")
    }
    func navigationBackgroundDesingn(){
        // appearance.backgroundEffect = UIBlurEffect(style: .light)
        //appearance.backgroundColor = .orange
        //appearance.backgroundImage = UIImage()
        //self.navigationController?.navigationBar.standardAppearance = appearance
        //self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.backgroundColor = .red
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //      self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        //statuc bar design
        
        self.statusBar?.backgroundColor = .red
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

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
