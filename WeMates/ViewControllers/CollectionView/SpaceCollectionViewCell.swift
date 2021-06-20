//
//  SpaceCollectionViewCell.swift
//  WeMates
//
//  Created by Senuda Ratnayake on 6/20/21.
//

import UIKit

class SpaceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bubbleNameLabel: UILabel!
    @IBOutlet weak var bubbleGroupImage: UIImageView!
    
    override func draw(_ rect: CGRect) { //Your code should go here.
        super.draw(rect)
            self.layer.cornerRadius = self.frame.size.width / 2
        }
}
