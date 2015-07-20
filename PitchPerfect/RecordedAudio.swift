//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by Michael Recachinas on 7/12/15.
//  Copyright (c) 2015 Michael Recachinas. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title:       String!
    
    init(title: String, filePathUrl: NSURL) {
        self.title       = title
        self.filePathUrl = filePathUrl
    }
}