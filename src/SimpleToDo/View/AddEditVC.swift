//
//  AddEditVC.swift
//  SimpleToDo
//
//  Created by Natchanon A. on 23/10/2561 BE.
//  Copyright © 2561 Natchanon A. All rights reserved.
//

import UIKit

class AddEditVC: UIViewController, UITextViewDelegate {
    
    var isAddScreen: Bool!
    var addEditVM: AddEditVM?
    
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initVM()
        initView()
    }
    
    func initVM() {
        if (isAddScreen) {
            addEditVM = AddEditVM()
        }
    }
    
    func initView() {
        noteTextView.delegate = self
        
        noteTextView.layer.borderWidth = 1
        noteTextView.layer.borderColor = UIColor.init(white: 0, alpha: 0.085).cgColor
        noteTextView.layer.cornerRadius = 5
        
        header.text = (isAddScreen) ? "Add new item" : "Edit item"
        titleTextField.text = (isAddScreen) ? "" : addEditVM!.title
        noteTextView.isEditable = true
        noteTextView.text = (isAddScreen) ? "" : addEditVM!.note
    }

    // Save item when user pressed done button then dismiss the view
    @IBAction func doneBtnPressed(_ sender: Any) {
        addEditVM!.saveItem()
        dismiss(animated: true, completion: nil)
    }

    // Dismiss the view without saving
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Update title and note in view model when textfield/textview changed
    @IBAction private func textFieldDidChange(_ sender: Any) {
        addEditVM!.title = titleTextField.text ?? ""
    }
    func textViewDidChangeSelection(_ textView: UITextView) {
        addEditVM!.note = textView.text ?? ""
    }
    
}
