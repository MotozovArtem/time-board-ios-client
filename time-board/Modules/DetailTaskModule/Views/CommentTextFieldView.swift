//
//  CommentTextFieldView.swift
//  time-board
//
//  Created by Tianid on 26.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class CommentTextFieldView: UIView {
    
    //MARK: - Properties
    private var isTextFieldAttachmentViewOpen = false
    private var isPanelMenuOpen = false
    private let collectionViewHeightConst: CGFloat = 100
    private let panelMenuHeightConst: CGFloat = 30
    private var heightPanelMenuCons: NSLayoutConstraint = NSLayoutConstraint()
    private var heightCollectionCons: NSLayoutConstraint = NSLayoutConstraint()
    
    private var presenter: ICommentTextFieldViewPresenter

    private let buttonHeightWidth: CGFloat = 25
    private var textField: UITextField! = {
        let textField = UITextField()
        textField.placeholder = "Type a comment..."
        return textField
    }()
    
    private var sendButtonView: UIImageView! = {
        let imageView = UIImageView(image: UIImage(named: "icons8-paper-plane-50"))
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        return imageView
    }()
    
    private var collectionView: UICollectionView! = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 100, height: 75)
        
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collection.backgroundColor = .clear
        return collection
    }()
    
    private var panelMenu:UIView! = {
        let view = UIView()
        return view
    }()
    
    private var cameraButton: UIButton! = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        button.setImage(UIImage(named: "icons8-camera-25"), for: .normal)
        button.addTarget(self, action: #selector(cameraButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private var imageButton: UIButton! = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        button.setImage(UIImage(named: "icons8-image-25"), for: .normal)
        button.addTarget(self, action: #selector(imageButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private var documentButton: UIButton! = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        button.setImage(UIImage(named: "icons8-attachment-25"), for: .normal)
        button.addTarget(self, action: #selector(documentButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Init
    
    init(presenter: ICommentTextFieldViewPresenter, frame: CGRect = CGRect()) {
        self.presenter = presenter
        super.init(frame: frame)
        setupConstraints()
        setupCollectionView()
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Func
    
    func addTextFieldAttachmentCellAt(indexPath: IndexPath) {
        if !isTextFieldAttachmentViewOpen {
            changeCollectionViewHeightConstraint(isHidden: false)
        }
        collectionView.insertItems(at: [indexPath])
    }
    
    func updateMenuPanel(isHidden: Bool) {
        if isHidden {
            heightPanelMenuCons.constant = 0
        } else {
            heightPanelMenuCons.constant = panelMenuHeightConst
        }
        isPanelMenuOpen = isHidden
    }
    
    func addNewTextFieldCommentAttachment(data: Data, fileName: String, fileType: AttachmentFileType) {
        presenter.addNewTextFieldCommentAttachment(data: data, fileName: fileName, fileType: fileType)
    }
    
    private func changeCollectionViewHeightConstraint(isHidden: Bool) {
        if isHidden {
            heightCollectionCons.constant = 0
            UIView.animate(withDuration: 0.2, animations: { [unowned self] in
                self.superview?.layoutIfNeeded()
            })
        } else {
            heightCollectionCons.constant = collectionViewHeightConst
            UIView.animate(withDuration: 0.2, animations: { [unowned self] in
                self.superview?.layoutIfNeeded()
            })
        }
        isTextFieldAttachmentViewOpen = !isHidden
    }
    
    private func setupConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        sendButtonView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        panelMenu.translatesAutoresizingMaskIntoConstraints = false
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        documentButton.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(textField)
        self.addSubview(sendButtonView)
        self.addSubview(collectionView)
        self.addSubview(panelMenu)
        
        panelMenu.addSubview(cameraButton)
        panelMenu.addSubview(imageButton)
        panelMenu.addSubview(documentButton)
        
        cameraButton.anchor(top: panelMenu.topAnchor,
                            leading: panelMenu.leadingAnchor,
                            padding: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0),
                            centerY: panelMenu.centerYAnchor)
        
        imageButton.anchor(top: panelMenu.topAnchor,
                            leading: cameraButton.trailingAnchor,
                            padding: UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0),
                            centerY: panelMenu.centerYAnchor)
        
        documentButton.anchor(top: panelMenu.topAnchor,
                            leading: imageButton.trailingAnchor,
                            padding: UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0),
                            centerY: panelMenu.centerYAnchor)
        
        textField.anchor(top: self.safeAreaLayoutGuide.topAnchor,
                         leading: self.safeAreaLayoutGuide.leadingAnchor,
                         padding: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
        )
        
        collectionView.anchor(top: textField.bottomAnchor,
                              leading: self.safeAreaLayoutGuide.leadingAnchor,
                              trailing: self.safeAreaLayoutGuide.trailingAnchor,
                              padding: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
        
        panelMenu.anchor(top: collectionView.bottomAnchor,
                         leading: self.safeAreaLayoutGuide.leadingAnchor,
                         bottom: self.safeAreaLayoutGuide.bottomAnchor,
                         trailing: self.safeAreaLayoutGuide.trailingAnchor
        )
        
        heightPanelMenuCons = panelMenu.heightAnchor.constraint(equalToConstant: isPanelMenuOpen ? panelMenuHeightConst : 0)
        heightCollectionCons = collectionView.heightAnchor.constraint(equalToConstant: isTextFieldAttachmentViewOpen ? collectionViewHeightConst : 0)
        
        NSLayoutConstraint.activate([
            heightPanelMenuCons,
            heightCollectionCons,
            sendButtonView.heightAnchor.constraint(equalToConstant: buttonHeightWidth),
            sendButtonView.widthAnchor.constraint(equalToConstant: buttonHeightWidth),
            sendButtonView.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 4),
            sendButtonView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -4),
            sendButtonView.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
        ])
        let gesture = UITapGestureRecognizer(target: self, action: #selector(sendButtonTapped(_:)))
        sendButtonView.addGestureRecognizer(gesture)
    }
    
    func removeTextFieldAttachment(at index: IndexPath) {
        presenter.deleteTempAttachment(at: index)
        collectionView.deleteItems(at: [index])
        
        if presenter.tempCommentAttachemnts.count == 0 {
            changeCollectionViewHeightConstraint(isHidden: true)
        }
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView?.register(AttachmentCommonCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    @objc private func sendButtonTapped(_ :UITapGestureRecognizer) {
        guard let comment = textField.text else { return }
        guard comment.count > 0 || presenter.tempCommentAttachemnts.count > 0 else { return }
        textField.text = nil
        presenter.addCommentButtonTapped(comment: comment)
        collectionView.reloadData()
        changeCollectionViewHeightConstraint(isHidden: true)

    }
    
    //MARK: - Panel menu button handlers
    @objc private func cameraButtonTapped(_ sender: UIButton) {
        presenter.cameraButtonTapped()
    }
    
    @objc private func imageButtonTapped(_ sender: UIButton) {
        presenter.imageButtonTapped()
    }
    
    @objc private func documentButtonTapped(_ sender: UIButton) {
        presenter.documentButtonTapped()
    }
    
    //MARK: - Cell tap handler
    
    @objc private func singleTapOnCell(_ gesture: UIGestureRecognizer) {
        guard gesture.state == .ended else { return }
        let point = gesture.location(in: collectionView)
//
        guard let indexPath = self.collectionView.indexPathForItem(at: point) else  { return }
        presenter.textFieldAttachmentCellSingleTapped(at: indexPath)
    }
    
    @objc private func longTapOnCell(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else { return }
        let point = gesture.location(in: collectionView)
        
        guard let indexPath = self.collectionView.indexPathForItem(at: point) else  { return }
        presenter.textFieldAttachmentCellLongTapped(at: indexPath)
    }
}

extension CommentTextFieldView: UICollectionViewDelegate {
    
}

extension CommentTextFieldView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.tempCommentAttachemnts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? AttachmentCommonCollectionViewCell)!
        
//        cell.imageView.image = presenter.getImage(indexPath: indexPath, storage: .temp)
        cell.setupImage(image: presenter.getImage(indexPath: indexPath, storage: .temp))
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTapOnCell(_:)))
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(longTapOnCell(_:)))
        cell.addGestureRecognizer(singleTap)
        cell.addGestureRecognizer(longTap)

        return cell
    }
}
