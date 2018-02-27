//
//  DetailViewController.swift
//  Instagram
//
//  Created by PJ Martinez on 2/26/18.
//  Copyright © 2018 Paolo Martinez. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailViewController: UIViewController {
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var captionLabel: UILabel!
    @IBOutlet var timestampLabel: UILabel!
    var post : PFObject?
    var postImage : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        photoImageView.image = postImage
        self.captionLabel.text = post!["caption"] as? String
        self.timestampLabel.text = post!["timestamp"] as? String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
