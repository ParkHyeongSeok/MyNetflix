//
//  ResultCollectionViewCell.swift
//  MyNetflix
//
//  Created by 박형석 on 2021/12/29.
//  Copyright © 2021 com.joonwon. All rights reserved.
//

import UIKit
import Kingfisher

class ResultCollectionViewCell: UICollectionViewCell {
    static let identifier = "ResultCollectionViewCell"
    
    @IBOutlet weak var thumbnail: UIImageView!
    
    func updateUI(movie: Movie) {
        let imageURL = URL(string: movie.thumbnailPath)
        self.thumbnail.kf.setImage(with: imageURL)
    }
}
