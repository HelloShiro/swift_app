//
//  ViewController.swift
//  Auto Layout Programmatically
//
//  Created by SnoopyKing on 2017/11/11.
//  Copyright © 2017年 SnoopyKing. All rights reserved.
//

import UIKit

extension UIColor{
    static var mainPink = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
}

class ViewController : UIViewController {
    //1.建立物件
    let bearImageView : UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "img1"))
        //3.取消自動佈局
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let discriptionTextView : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString(string: "This is Karen and Garys' intro webSite!!", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 18)])
        attributedText.append(NSAttributedString(string: "\n\n\nAre you looking for anyone? Don't hesitate and longer!! We hope you have fun in our apps!!", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 13),NSAttributedStringKey.foregroundColor:UIColor.gray]))

        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let priviousBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("PREV", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(.gray, for: .normal)
        return btn
    }()
    let nextBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("NEXT", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(.mainPink, for: .normal)
        return btn
    }()
    
    private let pageController : UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = .mainPink
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //2.加入view
//        view.addSubview(bearImageView)
        view.addSubview(discriptionTextView)
        setupBtnControls()
        //4.佈局
        
        setupLayout()
    
    }
    
    fileprivate func setupBtnControls(){

        let bottomStackViewController = UIStackView(arrangedSubviews: [priviousBtn,pageController,nextBtn])
        view.addSubview(bottomStackViewController)
        bottomStackViewController.translatesAutoresizingMaskIntoConstraints = false
        bottomStackViewController.distribution = .fillEqually
//        bottomStackViewController.axis = .vertical
        
        NSLayoutConstraint.activate([
            bottomStackViewController.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomStackViewController.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomStackViewController.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomStackViewController.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    private func setupLayout(){
        let topViewContainerView = UIView()
//        topViewContainerView.backgroundColor = .yellow
        view.addSubview(topViewContainerView)
//        topViewContainerView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        topViewContainerView.translatesAutoresizingMaskIntoConstraints = false
        topViewContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        topViewContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topViewContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topViewContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        //覆蓋塗層
        topViewContainerView.addSubview(bearImageView)
        
        bearImageView.centerXAnchor.constraint(equalTo: topViewContainerView.centerXAnchor).isActive = true
        bearImageView.centerYAnchor.constraint(equalTo: topViewContainerView.centerYAnchor).isActive = true
        bearImageView.topAnchor.constraint(equalTo: topViewContainerView.topAnchor).isActive = true
        bearImageView.heightAnchor.constraint(equalTo: topViewContainerView.heightAnchor, multiplier: 0.5)
        
        discriptionTextView.topAnchor.constraint(equalTo: topViewContainerView.bottomAnchor).isActive = true
        discriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        discriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor,  constant:-24).isActive = true
        discriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    

}

