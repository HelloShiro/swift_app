//
//  ViewController.swift
//  yoututbe
//
//  Created by SnoopyKing on 2017/11/13.
//  Copyright © 2017年 SnoopyKing. All rights reserved.
//

import UIKit



class HomeController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

//    var videos : [Video] = {
//        var cloudChannel = Channel()
//        cloudChannel.name = "CloudChannel"
//        cloudChannel.profileImageName = "cloud"
//
//        var blankSpaceVideo = Video()
//        blankSpaceVideo.title = "Karen Chen -- Blank Space"
//        blankSpaceVideo.thumbnailImageName = "img2"
//        blankSpaceVideo.channel = cloudChannel
//        blankSpaceVideo.numberOfViews = 12345678
//        var video2 = Video()
//        video2.title = "Karen Chen -- Eating Eating Eating Eating Eating Eating Eating Eating Eating Eating Karen"
//        video2.thumbnailImageName = "img3"
//        video2.channel = cloudChannel
//        video2.numberOfViews = 73612
//        return [blankSpaceVideo,video2]
//    }()
    var videos : [Video]?
    
    let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
    func fetchVideos(){
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                print(error!)
                return
            }
            //            let str = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                self.videos = [Video]()
                for dic in json as! [[String:NSObject]]{
                    let video = Video()
                    video.title = dic["title"] as? String
                    video.thumbnailImageName = dic["thumbnail_image_name"] as? String
                    let channelDic = dic["channel"] as! [String : NSObject]
                    let channel = Channel()
                    channel.profileImageName = channelDic["profile_image_name"] as? String
                    channel.name = (channelDic["name"] as! String)
                    video.channel = channel
                    self.videos?.append(video)
                }
                DispatchQueue.main.async(execute: {
                    self.collectionView?.reloadData()
                }) 
            }catch let jsonError{
                print(jsonError)
            }



        }.resume()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchVideos()
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        collectionView?.backgroundColor = .white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        setupMenuBar()
        setupNavBarButtons()
    }
    
    func setupNavBarButtons(){
        let searchImg = UIImage(named: "icon_search")?.withRenderingMode(.alwaysOriginal)
        let searchBtn = UIBarButtonItem(image: searchImg, style: .plain, target: self, action: #selector(handleSearch))
        let moreImg = UIImage(named: "icon_more")?.withRenderingMode(.alwaysOriginal)
        let moreBtn = UIBarButtonItem(image: moreImg, style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreBtn,searchBtn]
        
    }

    @objc func handleMore(){
        print(111)
    }
    @objc func handleSearch(){
        print(123)
    }

    
    let menuBar:MenuBar = {
       let mb = MenuBar()
        return mb
    }()
    
    func setupMenuBar(){
        view.addSubview(menuBar)
        view.addConstriantFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstriantFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        
        return videos?.count ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width , height: height + 16 + 88)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}








