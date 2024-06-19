//
//  ActivityLoader.swift
//  LMS
//
//  Created by PHN Tech 2 on 15/02/24.
//
import UIKit

class ActivityLoader: UIView {
    private var progressIndicator: UIActivityIndicatorView?
    private var backgroundView: UIView?
    private weak var viewController: UIViewController?

    // Initializer with an additional useInteraction parameter
    init(viewController: UIViewController, useInteraction: Bool = true) {
        self.viewController = viewController
        super.init(frame: UIScreen.main.bounds)
        setupView(useInteraction: useInteraction)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView(useInteraction: false)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView(useInteraction: false)
    }

    private func setupView(useInteraction: Bool) {
        backgroundView = UIView(frame: UIScreen.main.bounds)
        backgroundView?.isUserInteractionEnabled = !useInteraction // Toggle interaction based on useInteraction parameter
        progressIndicator = UIActivityIndicatorView(style: .large)
        progressIndicator?.translatesAutoresizingMaskIntoConstraints = false
        
        if let backgroundView, let progressIndicator {
            backgroundView.addSubview(progressIndicator)
            addSubview(backgroundView)
            
            NSLayoutConstraint.activate([
                progressIndicator.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
                progressIndicator.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
            ])
        }
        isUserInteractionEnabled = !useInteraction // Toggle interaction based on useInteraction parameter
    }
    
    func show() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let viewController = self.viewController else { return }
            if self.progressIndicator?.isAnimating == false {
                self.progressIndicator?.startAnimating()
                viewController.view.addSubview(self)
                
                NSLayoutConstraint.activate([
                    self.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
                    self.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
                    self.topAnchor.constraint(equalTo: viewController.view.topAnchor),
                    self.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor)
                ])
            }
        }
    }
    
    func hide() {
        DispatchQueue.main.async { [weak self] in
            self?.progressIndicator?.stopAnimating()
            self?.removeFromSuperview()
        }
    }
}
