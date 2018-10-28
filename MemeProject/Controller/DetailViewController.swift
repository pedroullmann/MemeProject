//
//  DetailViewController.swift
//  MemeProject
//
//  Created by Pedro Ullmann on 10/28/18.
//  Copyright © 2018 Pedro Ullmann. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var imageView: UIImageView!

    // MARK: Properties
    var memeModel: Meme!
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = memeModel.memedImage
    }
}
