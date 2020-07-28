//
//  CommentView.swift
//  time-board
//
//  Created by Tianid on 30.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class CommentView: UIView {
    
    //MARK: - Properties
    private var presenter: ICommentViewPresenter
    private var isCommentAttachmentViewOpen = false
    private let collectionViewHeightConst: CGFloat = 70
    private var heightCollectionCons: NSLayoutConstraint = NSLayoutConstraint()
//    private let previewPresenter: IDetailTaskPresenterMain
    private var commentIndex: Int

    var text: String = String() {
        didSet {
            commentTextLabel.text = text
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
            dateLabel.text = dateFormatter.string(from: date)
        }
    }
    private var avatarImageVIew: UIImageView! = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        return view
    }()
    
    private var nameLabel: UILabel! = {
        let view = UILabel()
        view.text = "Name"
        return view
    }()
    
    private var dateLabel: UILabel! = {
        let view = UILabel()
        view.text = "DATE"
        view.font = UIFont.systemFont(ofSize: 15)
        view.textColor = .lightGray
        return view
    }()
    
    private var commentTextLabel: UILabel! = {
        let view = UILabel()
        view.text = "TEXT LABEL"
        view.numberOfLines = 0
        return view
    }()
    
    private var collectionView: UICollectionView! = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: 75, height: 50)
        
        
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collection.backgroundColor = .clear
        return collection
    }()
    
    //MARK: - Init
    init(presenter: ICommentViewPresenter, commentIndex: Int) {
//        self.presenter = CommentViewPresenter(comment: comment)
//        self.previewPresenter = previewPresenter
        self.presenter = presenter
        self.commentIndex = commentIndex
        
        
        
        super.init(frame: CGRect())
        isCommentAttachmentViewOpen = isNeedToOpenAttachmentView()
        setupConstraints()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Func
    private func setupConstraints() {
        avatarImageVIew.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        commentTextLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(avatarImageVIew)
        self.addSubview(nameLabel)
        self.addSubview(dateLabel)
        self.addSubview(commentTextLabel)
        self.addSubview(collectionView)
        
        avatarImageVIew.anchor(top: self.safeAreaLayoutGuide.topAnchor,
                               leading: self.safeAreaLayoutGuide.leadingAnchor,
                               bottom: commentTextLabel.topAnchor,
                               trailing: nameLabel.leadingAnchor,
                               padding: UIEdgeInsets(top: 5, left: 8, bottom: 2, right: 2))
        
        NSLayoutConstraint.activate([
            avatarImageVIew.heightAnchor.constraint(equalToConstant: 50),
            avatarImageVIew.widthAnchor.constraint(equalToConstant: 50),
        ])
        
        nameLabel.anchor(top: self.safeAreaLayoutGuide.topAnchor,
            bottom: commentTextLabel.topAnchor,
            trailing: dateLabel.leadingAnchor,
            padding: UIEdgeInsets(top: 5, left: 0, bottom: 2, right: 2))
        
        dateLabel.anchor(top: self.safeAreaLayoutGuide.topAnchor,
            bottom: commentTextLabel.topAnchor,
            padding: UIEdgeInsets(top: 5, left: 0, bottom: 2, right: 8))
        
        commentTextLabel.anchor(
            leading: self.safeAreaLayoutGuide.leadingAnchor,
            bottom: collectionView.topAnchor,
            trailing: self.safeAreaLayoutGuide.trailingAnchor,
            padding: UIEdgeInsets(top: 0, left: 8, bottom: 2, right: 8))
        
        collectionView.anchor(
                              leading: self.safeAreaLayoutGuide.leadingAnchor,
                              bottom: self.safeAreaLayoutGuide.bottomAnchor,
                              trailing: self.safeAreaLayoutGuide.trailingAnchor,
                              padding: UIEdgeInsets(top: 0, left: 8, bottom: 10, right: 8))
        
        heightCollectionCons = collectionView.heightAnchor.constraint(equalToConstant: isCommentAttachmentViewOpen ? collectionViewHeightConst : 0)
        
        NSLayoutConstraint.activate([
            heightCollectionCons,
            dateLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: 8)
        ])
        
        avatarImageVIew.backgroundColor = .red
        nameLabel.backgroundColor = .orange
        dateLabel.backgroundColor = .blue
        commentTextLabel.backgroundColor = .yellow
        collectionView.backgroundColor = .brown
        self.backgroundColor = UIColor(displayP3Red: 222/255, green: 222/255, blue: 222/255, alpha: 0.9)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView?.register(AttachmentCommonCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    private func isNeedToOpenAttachmentView() -> Bool {
        guard presenter.task.comments[commentIndex].commentAttachments.count != 0 else { return false }
//        guard presenter.comment.commentAttachments.count != 0 else { return false }
        return true
    }
    
    @objc private func singleTapOnCell(_ gesture: UIGestureRecognizer) {
        guard gesture.state == .ended else { return }
        let point = gesture.location(in: collectionView)
        
        let images = presenter.getAllImages(for: commentIndex)
        guard let indexPath = self.collectionView.indexPathForItem(at: point) else  { return }
        
        let vc = AssemblerModuleBuilder().createPreviewAttachmentModule(attachments: presenter.task.comments[commentIndex].commentAttachments, startIndex: indexPath.row, images: images)
//        let preview = PreviewAttachmentViewController(images: images, presenter: previewPresenter, startImage: indexPath.row)
//        previewPresenter.showPreview(viewController: preview)
        presenter.showPreview(view: vc)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height / 10
    }
}

extension CommentView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout { }
extension CommentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.task.comments[commentIndex].commentAttachments.count
//        return presenter.task.comments[commentIndex].commentAttachments.count
//        return presenter.comment.commentAttachments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? AttachmentCommonCollectionViewCell)!
//        cell.imageView.image = presenter.getImage(indexPath: indexPath, storage: .comments)
        cell.imageView.image = presenter.getImageFromComment(commentIndex: commentIndex, index: indexPath.row)
//        cell.imageView.image = presenter.getImage(indexPath: indexPath)
        let tap = UITapGestureRecognizer(target: self, action: #selector(singleTapOnCell(_:)))
        cell.addGestureRecognizer(tap)
        
        return cell
    }
}
