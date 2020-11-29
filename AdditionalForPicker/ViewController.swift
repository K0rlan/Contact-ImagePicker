//
//  ViewController.swift
//  AdditionalForPicker
//
//  Created by Korlan Omarova on 29.11.2020.
//

import UIKit
import Realm
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var realm = try! Realm()
    let data = try! Realm().objects(ContactBook.self)
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        self.tableView.reloadData()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        cell.img.layer.cornerRadius = cell.img.frame.size.width/2
        cell.img.clipsToBounds = true
        let contact = data[indexPath.row]
        cell.name.text = contact.name
        cell.phone.text = contact.number
        let image: UIImage = UIImage(data: contact.image! as Data)!
        cell.img.image = image
        return cell
    }
    
}
class Cell: UITableViewCell{
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var phone: UILabel!
}
