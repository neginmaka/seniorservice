//
//  PreviousRequestsViewController.swift
//  seniorservice
//
//  Created by Negin Maka on 2023-07-06.
//

import UIKit

class PreviousRequestsViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var data: [Request]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = loadData()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadData() -> [Request] {
        let jsonHelper = JsonHelper()
        let requests = jsonHelper.loadRequestsFromFile()!

        return requests
    }
}

class RequestCell: UITableViewCell {
    @IBOutlet weak var service: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var createdDate: UILabel!

}

extension PreviousRequestsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // no op
    }
}

extension PreviousRequestsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "requestCustomCell", for: indexPath) as! RequestCell
        let item = data[indexPath.row]
        cell.service?.text = item.service
        cell.status?.text = item.status
        cell.createdDate?.text = item.createdDate
        return cell
    }
}
