//
//  pinAndCorePoreporties.swift
//  virtualTourists
//
//  Created by Najla Al qahtani on 1/20/19.
//  Copyright © 2019 Najla Al qahtani. All rights reserved.
//


import Foundation
import CoreData

extension Pin {
    
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Pin> {
        return NSFetchRequest<Pin>(entityName: "Pin");
    }
    
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var hasPhotos: NSSet?
    
}

extension Pin {
    
    @objc(addHasPhotosObject:)
    @NSManaged public func addToHasPhotos(_ value: Photo)
    
    @objc(removeHasPhotosObject:)
    @NSManaged public func removeFromHasPhotos(_ value: Photo)
    
    @objc(addHasPhotos:)
    @NSManaged public func addToHasPhotos(_ values: NSSet)
    
    @objc(removeHasPhotos:)
    @NSManaged public func removeFromHasPhotos(_ values: NSSet)
    
}

