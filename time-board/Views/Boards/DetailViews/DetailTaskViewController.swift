//
//  DetailViewViewController.swift
//  time-board
//
//  Created by Tianid on 25.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit
import MobileCoreServices

class DetailTaskViewController: UIViewController {
    
    //MARK: - Properties
    private var task: Task
    private var presenter: DetailTaskPresenterProtocol?
    
    private lazy var detailView: TaskDetailView = {
        return TaskDetailView(presenter: presenter)
    }()
    
    private lazy var scrollView: UIScrollView! = {
        return UIScrollView()
    }()
    
    private lazy var commentTextFieldView: CommentTextFieldView! = {
        let view = CommentTextFieldView(parent: self)
        return view
    }()
    
    //MARK: - Init
    init(task: Task) {
        self.task = task
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Func
    
    private func isTapBarHidden(value: Bool) {
        guard let tabBar = navigationController?.tabBarController?.tabBar else { return }
        tabBar.isHidden = value
    }
    
    private func setupViewController() {
        setupViews()
        addActionsObservers()
        setupDataToViews()
        setupComments()
    }
    
    private func setupViews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        detailView.translatesAutoresizingMaskIntoConstraints = false
        commentTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(detailView)
        view.addSubview(commentTextFieldView)
        
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          leading: view.leadingAnchor,
                          bottom: commentTextFieldView.topAnchor,
                          trailing: view.trailingAnchor,
                          padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        )
        
        detailView.anchor(top: scrollView.topAnchor,
                          leading: scrollView.leadingAnchor,
                          bottom: scrollView.bottomAnchor,
                          trailing: scrollView.trailingAnchor)
        
        commentTextFieldView.anchor(
            leading: view.leadingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor)
        
        NSLayoutConstraint.activate([
            commentTextFieldView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        detailView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        //        scrollView.backgroundColor = .red
        //        detailView.backgroundColor = .green
        //        commentTextFieldView.backgroundColor = .green
        
        
        addTopBorderTo(view: commentTextFieldView, color: UIColor.systemGray.cgColor)
    }
    
    private func addActionsObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    private func setupDataToViews() {
        detailView.setDataSource(taskName: task.name,
                                 description: task.taskDescription,
                                 attachments: task.attachments,
                                 comments: task.comments)
    }
    
    private func setupComments() {
        for comment in task.comments {
            detailView.addNewCommentView(comment: comment)
        }
    }
    
    private func addTopBorderTo(view: UIView, thickness: CGFloat = 1.0, color: CGColor) {
        let topBorder = CALayer()
        
        topBorder.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: thickness)
        topBorder.backgroundColor = color
        view.layer.addSublayer(topBorder)
    }
    
    private func scrollToLastComment() {
        if scrollView.contentSize.height - scrollView.bounds.size.height > 0 {
            let bottomOffset = CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.bounds.size.height + self.scrollView.contentInset.bottom)
            scrollView.setContentOffset(bottomOffset, animated: true)
        }
    }
    
    private func showImagePicker(fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        guard UIImagePickerController.isSourceTypeAvailable(sourceType)  else { return }
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = sourceType
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    private func showDocumentPicker() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeItem as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true)
    }
    
    private func getFileType(type: String) -> AttachmentFileType {
        switch type {
        case AttachmentFileType.jpeg.rawValue:
            return .jpeg
        case AttachmentFileType.jpg.rawValue:
            return .jpg
        case AttachmentFileType.gif.rawValue:
            return .gif
        case AttachmentFileType.png.rawValue:
            return .png
        case AttachmentFileType.heic.rawValue:
            return .heic
        case AttachmentFileType.notImage.rawValue:
            return .notImage
        default:
            return .notImage
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        
        if self.view.frame.origin.y == 0 {
            var contentInsets = UIEdgeInsets()
            contentInsets = UIEdgeInsets(top: keyboardSize.height, left: 0.0, bottom: 0.0, right: 0.0)
            scrollView.contentInset = contentInsets
            view.frame.origin.y -= keyboardSize.height
        }
        scrollToLastComment()
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        if self.view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    @objc private func closeDetail(_ navBar: UINavigationBar) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TEST"
        presenter = DetailTaskPresenter(controller: self, task: task)
        setupViewController()
        isTapBarHidden(value: true)
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        addTopBorderTo(view: commentTextFieldView, color: UIColor.systemGray.cgColor)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailView.setDataSource(taskName: task.name,
                                 description: task.taskDescription,
                                 attachments: task.attachments,
                                 comments: task.comments)
    }
}

extension DetailTaskViewController: DetailTaskViewControllerProtocol {
    
    func addNewComment(comment: String) {
        detailView.addNewCommentView(comment: comment)
        task.comments.append(comment)
        scrollToLastComment()
    }
    
    func showAddNewAttachmentAlert() {
        let alert = UIAlertController(title: nil, message: "Add attachment", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.showImagePicker(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.showImagePicker(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Documents", style: .default, handler: {(action: UIAlertAction) in
            self.showDocumentPicker()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAttachmentCellAlert(indexPath: IndexPath) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: {[weak self] (action: UIAlertAction) in
            self?.presenter?.deleteAttachmentTapped(indexPath: indexPath)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func addAttachmentDataAt(indexPath: IndexPath) {
        detailView.addAttachmentCellAt(indexPath: indexPath)
    }
    
    func deleteAttachmentDataAt(indexPath: IndexPath) {
        detailView.deleteAttachmentCellAt(indexPath: indexPath)
    }
    
    func showImagePreview(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showDescriptionEditScreen() {
        let vc = DescriptionEditViewController(task: task)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension DetailTaskViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true) { [weak self] in
            if picker.sourceType == .photoLibrary {
                guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
                guard let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
                
                guard let fileType = self?.getFileType(type: imageURL.pathExtension) else { return }
                
                self?.presenter?.addNewAttachment(data: image.jpegData(compressionQuality: 0.0)!, fileName: imageURL.lastPathComponent, fileType: fileType)
            }
            
            if picker.sourceType == .camera {
                guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
                let fileName = "Photo - \(Date())"
                
                self?.presenter?.addNewAttachment(data: image.jpegData(compressionQuality: 0.0)!, fileName: fileName, fileType: .jpg)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

//MARK: - UIDocumentPickerDelegate
extension DetailTaskViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        do {
            let fileURL = urls[0]
            let fileName = fileURL.lastPathComponent
            let data = try Data(contentsOf: urls[0])
            let fileType = getFileType(type: fileURL.pathExtension)
            self.presenter?.addNewAttachment(data: data, fileName: fileName, fileType: fileType)
        } catch {
            TBLog(message: "Document picker error", typeOfLog: .Error)
        }
    }
}

extension DetailTaskViewController: PreviewDetailViewControllerProtocol {    
    func dissmisViewController() {
        self.dismiss(animated: true, completion: nil)
    }
}
