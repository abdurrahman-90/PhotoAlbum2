//
//  ViewController.swift
//  PhotoAlbum2
//
//  Created by Akdag on 18.02.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        
        title = "Photo Album2"
        
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl"){
                pictures.append(item)
            }
        }
        pictures = pictures.sorted()
        
    
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        
        collectionView.allowsMultipleSelection = editing
        let indexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in indexPaths {
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
            cell.isInEditingMode = editing
        }
    }
    
    @IBAction func deleteItem(_ sender: Any) {
        
        if let selectedCells = collectionView.indexPathsForSelectedItems {
             // 1
             let items = selectedCells.map { $0.item }.sorted().reversed()
             // 2
             for item in items {
                 pictures.remove(at: item)
             }
             // 3
             collectionView.deleteItems(at: selectedCells)
             deleteButton.isEnabled = false
           }
    }
  

   
}

extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else{ fatalError("System Error")}
       let row = pictures[indexPath.row]
        
        cell.imageName.text = row
        cell.imageView.image = UIImage(named: row)
       
        return cell
         
    }
    
    
    
}
extension ViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if !isEditing{
            deleteButton.isEnabled = false
        }else{
            deleteButton.isEnabled = true
        }
        
        if let selectItem = collectionView.indexPathsForSelectedItems , selectItem.count == 0 {
            deleteButton.isEnabled = true
        }
      
       
        
       
    }
    
    
    
}


