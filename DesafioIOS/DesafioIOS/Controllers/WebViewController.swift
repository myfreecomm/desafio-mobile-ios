//
//  WebViewController.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import UIKit

class WebViewController : UIViewController, Hud {
    
    var viewModel = WebViewModel()
    
    @IBOutlet weak var webView: UIWebView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    @IBOutlet weak var reloadButton: UIButton?
    
    // Setup
    private func setup() {
        
        // Primary state
        title = ""
        navigationItem.title = ""
        reloadButton?.disable()
        activityIndicator?.enable()
        activityIndicator?.startAnimating()
        
        // ViewModel
        viewModel.didLaunchUrl = { [weak self] title in
            self?.title = title
            self?.navigationItem.title = title
            self?.loadWebView()
        }
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.launchUrl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeObservers()
    }
    
    // MARK: - Internal Methods
    func loadWebView() {
        
        guard let safeUrl = viewModel.url else {
            errorHud("Esta Pull Request não possui HTML URL.")
            return
        }
        
        let urlRequest = URLRequest(url: safeUrl)
        webView?.loadRequest(urlRequest)
    }
    
    // MARK: - IB Actions
    @IBAction func actionReload() {
        loadWebView()
    }
    
    @IBAction func actionDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Reachability
    public func addObservers() {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(WebViewController.notificationIsReachable(n:)),
            name: NotificationCenter.Name.Reachable,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(WebViewController.notificationNotReachable(n:)),
            name: NotificationCenter.Name.NotReachable,
            object: nil
        )
    }
    
    public func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: NotificationCenter.Name.Reachable, object: nil)
        NotificationCenter.default.removeObserver(self, name: NotificationCenter.Name.NotReachable, object: nil)
    }
    
    @objc func notificationIsReachable(n: Notification) {
        if  viewModel.didFail && !viewModel.isProcessing {
            loadWebView()
        }
    }
    
    @objc func notificationNotReachable(n: Notification) {
        errorHud("Você está desconectado ☹️")
    }
}

// MARK: - Webview delegate
extension WebViewController : UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        reloadButton?.disable()
        activityIndicator?.enable()
        viewModel.didFail = false
        viewModel.isProcessing = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator?.disable()
        reloadButton?.enable()
        viewModel.isProcessing = false
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
        activityIndicator?.disable()
        reloadButton?.enable()
        viewModel.didFail = true
        viewModel.isProcessing = false
        
        // Show Error
        let alert = UIAlertController(title: "Ocorreu um erro", message: error.localizedDescription, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Tentar novamente", style: .destructive) { [weak self](action) in
            self?.loadWebView()
        }
        let noAction = UIAlertAction(title: "Fechar", style: .cancel, handler: { (action) in
            // Nothing
        })
        alert.addAction(yesAction)
        alert.addAction(noAction)
        self.present(alert, animated: true, completion: nil)
    }
}

