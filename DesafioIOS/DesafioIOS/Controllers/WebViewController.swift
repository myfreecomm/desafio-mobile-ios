//
//  WebViewController.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import UIKit

/**
 *  WebViewController
 *  @description    Opens internally the url requests
 */
class WebViewController : UIViewController, Hud {
    
    /**
     * Class View Model
     */
    var viewModel : WebViewModel!
    
    /**
     * Outlets
     */
    @IBOutlet weak var webView: UIWebView?
    
    
    // MARK: - 👽 Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        navigationItem.title = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeObservers()
    }
    
    /**
     *  addObservers()
     *  @description    Subscribes the Screen to receive Reachability events
     */
    public func addObservers() {
        
        NotificationCenter.default.subscribe(
            observer: self, selector: #selector(WebViewController.notificationIsReachable(n:)), custom: .reachable)
        
        NotificationCenter.default.subscribe(
            observer: self, selector: #selector(WebViewController.notificationNotReachable(n:)), custom: .notReachable)
    }
    
    /**
     *  removeObservers()
     *  @description    Unsubscribes the Reachability events
     */
    public func removeObservers() {
        NotificationCenter.default.unsubscribe(observer: self)
    }
    
    // MARK: - 🔐 Internal Methods
    
    /**
     *  loadWebView()
     *  @description    Loads WebView UI
     */
    func loadWebView() {
        
        guard let safeUrl = viewModel.pullRequestUrl else {
            errorHud("Error.NoURL".localized)
            return
        }
        
        let urlRequest = URLRequest(url: safeUrl)
        webView?.loadRequest(urlRequest)
    }
    
    func updateUI() {
        self.title = viewModel.pullRequestTitle
        self.navigationItem.title = viewModel.pullRequestTitle
        self.loadWebView()
    }
    
    // MARK: - 🤖 IB Actions
    
    /**
     *  actionDismiss()
     *  @description    Dismiss the current ViewController
     */
    @IBAction func actionDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - 🎃 Reachability
    
    /**
     *  notificationIsReachable(n:)
     *  @description    Selector action for when connection is on
     *  @param n        NotificationCenter's notification
     */
    @objc func notificationIsReachable(n: Notification) {
        if  viewModel.didFail && !viewModel.isProcessing {
            loadWebView()
        }
    }
    
    /**
     *  notificationNotReachable(n:)
     *  @description    Selector action for when connection is off
     *  @param n        NotificationCenter's notification
     */
    @objc func notificationNotReachable(n: Notification) {
        errorHud("Error.YouAreOffline".localized)
    }
}

// MARK: - 🍎 Webview Delegate
extension WebViewController : UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        viewModel.didFail = false
        viewModel.isProcessing = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        viewModel.isProcessing = false
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
        viewModel.didFail = true
        viewModel.isProcessing = false
        
        // Show Error
        let alert = UIAlertController(title: "Error.Title".localized, message: error.localizedDescription, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "TryAgain".localized, style: .destructive) { [weak self](action) in
            self?.loadWebView()
        }
        let noAction = UIAlertAction(title: "Close".localized, style: .cancel, handler: { (action) in
            // Nothing
        })
        alert.addAction(yesAction)
        alert.addAction(noAction)
        self.present(alert, animated: true, completion: nil)
    }
}

