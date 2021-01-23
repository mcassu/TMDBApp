//
//  TvShowCollectionViewCell.swift
//  TMDBApp
//
//  Created by Cassu on 20/01/21.
//

import UIKit
import SDWebImage

class TvShowCollectionViewCell: UICollectionViewCell {
    
    public static let Identifier = "TvShowCell"
    
    private let ivPoster: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.clipsToBounds = true
        iv.backgroundColor = .darkGray
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    private let lbTitle: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.textColor = .label
        lb.adjustsFontSizeToFitWidth = true
        lb.minimumScaleFactor = 0.5
        lb.numberOfLines = 2
        lb.textAlignment = .center
        return lb
    }()
    
    override init(frame: CGRect) {
         super.init(frame: frame)
        
        
        let stackView: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [ivPoster, lbTitle])
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.distribution = .fill
            stack.axis = .vertical
            stack.spacing = 8
            return stack
        }()
        
        contentView.addSubview(stackView)
        
        lbTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        
     }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(tvshowVM: TvShowViewModel) {
       
        lbTitle.text = tvshowVM.title
        
        guard let urlToDownImage = tvshowVM.urlToPosterImage else {
            ivPoster.isHidden = true
            return
        }
        
        ivPoster.sd_imageIndicator = SDWebImageActivityIndicator.white
        ivPoster.sd_setImage(with: urlToDownImage)
    }
}
