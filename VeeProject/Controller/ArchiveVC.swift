//
//  ArchiveVC.swift
//  VeeProject
//
//  Created by Neria Jerafi on 04/09/2020.
//  Copyright © 2020 Neria Jerafi. All rights reserved.
//

import UIKit

class ArchiveVC: UIViewController {
    
    @IBOutlet weak var archiveView: NotesTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.archiveView.notesTableViewDelegate = self
        self.archiveView.entity = Constants.Entity.archive.rawValue
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.archiveView.notesArray = DataManager.getSharedInstance().retrieveNotes(entity: Constants.Entity.archive.rawValue)
        self.archiveView.table.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let  unwrappedIndexPath = self.archiveView.table.indexPathForSelectedRow {
            let VC = segue.destination as! CreateAndEditNoteVC
            VC.editNoteTuple.entity = Constants.Entity.archive.rawValue
            VC.editNoteTuple.index = unwrappedIndexPath.row
            VC.editNoteTuple.note = self.archiveView.notesArray[unwrappedIndexPath.row]
        }
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

extension ArchiveVC: NotesTableViewDelegate{
    func selectedRowCell(indexPath: IndexPath) {
        performSegue(withIdentifier: "archiveSegue", sender: self)
    }
    
    
}