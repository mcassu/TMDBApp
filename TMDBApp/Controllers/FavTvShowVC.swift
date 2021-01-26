//
//  FavTvShowVC.swift
//  TMDBApp
//
//  Created by Cassu on 20/01/21.
//

import UIKit

class FavTvShowVC: UIViewController {
    
    private var tvShowListVM: TvShowListViewModel!
    private var divisor: CGFloat = 0.0
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        
        let c = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        c.translatesAutoresizingMaskIntoConstraints = false
        c.backgroundColor = .systemBackground
        c.register(TvShowCollectionViewCell.self, forCellWithReuseIdentifier:
                    TvShowCollectionViewCell.Identifier)
        return c
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        divisor.updateCellSize()
    }
    
}

extension FavTvShowVC {
    
    private func setupUI() {
        navigationItem.title = "Séries Favoritadas"
        let backButton = UIBarButtonItem()
        backButton.title = "Voltar"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        
        let safeArea = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        divisor.updateCellSize(isInitial: true)

    }
    
    private func setupData() {
        guard let tvFavList = CRUD().Read() else {
            Alert.error(avm: alertViewModel(title: "Alerta", msg: "Você ainda não favoritou nenhuma série,\n volte na aba ao lado e escolha quantas quiser."))
            tvShowListVM = TvShowListViewModel(TvShows: [])
            collectionView.reloadData()
            return
        }
        tvShowListVM = TvShowListViewModel(TvShows: tvFavList)
        collectionView.reloadData()
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
        let width = collectionView.bounds.width/divisor
        let height = width * 1.7
        return CGSize(width: width, height: height)
    }
}



