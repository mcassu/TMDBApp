//
//  DetailTrendTvShowVC.swift
//  TMDBApp
//
//  Created by Cassu on 20/01/21.
//

import UIKit
import SDWebImage

class DetailTvShowVC: UIViewController {
    
    private var tvShowVM: TvShowViewModel!
    
    private let ivBanner: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.clipsToBounds = true
        iv.backgroundColor = .darkGray
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.alpha = 0.3
        return iv
    }()
    
    private let ivPoster: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    private let lbTitle: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 35)
        lb.textColor = .label
        lb.adjustsFontSizeToFitWidth = true
        lb.minimumScaleFactor = 0.5
        lb.numberOfLines = 2
        return lb
    }()
    
    
    private let lbGender: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        lb.textColor = .label
        lb.adjustsFontSizeToFitWidth = true
        lb.minimumScaleFactor = 0.5
        lb.numberOfLines = 2
        return lb
    }()
    
    private let lbRatening: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 20)
        lb.textColor = .label
        lb.adjustsFontSizeToFitWidth = true
        lb.minimumScaleFactor = 0.5
        lb.numberOfLines = 2
        return lb
    }()
    
    private let lbCountVotes: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 20)
        lb.textColor = .label
        lb.adjustsFontSizeToFitWidth = true
        lb.minimumScaleFactor = 0.5
        lb.numberOfLines = 2
        return lb
    }()
    
    private let btFav: UIButton = {
        
        let bt = UIButton(type: .custom)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.backgroundColor = UIColor.init(named: "AccentColor")
        bt.clipsToBounds = true
        bt.layer.cornerRadius = 25
        return bt
        
    }()
    
    private let lbOverview: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 22)
        lb.textColor = .label
        lb.adjustsFontSizeToFitWidth = true
        lb.minimumScaleFactor = 0.5
        lb.numberOfLines = 1
        lb.text = "Sinopse"
        return lb
    }()
    
    let tvOverview: UITextView = {
        let c = UITextView()
        c.textAlignment = .justified
        c.textColor = .label
        c.backgroundColor = .clear
        c.isEditable = false
        c.font = .systemFont(ofSize: 25)
        return c
    }()
    

    init(_ TvShowVM: TvShowViewModel) {
        tvShowVM = TvShowVM
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
extension DetailTvShowVC {
    
    func setupUI(){
        navigationItem.title = tvShowVM.title
        view.backgroundColor = .systemBackground
        
        let stackView: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [lbTitle, lbGender, lbRatening, lbCountVotes])
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.distribution = .fill
            stack.axis = .vertical
            stack.spacing = 16
            return stack
        }()
        
        let stackViewOverview: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [lbOverview, tvOverview])
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.distribution = .fill
            stack.axis = .vertical
            stack.spacing = 8
            return stack
        }()
        
        view.addSubview(ivBanner)
        view.addSubview(stackView)
        view.addSubview(ivPoster)
        view.addSubview(btFav)
        view.addSubview(stackViewOverview)
        
        let safeArea = view.layoutMarginsGuide
        
        btFav.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btFav.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btFav.topAnchor.constraint(equalTo: ivPoster.bottomAnchor, constant: -40).isActive = true
        btFav.leftAnchor.constraint(equalTo: ivPoster.rightAnchor, constant: -30).isActive = true
        
        var multiplier: CGFloat = 0.0
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            multiplier = 0.35
        }else {
            multiplier = 0.55
        }
        
        ivPoster.widthAnchor.constraint(equalToConstant: view.frame.width * multiplier).isActive = true
        ivPoster.topAnchor.constraint(equalTo: ivBanner.topAnchor, constant: 16).isActive = true
        ivPoster.leftAnchor.constraint(equalTo: ivBanner.leftAnchor, constant: 16).isActive = true
        ivPoster.bottomAnchor.constraint(equalTo: ivBanner.bottomAnchor, constant: -16).isActive = true
        
        stackView.topAnchor.constraint(equalTo: ivPoster.topAnchor, constant: 8).isActive = true
        stackView.leftAnchor.constraint(equalTo: ivPoster.rightAnchor, constant: 8).isActive = true
        stackView.rightAnchor.constraint(equalTo: ivBanner.rightAnchor, constant: -8).isActive = true
        
        ivBanner.heightAnchor.constraint(equalToConstant: view.frame.height * 0.4).isActive = true
        ivBanner.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0).isActive = true
        ivBanner.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        ivBanner.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
        stackViewOverview.topAnchor.constraint(equalTo: ivBanner.bottomAnchor, constant: 16).isActive = true
        stackViewOverview.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        stackViewOverview.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        stackViewOverview.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0).isActive = true

        setupData()

    }
    
    func setupData(){
        lbTitle.text = tvShowVM.title
        lbGender.text = tvShowVM.genderIds
        lbRatening.text = tvShowVM.avaregeVote
        lbCountVotes.text = tvShowVM.totalVote
        tvOverview.text = tvShowVM.overview
        if CRUD().Verify(id: tvShowVM._id).0 {
            btFav.setImage(UIImage(named: "like")?.tint(with: .darkGray), for: .normal)
        }else {
            btFav.setImage(UIImage(named: "like")?.tint(with: .white), for: .normal)
        }
        btFav.addTarget(self, action: #selector(FavAction(_:)), for: .touchUpInside)
        
        guard let urlToDownPImage = tvShowVM.urlToPosterImage else {
            return
        }
        ivPoster.sd_imageIndicator = SDWebImageActivityIndicator.white
        ivPoster.sd_setImage(with: urlToDownPImage)
        
        guard let urlToDownBImage = tvShowVM.urlToBannerImage else {
            return
        }
        ivBanner.sd_imageIndicator = SDWebImageActivityIndicator.white
        ivBanner.sd_setImage(with: urlToDownBImage)
    }
    
    @objc func FavAction(_ sender: UIButton){
        let color = CRUD().Update(tvShow: self.tvShowVM.toCRUD())
        sender.setImage(UIImage(named: "like")?.tint(with: color), for: .normal)
    }
}
