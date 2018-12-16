//
//  MainVC.swift
//  SimpleToDo
//
//  Created by Natchanon A. on 23/10/2561 BE.
//  Copyright © 2561 Natchanon A. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var mainVM : MainVM = {
        return MainVM()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initVM()
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainVM.fetchData()
        tableView.reloadData()
    }
    
    func initVM() {
        mainVM.reloadTableViewClosure = { [weak self] () in
            self?.tableView.reloadData()
        }
        mainVM.fetchData()
    }
    
    func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "MainToAddEdit", sender: nil)
    }
    
}

// Tableview functions
extension MainVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainVM.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? TableViewCell else {
            fatalError("Cell not found")
        }
        
        let cellData = mainVM.getItem(at: indexPath)
        
        // Set title, toggle closure and image for each cell
        cell.title.text = cellData.title
        cell.toggleFinishedClosure = { [weak self] () in
            self?.mainVM.toggleFinished(at: indexPath)
        }
        cell.checkBtn.setImage(UIImage.init(named: (cellData.finished) ? "checked" : "unchecked"), for: .normal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Show detail popup
    }
    
}

// Prepare for segue
extension MainVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MainToAddEdit") {
            if let addEditVC = segue.destination as? AddEditVC {
                if (sender == nil) {
                    addEditVC.isAddScreen = true
                } else {
                    addEditVC.isAddScreen = false
                    addEditVC.addEditVM = self.mainVM.getAddEditVM(at: sender as! IndexPath)
                }
            }
        }
    }
}
