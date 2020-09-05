//
//  CreateAndEditNoteVC.swift
//  VeeProject
//
//  Created by Neria Jerafi on 04/09/2020.
//  Copyright © 2020 Neria Jerafi. All rights reserved.
//

import UIKit

class CreateAndEditNoteVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var clickToEdit: UIButton!
    
    //MARK: - Properties
    var editNoteTuple:(note:Note?, index:Int?, entity:String) = (nil,nil,Constants.Entity.notes.rawValue)

    override func viewDidLoad() {
        super.viewDidLoad()
      setViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.view.endEditing(true)
    }
    
    func textViewConfig() {
        self.noteTextView.delegate = self
    }
    
    func setViews()  {
        textViewConfig()
        if let _ = self.editNoteTuple.index, let note = self.editNoteTuple.note {
            self.noteTextField.text = note.title
            self.noteTextView.text = note.content
            self.titleLabel.text = note.title
            self.contentLabel.text = note.content
        }
        if self.editNoteTuple.entity == Constants.Entity.archive.rawValue{
            self.deleteButton.isHidden = true
        }
        else if self.editNoteTuple.index == nil {
            hideOrShowViews(isEditMode: true)
            self.clickToEdit.isHidden = true
        }
    }

    func hideOrShowViews(isEditMode:Bool) {
            self.contentLabel.isHidden = isEditMode
            self.noteTextView.isHidden = !isEditMode
            self.noteTextField.isHidden = !isEditMode
        self.clickToEdit.isHidden = isEditMode
    }
    
    func editNote()  {
        let date = Date()
        self.editNoteTuple.note = Note(title: self.noteTextField.text!, content: self.noteTextView.text, date: date)
        if self.editNoteTuple.entity == Constants.Entity.notes.rawValue {
            if let unwrappedIndex = self.editNoteTuple.index {
                DataManager.getSharedInstance().updateNote(entity: self.editNoteTuple.entity, index: unwrappedIndex, note: self.editNoteTuple.note!)
            }
            else{
                DataManager.getSharedInstance().createNote(entity: self.editNoteTuple.entity, note: self.editNoteTuple.note!)
            }
        }
        else {
            DataManager.getSharedInstance().deleteNote(entity: self.editNoteTuple.entity, index: self.editNoteTuple.index!)
            DataManager.getSharedInstance().createNote(entity: Constants.Entity.notes.rawValue, note: self.editNoteTuple.note!)
        }
        self.titleLabel.text = self.noteTextField.text!
        self.contentLabel.text = self.noteTextView.text
    }
    
    func deleteNote() {
        guard let unwrappedIndex = self.editNoteTuple.index else { return}
            DataManager.getSharedInstance().deleteNote(entity: self.editNoteTuple.entity, index: unwrappedIndex)
            DataManager.getSharedInstance().createNote(entity: Constants.Entity.archive.rawValue, note: self.editNoteTuple.note!)
    }
    
    func noteIsFull() -> Bool {
        return !self.noteTextField.text!.isEmpty && !self.noteTextView.text.isEmpty ? true : false
    }
    
    func showAlert() {
         let alert = UIAlertController(title: "You must fill in all the fields", message: nil, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "Ok", style: .default))
         self.present(alert, animated: true)
     }
    
    func backToPreviousVC()  {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: - IBActions
    @IBAction func doneClick(_ sender: UIButton) {
        if noteIsFull() {
            editNote()
            hideOrShowViews(isEditMode: false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.backToPreviousVC()
            }
        }
        else{
            showAlert()
        }
    }
    
    @IBAction func deleteClick(_ sender: UIButton) {
        if noteIsFull() {
            deleteNote()
           backToPreviousVC()
        }
        else{
            showAlert()
        }
    }
    
    @IBAction func clickToEdit(_ sender: UIButton) {
        hideOrShowViews(isEditMode: true)
    }
}

//MARK: - UITextViewDelegate  method
extension CreateAndEditNoteVC:UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
