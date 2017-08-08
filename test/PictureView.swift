//
//  PictureView.swift
//  test
//
//  Created by Artem Mkrtchyan on 8/8/17.
//  Copyright © 2017 Artem Mkrtchyan. All rights reserved.
//

import UIKit
import Kingfisher
import FacebookCore

class PictureViewController: UIViewController{
    
    var picture: Picture?
    var token: String?
    
    @IBOutlet weak var ivPicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        token = AccessToken.current?.authenticationToken

        let url = URL(string: "https://graph.facebook.com/v2.10/\((picture?.id)!)/picture?type=normal&access_token=\(token!)")!

        print(url.absoluteURL)
        ivPicture.kf.setImage(with: url)
        ivPicture.contentMode = .scaleAspectFit
    }
}
