//
//  Meme.swift
//  MemeProject
//
//  Created by Pedro Ullmann on 10/6/18.
//  Copyright © 2018 Pedro Ullmann. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    let topText: String
    let bottomText: String
    let originalImage: UIImage
    let memedImage: UIImage
    
    init(topText: String,
         bottomText: String,
         originalImage: UIImage,
         memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
}
