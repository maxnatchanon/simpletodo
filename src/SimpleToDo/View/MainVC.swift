//
//  MainVC.swift
//  SimpleToDo
//
//  Created by Natchanon A. on 23/10/2561 BE.
//  Copyright © 2561 Natchanon A. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var popUpBgDimView: UIView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var popUpTitleLbl: UILabel!
    @IBOutlet weak var popUpNoteLbl: UILabel!
    
    var popUpIndexPath: IndexPath?
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
        popUpIndexPath = nil
        popUpBgDimView.alpha = 0
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
        tableView.rowHeight = 55
        
        popUpView.layer.cornerRadius = 15
        popUpView.layer.masksToBounds = true
        editBtn.layer.cornerRadius = 8
        deleteBtn.layer.cornerRadius = 8
        popUpBgDimView.alpha = 0
        
        let closePopUpGesture = UITapGestureRecognizer(target: self, action: #selector(self.closePopUp))
        closePopUpGesture.delegate = self
        popUpBgDimView.addGestureRecognizer(closePopUpGesture)
        popUpBgDimView.isUserInteractionEnabled = true
    }
    
    // Button functions
    @IBAction func addBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "MainToAddEdit", sender: nil)
    }
    @IBAction func editBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "MainToAddEdit", sender: popUpIndexPath)
    }
    @IBAction func deleteBtnPressed(_ sender: Any) {
        let alert = UIAlertController.init(title: "Delete this item?", message: "This action cannot be undone.", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Delete", style: .destructive, handler: { (action: UIAlertAction!) in
            self.mainVM.deleteItem(at: self.popUpIndexPath!) {
                UIView.animate(withDuration: 0.25) {
                    self.popUpBgDimView.alpha = 0
                }
                self.popUpIndexPath = nil
                self.mainVM.fetchData()
                self.tableView.reloadData()
            }
        }))
        alert.addAction(UIAlertAction.init(title: "Back", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // Close current pop up
    // Will be called when user tap the dimmed background
    @objc func closePopUp() {
        if (popUpIndexPath == nil) { return }
        UIView.animate(withDuration: 0.25) {
            self.popUpBgDimView.alpha = 0
        }
        popUpIndexPath = nil
    }
    
    // To disable gesture recognizer on child views
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view!.isDescendant(of: self.popUpView){
            return false
        }
        return true
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
        cell.title.text = cellData.title
        cell.toggleFinishedClosure = { [weak self] () in
            self?.mainVM.toggleFinished(at: indexPath)
        }
        cell.checkBtn.setImage(UIImage.init(named: (cellData.finished) ? "checked" : "unchecked"), for: .normal)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        popUpIndexPath = indexPath
        let popUpItem = mainVM.getItem(at: indexPath)
        popUpTitleLbl.text = popUpItem.title
        popUpNoteLbl.text = popUpItem.note
        UIView.animate(withDuration: 0.25) {
            self.popUpBgDimView.alpha = 1
        }
    }
    
}

// Prepare for segue
// Decide to go to add or edit screen by checking sender value
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
