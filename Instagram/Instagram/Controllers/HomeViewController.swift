//
//  HomeViewController.swift
//  Instagram
//
//  Created by PJ Martinez on 2/25/18.
//  Copyright © 2018 Paolo Martinez. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var feedTableView: UITableView!
    var posts: [Post] = []
    var refreshControl : UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // refreshes post when user opens application for first time
        fetchPosts()
        
        // tableView
        feedTableView.dataSource = self
        feedTableView.delegate = self
        feedTableView.rowHeight = UITableViewAutomaticDimension
        feedTableView.estimatedRowHeight = 120
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeViewController.didPullToRefresh(_:)), for: .valueChanged)
        feedTableView.insertSubview(refreshControl, at: 0)
        
        // "back up refresh" incase top fetchPost() doesn't refresh
        fetchPosts()
    }

    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        fetchPosts()
    }
    
    
    func fetchPosts(){
        let query = Post.query()
        query?.limit = 20
        query?.order(byDescending: "_created_at")
        // fetch data asynchronously
        query?.findObjectsInBackground(block: { (posts, error) in
            if  posts != nil {
                self.posts = posts as! [Post]
                self.feedTableView.reloadData()
                self.refreshControl.endRefreshing()
            } else {
                // handle error
                print("Error from home view controller trying to get posts in fetchPosts() function with localized description \"\(error!.localizedDescription)\"")
            }
        })
    }
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = feedTableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row] as PFObject!
        cell.postCaptionLabel.text = (post!["caption"] as! String)
        //cell.postUsernameLabel.text = (post!["author"] as! String)
        cell.postImage.file = (post!["media"] as! PFFile)
        cell.postImage.loadInBackground()
        return cell
    }

    
    @IBAction func onLogout(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
