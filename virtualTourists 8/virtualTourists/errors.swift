//
//  errors.swift
//  virtualTourists
//
//  Created by Najla Al qahtani on 1/20/19.
//  Copyright © 2019 Najla Al qahtani. All rights reserved.
//

import Foundation

class Errors {
    
    static func createError(error: String, domain: String) -> NSError {
        let userInfo = [NSLocalizedDescriptionKey : error]
        return NSError(domain: domain, code: 1, userInfo: userInfo)
    }
}
