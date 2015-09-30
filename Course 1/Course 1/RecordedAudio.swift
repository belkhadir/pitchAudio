//
//  File.swift
//  Course 1
//
//  Created by Anas Belkhadir on 24/09/2015.
//  Copyright © 2015 Anas Belkhadir. All rights reserved.
//

import Foundation

class RecordedAudio {
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL,title: String) {
       self.filePathUrl = filePathUrl
       self.title = title
    }
}