//
//  ContentView.swift
//  test
//
//  Created by Artem Mkrtchyan on 8/8/17.
//  Copyright © 2017 Artem Mkrtchyan. All rights reserved.
//

import UIKit
import FacebookCore

class ContentView: UITableViewController {
    
    var album: Album?
    var token: String!
    var pictures: [Picture] = [Picture]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let albumID = album?.id else {return}
        
        GraphRequest(graphPath: "/\(albumID)/photos", parameters: ["fields":"id,name,picture"], httpMethod: GraphRequestHTTPMethod(rawValue: "GET")!)
            .start({  connection, g_response in
                print(g_response)
                switch g_response{
                case .success(let response):
                    
                    (response.dictionaryValue?["data"] as! [Any?]).forEach {value in
                        
                        self.pictures.append(Picture(dictionary: value as! Dictionary<String,Any> ))
                    }
                    self.tableView.reloadData()
                    break
                default:
                    break
                }
            })

        tableView.register(UINib(nibName: "AlbumCell", bundle: nil), forCellReuseIdentifier: "AlbumCell")

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as! AlbumCell
        
        guard let token = AccessToken.current?.authenticationToken,
            let url = URL(string: "https://graph.facebook.com/v2.10/\(pictures[indexPath.row].id)/picture?type=thumbnail&access_token=\(token)")
            else {
                return UITableViewCell()
            }
        
        cell.thumbnail?.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
        cell.thumbnail?.contentMode = .center
        
        cell.label?.text = pictures[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPicture", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPicture" ,
            let nextScene = segue.destination as? PictureViewController ,
            let indexPath = self.tableView.indexPathForSelectedRow {
            nextScene.picture = pictures[indexPath.row]
        }
    }
    
}
