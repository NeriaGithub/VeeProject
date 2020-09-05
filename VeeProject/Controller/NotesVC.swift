//
//  ViewController.swift
//  VeeProject
//
//  Created by Neria Jerafi on 03/09/2020.
//  Copyright © 2020 Neria Jerafi. All rights reserved.
//

import UIKit

class NotesVC: UIViewController {

    @IBOutlet weak var notesView: NotesTableView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        DataManager.getSharedInstance().setContext(context: context)
        self.notesView.notesTableViewDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.notesView.notesArray = DataManager.getSharedInstance().retrieveNotes(entity: Constants.Entity.notes.rawValue)
        self.notesView.table.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue" {
            if let unwrappedIndexPath = self.notesView.table.indexPathForSelectedRow {
                let VC = segue.destination as! CreateAndEditNoteVC
                VC.editNoteTuple.entity = Constants.Entity.notes.rawValue
                VC.editNoteTuple.index = unwrappedIndexPath.row
                VC.editNoteTuple.note = self.notesView.notesArray[unwrappedIndexPath.row]
            }
        }
    }
}

extension NotesVC:NotesTableViewDelegate{
    func selectedRowCell(indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editSegue", sender: self)
    }
    
    
}

