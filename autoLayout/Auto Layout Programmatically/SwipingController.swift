//
//  SwipingController.swift
//  Auto Layout Programmatically
//
//  Created by SnoopyKing on 2017/11/11.
//  Copyright © 2017年 SnoopyKing. All rights reserved.
//
//Controller
import UIKit

class SwipingController : UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    
    
    let pages = [
        Page(imgName: "img1", headerText: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", bodyText: "Are you looking for anyone? Don't hesitate and longer!! We hope you have fun in our apps!!"),
        Page(imgName: "img2", headerText: "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb", bodyText: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa!!"),
        Page(imgName: "img3", headerText: "cccccccccccccccccccccccc", bodyText: "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"),
        Page(imgName: "img4", headerText: "ddddddddddddddddddddddddddddddd", bodyText: "cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc!"),Page(imgName: "img3", headerText: "cccccccccccccccccccccccc", bodyText: "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"),
        Page(imgName: "img4", headerText: "ddddddddddddddddddddddddddddddd", bodyText: "cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc!"),
    ]

    fileprivate func setupBtnControls(){
        
        let bottomStackViewController = UIStackView(arrangedSubviews: [priviousBtn,pageControl,nextBtn])
        view.addSubview(bottomStackViewController)
        bottomStackViewController.translatesAutoresizingMaskIntoConstraints = false
        bottomStackViewController.distribution = .fillEqually

        NSLayoutConstraint.activate([
            bottomStackViewController.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomStackViewController.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomStackViewController.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomStackViewController.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
//        print(x,view.frame.width)
    }
    
    let priviousBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("PREV", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(.gray, for: .normal)
        btn.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        return btn
    }()
    let nextBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("NEXT", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(.mainPink, for: .normal)
        btn.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return btn
    }()
    
    @objc private func handleNext(){
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    @objc private func handlePrevious(){
        let previousIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: previousIndex, section: 0)
        pageControl.currentPage = previousIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    lazy var pageControl : UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .mainPink
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBtnControls()
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView?.isPagingEnabled = true
    }
}
