//
//  PreviewAttachmentViewController.swift
//  time-board
//
//  Created by Tianid on 09.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class PreviewAttachmentViewController: UIViewController {
    
    //MRAK: - Properties
    var images: [UIImage]
    private var task: Task
    private var currentPage: CGFloat = 0
    private var topViewHeight: NSLayoutConstraint?
    private var bottomViewHeight: NSLayoutConstraint?
    
    private var viewsHeight: CGFloat {
        let orientation = UIDevice.current.orientation
        if orientation == .portrait || orientation == .portraitUpsideDown {
            return 100
        }
        return 50
    }
    
    private var bottomView: UIView! = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var navBar: UINavigationBar! = {
        let navBar = UINavigationBar()
        let item = UINavigationItem()
        item.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
        item.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)
        navBar.items = [item]
        navBar.backgroundColor = UIColor.white
        return navBar
    }()
    
    private var fileNameLabel: UILabel! = {
        let label = UILabel()
        label.text = "FILE NAME"
        return label
    }()
    private var fileSizeLabel: UILabel! = {
        let label = UILabel()
        label.text = "FILE SIZE"
        return label
    }()
    
    private var collectionView: UICollectionView! = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collection.isPagingEnabled = true
        collection.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return collection
    }()
    
    //MARK: - Init
    
    init(images: [UIImage], task: Task, startImage: Int) {
        self.images = images
        self.task = task
        self.currentPage = CGFloat(startImage)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Func
    
    private func setuConstraints() {
        
        self.view.addSubview(navBar)
        self.view.addSubview(collectionView)
        
        navBar.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                      leading: view.leadingAnchor,
                      trailing: view.trailingAnchor)
        
        collectionView.anchor(top: navBar.bottomAnchor,
                              leading: view.safeAreaLayoutGuide.leadingAnchor,
                              bottom: view.safeAreaLayoutGuide.bottomAnchor,
                              trailing: view.safeAreaLayoutGuide.trailingAnchor)
        
        self.view.backgroundColor = UIColor(red: 247/255, green: 246/255, blue: 246/255, alpha: 1)
        collectionView.backgroundColor = .orange

//        self.view.addSubview(bottomView)
//        bottomView.addSubview(fileNameLabel)
//        bottomView.addSubview(fileSizeLabel)
        

        
//        bottomView.anchor(leading: view.safeAreaLayoutGuide.leadingAnchor,
//                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
//                          trailing: view.safeAreaLayoutGuide.trailingAnchor)
//
//        bottomViewHeight = bottomView.heightAnchor.constraint(equalToConstant: viewsHeight)
//
//        NSLayoutConstraint.activate([
//            bottomViewHeight!
//        ])
        
//        fileNameLabel.anchor(top: bottomView.topAnchor,
//                             leading: bottomView.leadingAnchor,
//                             bottom: fileSizeLabel.topAnchor,
//                             trailing: bottomView.trailingAnchor,
//                             padding: UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 10))
//
//        fileSizeLabel.anchor(
//            leading: bottomView.leadingAnchor,
//            bottom:  bottomView.bottomAnchor,
//            trailing: bottomView.trailingAnchor,
//            padding: UIEdgeInsets(top: 0, left: 5, bottom: 5, right: 10))
        
        
//        topView.backgroundColor = .yellow
//        bottomView.backgroundColor = .yellow
//        scrollView.backgroundColor = .green
//        fileNameLabel.backgroundColor = .gray
//        fileSizeLabel.backgroundColor = .lightGray
    }
    
    private func changeHeightView() {
        topViewHeight?.constant = viewsHeight
        bottomViewHeight?.constant = viewsHeight
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImagePreviewCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setuConstraints()
        setupCollectionView()
        
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        changeHeightView()        
        currentPage = ceil(collectionView.contentOffset.x / size.height)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //        topView.setGradient(bounds: topView.bounds, start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: 0.0, y: 1.0))
        //        bottomView.setGradient(bounds: bottomView.bounds, start: CGPoint(x: 0.0, y: 1.0), end: CGPoint(x: 0.0, y: 0.0))
        
        let width = collectionView.frame.width * CGFloat(images.count)
        collectionView.contentSize = CGSize(width: width, height: collectionView.frame.height)
        
        let offset = collectionView.frame.width * currentPage
        collectionView.setContentOffset(CGPoint(x: offset, y: 0), animated: false)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return}
        flowLayout.invalidateLayout()
    }
}


extension UIView {
    func setGradient(bounds: CGRect, start: CGPoint, end: CGPoint) {
        layer.sublayers = nil
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = start
        gradientLayer.endPoint = end
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension PreviewAttachmentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImagePreviewCollectionViewCell
//        currentPage = CGFloat(indexPath.row)
//        self.fileSizeLabel.text = self.task.attachments[indexPath.row].getFileSizeInString()
//        self.fileNameLabel.text = self.task.attachments[indexPath.row].attachmentURL
        DispatchQueue.main.async {
            cell?.image = self.images[indexPath.row]
        }
        return cell!
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension PreviewAttachmentViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let cell = collectionView.cellForItem(at: indexPath) as? ImagePreviewCollectionViewCell {
            cell.refreshCell(size: self.collectionView.frame.size)
        }
        let size = collectionView.frame
        return CGSize(width: size.width, height: size.height)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ImagePreviewCollectionViewCell else { return }
        cell.refreshCell(size: collectionView.frame.size)
    }
}
