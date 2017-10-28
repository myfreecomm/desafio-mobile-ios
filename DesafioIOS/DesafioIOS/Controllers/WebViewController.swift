//
//  WebViewController.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import UIKit
import SVProgressHUD

class WebViewController : UIViewController {
    
    public var pullRequest: PullRequest?
    
    @IBOutlet weak var webView: UIWebView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    @IBOutlet weak var reloadButton: UIButton?
    
    fileprivate(set) public var url : URL?
    fileprivate(set) public var didFail = false
    fileprivate(set) public var isProcessing = false
    
    // Setup
    fileprivate func setup() {
        // Primary state
        self.reloadButton?.disable()
        self.activityIndicator?.enable()
        self.activityIndicator?.startAnimating()
        self.title = ""
        self.navigationItem.title = ""
    }
    
    func launchUrl() {
        // Load
        if  let safePull = self.pullRequest,
            let url = URL(string: safePull.htmlUrl) {
            
            // Title
            self.title = safePull.title
            self.navigationItem.title = safePull.title
            
            // Loading WebView
            self.url = url
            self.loadWebView()
        }
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.launchUrl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeObservers()
    }
    
    // MARK: - Observers & Notifications
    public func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(WebViewController.notificationIsReachable(n:)), name: NotificationCenter.Name.Reachable, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(WebViewController.notificationNotReachable(n:)), name: NotificationCenter.Name.NotReachable, object: nil)
    }
    
    public func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: NotificationCenter.Name.Reachable, object: nil)
        NotificationCenter.default.removeObserver(self, name: NotificationCenter.Name.NotReachable, object: nil)
    }
    
    @objc func notificationIsReachable(n: Notification) {
        if  self.didFail && !self.isProcessing {
            self.loadWebView()
        }
    }
    
    @objc func notificationNotReachable(n: Notification) {
        SVProgressHUD.showError(withStatus: "Você está desconectado")
    }
    
    // MARK: - Internal Methods
    func loadWebView() {
        if  let safeUrl = self.url {
            let urlRequest = URLRequest(url: safeUrl)
            self.webView?.loadRequest(urlRequest)
        }
        else {
            SVProgressHUD.showError(withStatus: "Esta Pull Request não possui HTML URL.")
        }
    }
    
    // MARK: - IB Actions
    @IBAction func actionReload() {
        self.loadWebView()
    }
    
    @IBAction func actionDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Webview delegate
extension WebViewController : UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.reloadButton?.disable()
        self.activityIndicator?.enable()
        self.didFail = false
        self.isProcessing = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.activityIndicator?.disable()
        self.reloadButton?.enable()
        self.isProcessing = false
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        self.activityIndicator?.disable()
        self.reloadButton?.enable()
        self.didFail = true
        self.isProcessing = false
        
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

// MARK: - Custom methods for UIView
fileprivate extension UIView {
    func enable() {
        self.isHidden = false
        self.isUserInteractionEnabled = true
    }
    func disable() {
        self.isHidden = true
        self.isUserInteractionEnabled = false
    }
}


