//
//  SearchViewController.swift
//  TheGoodBois
//
//  Created by Don Hogan on 4/24/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {

    // MARK: - Outlets
    @IBOutlet weak var ButtonCollection: UICollectionView!

    // MARK: - Properties
    private let reuseIdentifier = "TypeButtonCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)
    private let types = ["dog", "cat", "rabbit", "small",
                         "scaly", "bird", "horse", "other"]
    private var current_type = ""
    
    // MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
    // MARK: - Search functionality
    func getType(for indexPath: IndexPath) -> String {
        print(types[indexPath.section])
        return types[indexPath.section]
    }
    
    func setBreeds(for type: String) {
        
    }

}

// MARK: - UICollectionViewDataSource
extension SearchViewController {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/4, height: collectionView.frame.size.height/2)
    }
    
    
    
    
    
}

// MARK: - Dropdown menu functionality
extension SearchViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        <#code#>
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        <#code#>
    }
    
    
}
