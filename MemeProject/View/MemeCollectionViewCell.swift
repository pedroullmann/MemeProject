//
//  MemeCollectionViewCell.swift
//  MemeProject
//
//  Created by Pedro Ullmann on 10/21/18.
//  Copyright © 2018 Pedro Ullmann. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    
    // MARK Properties
    var meme: Meme! {
        didSet {
            self.memeImage.image = meme.memedImage
        }
    }
    
    // MARK: Outlets
    @IBOutlet weak var memeImage: UIImageView!
    
    // MARK: LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
