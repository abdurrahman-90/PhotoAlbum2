//
//  CollectionViewCell.swift
//  PhotoAlbum2
//
//  Created by Akdag on 18.02.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
 
    
    
    var isInEditingMode : Bool = false {
        didSet{
            imageName.isHidden = !isInEditingMode
        }
    }
    
    override var isSelected: Bool{
        didSet{
            if isInEditingMode {
                imageName.text = isSelected ? "✓" : ""
            }
        }
    }
    
    
}
