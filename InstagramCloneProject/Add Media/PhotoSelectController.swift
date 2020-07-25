//
//  PhotoSelectController.swift
//  InstagramCloneProject
//
//  Created by halil ibrahim baykan on 23/07/2020.
//  Copyright © 2020 halil ibrahim baykan. All rights reserved.
//

import UIKit
import Photos

class PhotoSelectController: UICollectionViewController {
let cellId = "cellId"
let headerId = "headerId"
    override func viewDidLoad() {
        super.viewDidLoad()
       
        collectionView.backgroundColor = .yellow
        addButtons()
        
        collectionView.register(PhotoSelectCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(PhotoSelectHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        fetchPhotos()
    }
    
    var selectedPhoto:UIImage?
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        selectedPhoto = photos[indexPath.row]
        collectionView.reloadData()
        
    }

    var photos = [UIImage]()
    
    fileprivate func fetchPhotos(){
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 10
        
        let sortConfig = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortConfig]
        
        let photos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        photos.enumerateObjects { (asset, number, stoppingPoint) in
            //asset: there are all photos
            //number: which photo fetching. it starts 0
            //stoppingPoint: keeps the info/address of stopping point
            
            let imageManager = PHImageManager.default()
            let imageSize = CGSize(width: 400, height: 400)
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFit, options: options) { (image, imageInfo) in
                if let photo = image{
                    self.photos.append(photo)
                    if self.selectedPhoto == nil{
                        self.selectedPhoto = image
                    }
                    
                }
                if number == photos.count - 1{
                    self.collectionView.reloadData()
                }
            }
            
            
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PhotoSelectHeader
        header.imgHeader.image = selectedPhoto
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize { // it triggers to execute creating header
        let width = view.frame.width
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets { // it uses for useally give some spaces inside of this item.
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotoSelectCell
        cell.imgPhoto.image = photos[indexPath.row]
        return cell
    }

    override var prefersStatusBarHidden: Bool { // it doesn't work at first we need config navbar
        return true
    }
    
    fileprivate func addButtons(){
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonClicked))
    }
    @objc func cancelButtonClicked(){
        dismiss(animated: true, completion: nil) // when you press it, it dismiss current view immediately
    }

}

extension UINavigationController{
    open override var childForStatusBarHidden: UIViewController?{
        return self.topViewController
    }
}
