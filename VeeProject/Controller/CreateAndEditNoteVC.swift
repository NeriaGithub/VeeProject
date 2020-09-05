//
//  CreateAndEditNoteVC.swift
//  VeeProject
//
//  Created by Neria Jerafi on 04/09/2020.
//  Copyright © 2020 Neria Jerafi. All rights reserved.
//

import UIKit

class CreateAndEditNoteVC: UIViewController {
    
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var editNoteTuple:(note:Note?, index:Int?, entity:String) = (nil,nil,Constants.Entity.notes.rawValue)

    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.editNoteTuple.entity == Constants.Entity.archive.rawValue {
            self.deleteButton.isHidden = true
        }
    }
    
    func textViewConfig() {
        self.noteTextView.delegate = self
    }
    
    func setViews()  {
        textViewConfig()
        if let _ = self.editNoteTuple.index, let note = self.editNoteTuple.note {
            self.noteTextField.text = note.title
            self.noteTextView.text = note.content
        }
        
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
    }
    
    func deleteNote() {
        guard let unwrappedIndex = self.editNoteTuple.index else { return}
            DataManager.getSharedInstance().deleteNote(entity: self.editNoteTuple.entity, index: unwrappedIndex)
            DataManager.getSharedInstance().createNote(entity: Constants.Entity.archive.rawValue, note: self.editNoteTuple.note!)
    }
    
    func noteIsFull() -> Bool {
        return !self.noteTextField.text!.isEmpty && !self.noteTextView.text.isEmpty ? true : false
    }
    
    func backToRootVC() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    func backToPreviousVC()  {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func updateClick(_ sender: UIButton) {
        if noteIsFull() {
            editNote()
            backToRootVC()
        }
    }
    
    @IBAction func deleteClick(_ sender: UIButton) {
        if noteIsFull() {
            deleteNote()
           backToPreviousVC()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CreateAndEditNoteVC:UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
