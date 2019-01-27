//
//  images.swift
//  virtualTourists
//
//  Created by Najla Al qahtani on 1/20/19.
//  Copyright © 2019 Najla Al qahtani. All rights reserved.
//

import Foundation
import UIKit

class DownloadImages {
    
    static func getImage(imageURL: URL) -> UIImage {
        
        let image = try! UIImage(data: Data(contentsOf: imageURL))
        
        return image!
    }
}

