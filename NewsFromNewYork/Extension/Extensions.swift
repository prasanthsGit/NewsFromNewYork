//
//  Extensions.swift
//  NewsFromNewYork
//
//  Created by prasanth on 03/07/22.
//

import Foundation
import UIKit
import WebKit

// MARK: UIView
extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
}

// MARK: WKWebView
extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}

// MARK: UIViewController
extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: UIImageView
extension UIImageView {
    func loadImageFrom(urlString: String) {
        let manager = CacheManager.shared
        if let cachedImage = manager.cache.object(forKey: urlString as NSString) {
            self.image = cachedImage
        } else {
            let utilityQueue = DispatchQueue.global(qos: .utility)
            utilityQueue.async {
                if let url = URL(string: urlString), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                    manager.cache.setObject(image, forKey: urlString as NSString)
                } else {
                    print("invalid url")
                    DispatchQueue.main.async {
                        self.image = UIImage(named: "placeHolder")
                    }
                }
            }
        }
    }
}

// MARK: - CacheManager Class
class CacheManager {
    static let shared = CacheManager()
    let cache = NSCache<NSString, UIImage>()
}
