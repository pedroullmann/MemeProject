//
//  ListTableViewController.swift
//  MemeProject
//
//  Created by Pedro Ullmann on 10/21/18.
//  Copyright © 2018 Pedro Ullmann. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    // MARK: Properties
    private let numberOfSections = 1
    private let cellIdentifier = "memeTableCell"
    private let detailSegueIdentifier = "viewDetailSegue"
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configNavigationBar()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeMemeNotification()
    }

    // MARK: Auxiliary Functions
    private func configTableView() {
        tableView.separatorStyle = .none
    }
    
    private func configNavigationBar() {
        let addMeme = UIBarButtonItem(barButtonSystemItem: .add,
                                      target: self,
                                      action: #selector(addTapped))
        
        navigationItem.rightBarButtonItem = addMeme
        navigationController?.navigationBar.setItems([navigationItem], animated: false)
    }
  
    private func subscribeMemeNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadData),
                                               name: .dataMemeWasChanged,
                                               object: nil)
    }
    
    @objc func reloadData() {
        self.tableView.reloadData()
    }
    
    @objc func addTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "saveViewController")
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailSegueIdentifier,
            let detailVC = segue.destination as? DetailViewController,
            let model = sender as? Meme {
            detailVC.memeModel = model
        }
    }
    
    // MARK: DataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? MemeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.meme = memes[indexPath.row]
        
        return cell
    }
    
    // MARK: Delegates
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meme = memes[indexPath.row]
        performSegue(withIdentifier: detailSegueIdentifier, sender: meme)
    }
}

