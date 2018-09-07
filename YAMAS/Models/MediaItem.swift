//
//  MediaItem.swift
//  YAMAS
//
//  Created by Kukun on 9/5/18.
//  Copyright © 2018 ARSP. All rights reserved.
//

import UIKit

class MediaItem {
    var artistName: String
    var trackName: String
    var artworkUrl: String
    var previewUrl: String
    var longDescription: String?
    
    init(artistName:String, trackName:String, artworkUrl:String, previewUrl:String){
        self.artistName = artistName
        self.trackName = trackName
        self.artworkUrl = artworkUrl
        self.previewUrl = previewUrl
    }
    
    init(artistName:String, trackName:String, artworkUrl:String, longDescription:String?, previewUrl:String){
        self.artistName = artistName
        self.trackName = trackName
        self.artworkUrl = artworkUrl
        self.previewUrl = previewUrl
        self.longDescription = longDescription
    }
}
