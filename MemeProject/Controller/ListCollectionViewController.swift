//
//  ListCollectionViewController.swift
//  MemeProject
//
//  Created by Pedro Ullmann on 10/21/18.
//  Copyright © 2018 Pedro Ullmann. All rights reserved.
//

import UIKit

class ListCollectionViewController: UICollectionViewController {

    // MARK: Properties
    private let numberOfSections = 1
    private let cellIdentifier = "memeCollectionCell"
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    // MARK: Outlets
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollection()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    // MARK: Auxiliary Functions
    private func configCollection() {
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }

    private func reloadData() {
        collectionView!.reloadData()
    }
    
    // MARK: DataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MemeCollectionViewCell else {
            return UICollectionViewCell()
        }
       
        cell.meme = memes[indexPath.row]
    
        return cell
    }
}
