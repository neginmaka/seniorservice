//
//  PreviousRequestsViewController.swift
//  seniorservice
//
//  Created by Negin Maka on 2023-07-06.
//

import UIKit

class PreviousRequestsViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    // TODO: Fetch the user requests from server to populate proper list for the previous requests
    let data = [("Plumbing Jun 7", "Pending"), ("Painting Feb 24", "Done"), ("Physio May 11", "Cancelled")]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension PreviousRequestsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me!")
    }
}

extension PreviousRequestsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = data[indexPath.row]
        cell.textLabel?.text = item.0
        cell.detailTextLabel?.text = item.1
        return cell
    }
}
