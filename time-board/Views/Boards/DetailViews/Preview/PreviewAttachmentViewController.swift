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
    private let minViewsHeight: CGFloat = 50
    private let maxViewsHeight: CGFloat = 100
    
    private var topViewHeight: NSLayoutConstraint?
    private var bottomViewHeight: NSLayoutConstraint?
    
    
    private var topView: UIView! = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var middleView: UIView! = {
           let view = UIView()
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
    
    private var bottomView: UIView! = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var scrollView: UIScrollView! = {
        let view = UIScrollView()
        view.isPagingEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var imageViews = [UIImageView]()
    private var images: [UIImage]?
    var index: Int? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setuConstraints()
        setupScrollView()
        // Do any additional setup after loading the view.
    }
    

    //MARK: - Func

    private func setuConstraints() {
//        self.view.addSubview(middleView)
        self.view.addSubview(scrollView)
        self.view.addSubview(topView)
        self.view.addSubview(bottomView)
        self.view.backgroundColor = .black
        
        topView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                       leading: view.safeAreaLayoutGuide.leadingAnchor,
                       trailing: view.safeAreaLayoutGuide.trailingAnchor)
        
        
        topViewHeight = topView.heightAnchor.constraint(equalToConstant: minViewsHeight)
        
       
//
//        middleView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
//                          leading: view.safeAreaLayoutGuide.leadingAnchor,
//                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
//                          trailing: view.safeAreaLayoutGuide.trailingAnchor)
        
        scrollView.anchor(top: topView.bottomAnchor,
                          leading: view.safeAreaLayoutGuide.leadingAnchor,
                          bottom: bottomView.topAnchor,
                          trailing: view.safeAreaLayoutGuide.trailingAnchor)

        bottomView.anchor(leading: view.safeAreaLayoutGuide.leadingAnchor,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          trailing: view.safeAreaLayoutGuide.trailingAnchor)

        bottomViewHeight = bottomView.heightAnchor.constraint(equalToConstant: minViewsHeight)
        
        NSLayoutConstraint.activate([
            topViewHeight!,bottomViewHeight!
        ])

        
        middleView.backgroundColor = .white
        topView.backgroundColor = .white
        bottomView.backgroundColor = .white
        scrollView.backgroundColor = .green
        

        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    

    
    private func setupScrollView() {
        for _ in 0...5 {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            scrollView.addSubview(imageView)
            imageViews.append(imageView)
        }
//        for item in images! {
//            let imageView = UIImageView(image: item)
//            imageView.contentMode = .scaleAspectFit
//            scrollView.addSubview(imageView)
//            imageViews.append(imageView)
//        }
    }
    
    private func changeHeightView() {
        if topViewHeight?.constant == minViewsHeight {
            topViewHeight?.constant = maxViewsHeight
            bottomViewHeight?.constant = maxViewsHeight
        } else {
            topViewHeight?.constant = minViewsHeight
            bottomViewHeight?.constant = minViewsHeight
        }
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        changeHeightView()
//        topView.setGradient(bounds: topView.bounds, start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: 0.0, y: 1.0))
//        bottomView.setGradient(bounds: bottomView.bounds, start: CGPoint(x: 0.0, y: 1.0), end: CGPoint(x: 0.0, y: 0.0))

        for (index, imageView) in imageViews.enumerated() {
            imageView.frame.size = scrollView.frame.size
            imageView.frame.origin.x = scrollView.frame.width * CGFloat(index)
            imageView.frame.origin.y = 0
        }
        let contentWidth = scrollView.frame.width * CGFloat(imageViews.count)
        scrollView.contentSize = CGSize(width: contentWidth, height: scrollView.frame.height)

        let offset = scrollView.frame.width * CGFloat(Float(index!))
        scrollView.setContentOffset(CGPoint(x: offset, y: 0), animated: false)
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
