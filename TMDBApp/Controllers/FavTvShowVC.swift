//
//  FavTvShowVC.swift
//  TMDBApp
//
//  Created by Cassu on 20/01/21.
//

import UIKit

class FavTvShowVC: UIViewController {
    
    private var tvShowListVM: TvShowListViewModel!
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reloadShowView()
    }
}

extension FavTvShowVC {
    
    func setupUI() {
        navigationItem.title = "Séries Favoritadas"
        let backButton = UIBarButtonItem()
        backButton.title = "Voltar"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.backgroundColor = .systemBackground
        collectionView?.register(TvShowCollectionViewCell.self, forCellWithReuseIdentifier:
                                    TvShowCollectionViewCell.Identifier)
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        
        view.addSubview(collectionView!)
        
        let safeArea = view.layoutMarginsGuide
        
        collectionView?.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        collectionView?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    
    }
    
    func reloadShowView(){
        guard let tvFavList = CRUD().Read() else {
            Alert.error(avm: alertViewModel(title: "Alerta", msg: "Você ainda não favoritou nenhuma série,\n volte na aba ao lado e escolha quantas quiser."))
            tvShowListVM = TvShowListViewModel(TvShows: [])
            collectionView?.reloadData()
            return
        }
        
        tvShowListVM = TvShowListViewModel(TvShows: tvFavList)
        collectionView?.reloadData()
    }
}

extension FavTvShowVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.tvShowListVM == nil ? 0 : self.tvShowListVM.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tvShowListVM.numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TvShowCollectionViewCell.Identifier, for: indexPath) as?
                TvShowCollectionViewCell else {
            fatalError("Cell not found")
        }
          let tvShowVM = self.tvShowListVM.newAtIndex(indexPath.row)
           cell.setup(tvshowVM: tvShowVM)
        return cell
    }
}

extension FavTvShowVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tvsvm = self.tvShowListVM.newAtIndex(indexPath.row)
        let detailVC = DetailTvShowVC(tvsvm)
        detailVC.hidesBottomBarWhenPushed = true
        self.show(detailVC, sender: nil)
    }
}

extension FavTvShowVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var Divisor: CGFloat = 0.0
        if UIDevice.current.userInterfaceIdiom == .pad {
            Divisor = 3.1
        }else {
            Divisor = 2.1
        }
        
        let width = collectionView.bounds.width/Divisor
        let height = width * 1.7
        return CGSize(width: width, height: height)
    }
}
