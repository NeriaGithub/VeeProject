//
//  NotesTableView.swift
//  VeeProject
//
//  Created by Neria Jerafi on 04/09/2020.
//  Copyright © 2020 Neria Jerafi. All rights reserved.
//

import UIKit

protocol NotesTableViewDelegate:class {
    func selectedRowCell(indexPath:IndexPath)
}

class NotesTableView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var table: UITableView!
    
    
    var notesArray:[Note] = []
    var entity = Constants.Entity.notes.rawValue
   weak var notesTableViewDelegate:NotesTableViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("NotesTableView", owner: self, options: nil)
        self.addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        tableViewConfig()
    }
    
    private func tableViewConfig(){
        self.table.dataSource = self
        self.table.delegate = self
        self.table.rowHeight = UITableView.automaticDimension
        self.table.estimatedRowHeight = 70
        let nib = UINib(nibName: "NoteCell", bundle: nil)
        self.table.register(nib, forCellReuseIdentifier: "noteCell")
    }
}

extension NotesTableView:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell") as! NoteCell
        cell.setNoteCell(note: self.notesArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            self.notesTableViewDelegate?.selectedRowCell(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return self.entity == Constants.Entity.notes.rawValue ? false : true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [makeDeleteContextualAction(forRowAt: indexPath)/*,makeEditContextualAction(forRowAt: indexPath)*/,makeRecoverContextualAction(forRowAt: indexPath)])
    }
    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
            self.notesArray.remove(at: indexPath.row)
            self.table.deleteRows(at: [indexPath], with: .fade)
            DataManager.getSharedInstance().deleteNote(entity: self.entity, index: indexPath.row)
            print("Delete action")
            completion(true)
        }
    }
    
//    private func makeEditContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
//        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, swipeButtonView, completion) in
//            print("Edit action")
//            self.notesTableViewDelegate?.selectedRowCell(indexPath: indexPath)
//
//            completion(true)
//        }
//        editAction.backgroundColor = .systemGreen
//        return editAction
//    }
    
    private func makeRecoverContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        let recoverAction =  UIContextualAction(style: .normal, title: "Recover") { (action, swipeButtonView, completion) in
            print("Recover action")
            let recoverNote = self.notesArray.remove(at: indexPath.row)
            DataManager.getSharedInstance().deleteNote(entity: self.entity, index: indexPath.row)
            DataManager.getSharedInstance().createNote(entity: Constants.Entity.notes.rawValue, note: recoverNote)
            self.table.deleteRows(at: [indexPath], with: .fade)
            completion(true)
        }
        recoverAction.backgroundColor = .systemOrange
        return recoverAction
    }
    
    
}
