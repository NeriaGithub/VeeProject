//
//  DataManger.swift
//  VeeProject
//
//  Created by Neria Jerafi on 03/09/2020.
//  Copyright © 2020 Neria Jerafi. All rights reserved.
//

import Foundation
import CoreData

class DataManager{
    private static  var sharedInstance:DataManager?
    static func getSharedInstance()->DataManager{
        if DataManager.sharedInstance == nil {
            DataManager.sharedInstance = DataManager()
        }
        return DataManager.sharedInstance!
    }
    private init(){}
    
    private var context:NSManagedObjectContext?

    func setContext(context:NSManagedObjectContext)   {
        self.context = context
    }
    
    // MARK: - CRUD Methods
    func createNote(entity:String, note:Note) {
        let entity = NSEntityDescription.entity(forEntityName: entity, in: self.context!)
        let newNote = NSManagedObject(entity: entity!, insertInto: self.context)
        newNote.setValue(note.title, forKey: Constants.title)
        newNote.setValue(note.content, forKey: Constants.content)
        newNote.setValue(note.date, forKey: Constants.date)
        do{
            try self.context!.save()
        }
        catch{}
    }
    
    func retrieveNotes(entity:String) -> [Note] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        var notes:[Note] = []
        do {
            let result = try self.context!.fetch(request)
            for item in result as! [NSManagedObject]  {
                let title = item.value(forKey: Constants.title) as! String
                let content = item.value(forKey: Constants.content) as! String
                let date = item.value(forKey: Constants.date) as! Date
                notes.append(Note(title: title, content: content, date: date))
            }
        }
        catch  {}
        return notes
    }
    
    func updateNote(entity:String, index:Int, note:Note)  {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        do {
            let result = try self.context!.fetch(request)
            if  let noteToUpdate = result[index] as? NSManagedObject{
                noteToUpdate.setValue(note.title, forKey: Constants.title)
                noteToUpdate.setValue(note.content, forKey: Constants.content)
                noteToUpdate.setValue(note.date, forKey: Constants.date)
                do {
                    try self.context!.save()
                }
                catch  {}
            }
        }
        catch  {}
    }
    
    func deleteNote(entity:String, index:Int) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        do {
            let result = try self.context!.fetch(request)
            if let noteToDelete = result[index] as? NSManagedObject{
                self.context!.delete(noteToDelete)
                do {
                    try self.context?.save()
                }
                catch  {}
            }
        }
        catch  {}
    }
    
    
}
