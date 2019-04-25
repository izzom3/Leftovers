//
//  ListingsTableViewController.swift
//  Leftovers
//
//  Created by Matthew Izzo on 3/4/19.
//  Copyright © 2019 Matthew Izzo. All rights reserved.
//

import UIKit

class ListingsTableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingCell1", for: indexPath)
        return cell
    }
    
}
