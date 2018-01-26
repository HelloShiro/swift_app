//
//  Video.swift
//  yoututbe
//
//  Created by SnoopyKing on 2017/11/18.
//  Copyright © 2017年 SnoopyKing. All rights reserved.
//

import UIKit
class Video : NSObject{
    var thumbnailImageName : String?
    var title : String?
    var channel : Channel?
    var numberOfViews : NSNumber?
    var uploadDate : NSDate?
}
class Channel : NSObject{
    var name : String?
    var profileImageName : String?
}
