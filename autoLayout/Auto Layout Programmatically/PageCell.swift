//
//  PageCell.swift
//  Auto Layout Programmatically
//
//  Created by SnoopyKing on 2017/11/12.
//  Copyright © 2017年 SnoopyKing. All rights reserved.
//

import UIKit
//View
class PageCell : UICollectionViewCell{
    
    var page : Page? {
        didSet{
//            print(page?.imgName)
            guard let unwrappedPage = page else {return}
            bearImageView.image = UIImage(named: unwrappedPage.imgName)
            
            let attributedText = NSMutableAttributedString(string: unwrappedPage.headerText, attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 18)])
            attributedText.append(NSAttributedString(string: "\n\n\n\(unwrappedPage.bodyText)", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 13),NSAttributedStringKey.foregroundColor:UIColor.gray]))
            
            discriptionTextView.attributedText = attributedText
            discriptionTextView.textAlignment = .center
            
        }
    }
    
    private let bearImageView : UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "img2"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let discriptionTextView : UITextView = {
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
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupLayout(){
        let topViewContainerView = UIView()
        addSubview(topViewContainerView)
        topViewContainerView.translatesAutoresizingMaskIntoConstraints = false
        topViewContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        topViewContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topViewContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topViewContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        //覆蓋塗層
        topViewContainerView.addSubview(bearImageView)
        
        bearImageView.centerXAnchor.constraint(equalTo: topViewContainerView.centerXAnchor).isActive = true
        bearImageView.centerYAnchor.constraint(equalTo: topViewContainerView.centerYAnchor).isActive = true

        bearImageView.heightAnchor.constraint(equalTo: topViewContainerView.heightAnchor, multiplier: 0.5).isActive = true
        addSubview(discriptionTextView)
        discriptionTextView.topAnchor.constraint(equalTo: topViewContainerView.bottomAnchor).isActive = true
        discriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        discriptionTextView.rightAnchor.constraint(equalTo: rightAnchor,  constant:-24).isActive = true
        discriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
