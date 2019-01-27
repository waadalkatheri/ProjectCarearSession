//
//  photoAndCorePoreporties.swift
//  virtualTourists
//
//  Created by Najla Al qahtani on 1/20/19.
//  Copyright © 2019 Najla Al qahtani. All rights reserved.


import Foundation
import CoreData

extension Photo {
    
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo");
    }
    
    @NSManaged public var image: NSData?
    @NSManaged public var photoID: String?
    @NSManaged public var relatesTo: Pin?
    
}
