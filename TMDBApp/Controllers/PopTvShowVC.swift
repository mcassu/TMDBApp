//
//  ViewController.swift
//  TMDBApp
//
//  Created by Cassu on 20/01/21.
//

import UIKit

class PopTvShowVC: UIViewController {
    
    private var tvShowListVM: TvShowListViewModel!
    private var collectionView: UICollectionView?
    private var page = 1
    private var isLoading = false
    private let radQueue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension PopTvShowVC {
    
    func setupUI() {
        navigationItem.title = "Séries Populares"
        let backButton = UIBarButtonItem()
        backButton.title = "Voltar"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(fetchTrendTv))
        navigationItem.rightBarButtonItem  = refreshButton
        view.backgroundColor = .systemBackground
        
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
        
        fetchTrendTv()
        
    }
    
    @objc private func fetchTrendTv() {
        page = 1
        Alert.loading(isLoading: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let operation1 = BlockOperation {
                let group = DispatchGroup()
                group.enter()
                Webservice().getGenre { Genre in
                    let kLIST_GENRE = "kLIST_GENRE"
                    let jsonData = try! JSONEncoder().encode(Genre)
                    UserDefaults.standard.set(jsonData, forKey: kLIST_GENRE)
                    group.leave()
                }
                group.enter()
                Webservice().getPopTvS(page: self.page) { tvShows in
                    if let tvShows = tvShows {
                        self.tvShowListVM = TvShowListViewModel(TvShows: tvShows)
                        self.page = self.page + 1
                        DispatchQueue.main.async {
                            group.leave()
                        }
                    }else {
                        group.leave()
                    }
                }
                group.wait()
            }
            let operation2 = BlockOperation {
                DispatchQueue.main.async {
                    Alert.loading(isLoading: false)
                    self.collectionView?.reloadData()
                    guard let _ = self.tvShowListVM else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            Alert.error(avm: alertViewModel(title: "Desculpe-nos", msg: "Algo de errado aconteceu,\nTente novamente,\nVerifique sua chave."))
                        }
                        return
                    }
                    self.scrollToTop()
                }
            }
            operation2.addDependency(operation1)
            self.radQueue.addOperation(operation1)
            self.radQueue.addOperation(operation2)
            
            
        }
    }
    
    func scrollToTop() {
        let indexPath = IndexPath(row: 0, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .top, animated: true)
    }
}

extension PopTvShowVC: UICollectionViewDataSource {
    
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

extension PopTvShowVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tvsvm = self.tvShowListVM.newAtIndex(indexPath.row)
        let detailVC = DetailTvShowVC(tvsvm)
        detailVC.hidesBottomBarWhenPushed = true
        self.show(detailVC, sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.tvShowListVM.count() - 1{
            if !isLoading {
                fetchMoreData()
            }
        }
    }

    func fetchMoreData(){
        isLoading = true
        Webservice().getPopTvS(page: page) { tvShows in
            if let tvShows = tvShows {
                DispatchQueue.main.async {
                    self.page = self.page + 1
                    self.tvShowListVM.appendItens(tvShows) {
                        self.collectionView?.reloadData()
                        self.isLoading = false
                    }
                }
            }else {
                self.isLoading = false
            }
        }
    }
}


extension PopTvShowVC: UICollectionViewDelegateFlowLayout {
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
