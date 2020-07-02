//
//  AttachmentView.swift
//  time-board
//
//  Created by Tianid on 02.07.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class AttachmentView: UIView {
    
    //MARK: - Properties
    private let collectionViewHeightConst: CGFloat = 100
    private let attachmentHeaderViewHeightConst: CGFloat = 50
    private var isAttachmentViewOpen = false

    private var heightCollectionCons: NSLayoutConstraint = NSLayoutConstraint()
    //MARK: TEST MODEL REFACTOR IT
    private var model: [Int] = Array(repeating: 1, count: 10)
    
    private var attachmentHeaderView: UIView! = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    private var collectionContainer: UIView! = {
        let view = UIView()
        return view
    }()
    
    private var collectionView: UICollectionView! = {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 100, height: 75)
        
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collection.backgroundColor = .brown
        return collection
    }()
    
    //MARK: - Init
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        setup()
        collectionView.dataSource = self
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(UINib(nibName: "\(AttachmentAddCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "AddCell")
        let gestire = UITapGestureRecognizer(target: self, action: #selector(tap))
        attachmentHeaderView.addGestureRecognizer(gestire)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Func
    private func setup() {
        attachmentHeaderView.translatesAutoresizingMaskIntoConstraints = false
        collectionContainer.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(attachmentHeaderView)
        self.addSubview(collectionContainer)
        collectionContainer.addSubview(collectionView)
        
        attachmentHeaderView.anchor(top: self.safeAreaLayoutGuide.topAnchor,
                          leading: self.safeAreaLayoutGuide.leadingAnchor,
                          trailing: self.safeAreaLayoutGuide.trailingAnchor)
        
        NSLayoutConstraint.activate([
            attachmentHeaderView.heightAnchor.constraint(equalToConstant: attachmentHeaderViewHeightConst)
        ])
        
        collectionContainer.anchor(top: attachmentHeaderView.safeAreaLayoutGuide.bottomAnchor,
                                   leading: self.safeAreaLayoutGuide.leadingAnchor,
                                   bottom: self.safeAreaLayoutGuide.bottomAnchor,
                                   trailing: self.safeAreaLayoutGuide.trailingAnchor)
        
        heightCollectionCons = collectionContainer.heightAnchor.constraint(equalToConstant: isAttachmentViewOpen ? collectionViewHeightConst: 0)
        
        NSLayoutConstraint.activate([
            heightCollectionCons
        ])
            
        collectionView.anchor(top: collectionContainer.topAnchor,
                         leading: collectionContainer.leadingAnchor,
                         bottom: collectionContainer.bottomAnchor,
                         trailing: collectionContainer.trailingAnchor)
    }
    
    @objc private func tap() {
        if !isAttachmentViewOpen {
            isAttachmentViewOpen = true
            self.heightCollectionCons.constant = collectionViewHeightConst
            UIView.animate(withDuration: 0.3, animations: { [unowned self] in
                self.superview?.superview?.layoutIfNeeded()
                })
        } else {
            isAttachmentViewOpen = false
            self.heightCollectionCons.constant = 0
            UIView.animate(withDuration: 0.3, animations: { [unowned self] in
                self.superview?.superview?.layoutIfNeeded()
            })
        }
    }
}

extension AttachmentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : model.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if indexPath.section == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddCell", for: indexPath)
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        }
        cell.backgroundColor = .white
        cell.layer.cornerRadius = cell.frame.size.width / 10
        return cell
    }
}
