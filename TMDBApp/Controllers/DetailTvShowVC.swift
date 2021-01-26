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
    
    private var scrollView: UIScrollView = {
        let c = UIScrollView(frame: .zero)
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    private let scrollViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let infoShowView: UIView = {
        let view = UIView()
        if UIDevice.current.userInterfaceIdiom == .pad {
            view.heightAnchor.constraint(equalToConstant: 450).isActive = true
        }else {
            view.heightAnchor.constraint(equalToConstant: 400).isActive = true
        }
        return view
    }()
    
    private let backOverviewView: UIView = {
        let view = UIView()
        return view
    }()
    
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
        if UIDevice.current.userInterfaceIdiom == .pad {
            iv.widthAnchor.constraint(equalToConstant: 300).isActive = true
        }else {
            iv.widthAnchor.constraint(equalToConstant: 200).isActive = true
        }
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
        bt.widthAnchor.constraint(equalToConstant: 50).isActive = true
        bt.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
    
    private let tvOverview: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 25)
        lb.textColor = .label
        lb.textAlignment = .natural
        lb.adjustsFontSizeToFitWidth = true
        lb.minimumScaleFactor = 0.5
        lb.numberOfLines = 0
        return lb
    }()
    
    private lazy var stackViewInfo: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [lbTitle, lbGender, lbRatening, lbCountVotes])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    private lazy var stackViewOverview: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [lbOverview, tvOverview])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 8
        return stack
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
    
    private func setupUI(){
        navigationItem.title = tvShowVM.title
        
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        
        scrollView.frame = view.bounds
        scrollView.addSubview(scrollViewContainer)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    
        setupContainer(scrollViewContainer)
        setupData()

    }
    
    private func setupContainer(_ container: UIStackView) {
       
        container.addArrangedSubview(infoShowView)
        container.addArrangedSubview(backOverviewView)

        infoShowView.addSubview(ivBanner)
        infoShowView.addSubview(stackViewInfo)
        infoShowView.addSubview(ivPoster)
        infoShowView.addSubview(btFav)
        
        backOverviewView.addSubview(stackViewOverview)
        
        NSLayoutConstraint.activate([
            btFav.topAnchor.constraint(equalTo: ivPoster.bottomAnchor, constant: -40),
            btFav.leftAnchor.constraint(equalTo: ivPoster.rightAnchor, constant: -30),
        
            ivPoster.topAnchor.constraint(equalTo: ivBanner.topAnchor, constant: 16),
            ivPoster.leftAnchor.constraint(equalTo: ivBanner.leftAnchor, constant: 16),
            ivPoster.bottomAnchor.constraint(equalTo: ivBanner.bottomAnchor, constant: -16),
            
            stackViewInfo.topAnchor.constraint(equalTo: ivPoster.topAnchor, constant: 8),
            stackViewInfo.leftAnchor.constraint(equalTo: ivPoster.rightAnchor, constant: 8),
            stackViewInfo.rightAnchor.constraint(equalTo: ivBanner.rightAnchor, constant: -8),
            
            ivBanner.topAnchor.constraint(equalTo: infoShowView.topAnchor),
            ivBanner.leftAnchor.constraint(equalTo: infoShowView.leftAnchor),
            ivBanner.rightAnchor.constraint(equalTo: infoShowView.rightAnchor),
            ivBanner.bottomAnchor.constraint(equalTo: infoShowView.bottomAnchor),
            
            stackViewOverview.topAnchor.constraint(equalTo: backOverviewView.topAnchor),
            stackViewOverview.leftAnchor.constraint(equalTo: backOverviewView.leftAnchor, constant: 16),
            stackViewOverview.rightAnchor.constraint(equalTo: backOverviewView.rightAnchor, constant: -16),
            stackViewOverview.bottomAnchor.constraint(equalTo: backOverviewView.bottomAnchor)
        ])
    }
    
    private func setupData(){
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
    
    @objc private func FavAction(_ sender: UIButton){
        let color = CRUD().Update(tvShow: self.tvShowVM.toCRUD())
        sender.setImage(UIImage(named: "like")?.tint(with: color), for: .normal)
    }
}
