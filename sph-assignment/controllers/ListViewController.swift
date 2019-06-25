//
//  ViewController.swift
//  sph-assignment
//
//  Created by Kelvin Fok on 25/6/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit

class ListsViewController: UITableViewController {
    
    var yearlyRecords: [YearlyRecord]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupNavigation()
    }
    
    private func setupNavigation() {
        self.navigationItem.title = "Mobile Data Consumption"
    }

    private func fetchData() {
        APIClient.shared.fetch { (result) in
            switch result {
            case .success(let feedResult):
                feedResult.result.getYearlyRecords()?.forEach({ print($0.description) })
                self.yearlyRecords = feedResult.result.getYearlyRecords()
            case .failure(let failure):
                print("failure: \(failure)")
            }
        }
    }
    
    private func recordImageDidTap(year: Int) {
        print("Tapped on year: \(year)")
    }
}

extension ListsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yearlyRecords?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! YearlyRecordTableViewCell
        cell.yearlyRecord = self.yearlyRecords?[indexPath.item]
        cell.didTapOnImageObserver = { [weak self] year in
            self?.recordImageDidTap(year: year)
        }
        return cell
    }
}
