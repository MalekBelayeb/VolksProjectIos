//
//  ImageAvatarHelper.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 1/13/20.
//  Copyright © 2020 Akthem-Malek. All rights reserved.
//

import Foundation
import UIKit


class ImageAvatarHelper{

    private static var instance: ImageAvatarHelper?

    public static func getInstance() -> ImageAvatarHelper{
        if(instance == nil){
            instance = ImageAvatarHelper()
        }
        return instance!
    }
 
    
    
    

    
    
    
}



