//
//  WebViewController.swift
//  FinalProject_OR
//
//  Created by Oscar Rivera on 6/18/18.
//  Copyright © 2018 Oscar Rivera. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    @IBOutlet weak var webView: WKWebView!
    
    let url = URL(string: "http://sanjuanciudadpatria.com/permisos/formularios/docs/pdfs/Solicitud-de-Permiso-de-Construccion-(OP-MSJ-2).pdf")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController("Información")
        
        let filterButton = UIBarButtonItem(image: #imageLiteral(resourceName: "shared"), style: .plain, target: self, action: #selector(shareButtonClicked(_:)))
        navigationItem.rightBarButtonItem = filterButton
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        guard let url = URL(string: "http://sanjuanciudadpatria.com/permisos/formularios/docs/pdfs/Solicitud-de-Permiso-de-Construccion-(OP-MSJ-2).pdf") else { return }
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.isUserInteractionEnabled = true
        webView.navigationDelegate = self
        self.view.addSubview(self.webView)
        let request = URLRequest(url: url)
        webView.load(request)

        self.webView.addSubview(self.loadingView)
        self.loadingView.startAnimating()
        self.webView.navigationDelegate = self
        self.loadingView.hidesWhenStopped = true
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.loadingView.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.loadingView.stopAnimating()
    }
    
    @objc func shareButtonClicked(_ sender: UIButton)
    {
        let vc = UIActivityViewController(activityItems: [url!], applicationActivities: [])
        present(vc, animated: true)
    }
}
