//
//  NoteCell.swift
//  VeeProject
//
//  Created by Neria Jerafi on 04/09/2020.
//  Copyright © 2020 Neria Jerafi. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Cell set method
    func setNoteCell(note:Note) {
        self.titleLabel.text = note.title
        self.contentLabel.text = note.content
        self.dateLabel.text = note.date.getDateString()
    }
}
