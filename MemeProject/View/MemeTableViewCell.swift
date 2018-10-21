//
//  MemeTableViewCell.swift
//  MemeProject
//
//  Created by Pedro Ullmann on 10/21/18.
//  Copyright © 2018 Pedro Ullmann. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    // MARK Properties
    var meme: Meme! {
        didSet {
            self.memeImage.image = meme.originalImage
            self.textPreview.text = "\(meme.topText)...\(meme.bottomText)"
        }
    }
    
    // MARK: Outlets
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var textPreview: UILabel!
    
    // MARK: LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
