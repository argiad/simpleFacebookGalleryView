//
//  AlbumsController.swift
//  test
//
//  Created by Artem Mkrtchyan on 8/8/17.
//  Copyright © 2017 Artem Mkrtchyan. All rights reserved.
//

import UIKit
import FacebookCore
import Kingfisher

class AlbumsController: UITableViewController{
    
    
    var albums: [Album] = [Album]()
    
    var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        token = AccessToken.current?.authenticationToken
        
        GraphRequest(graphPath: "/me/albums", parameters: ["fields":"id,name,user_photos,cover_photo,cover_url"], httpMethod: GraphRequestHTTPMethod(rawValue: "GET")!)
            .start({  connection, g_response in
                switch g_response{
                case .success(let response):
                    
                    (response.dictionaryValue?["data"] as! [Any?]).forEach {value in
                        
                        self.albums.append(Album(dictionary: value as! Dictionary<String,Any> ))
                    }
                    self.tableView.reloadData()
                    break
                default:
                    break
                }
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        let url = URL(string: "https://graph.facebook.com/v2.10/\(albums[indexPath.row].id)/picture?type=thumbnail&access_token=\(token!)")!
        cell.imageView?.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
        cell.imageView?.contentMode = .center
        
        cell.textLabel?.text = albums[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showContent", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showContent" ,
            let nextScene = segue.destination as? ContentView ,
            let indexPath = self.tableView.indexPathForSelectedRow {
            nextScene.album = albums[indexPath.row]
        }
    }
}
