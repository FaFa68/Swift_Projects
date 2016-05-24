//
//  ImageViewController.swift
//  Cassini
//
//  Created by Farshad Faradji on 24/05/16.
//  Copyright © 2016 FaFa. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    private var imageView = UIImageView()
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    var imageURL: NSURL? {
        didSet{
            image = nil
            fetchImage()
            scrollView?.contentSize = imageView.frame.size
            
        }
    }
    @IBOutlet weak var scrollView: UIScrollView! {
        
        didSet{
        scrollView.contentSize = imageView.frame.size
        }
    }
    
    private func fetchImage(){
        if let url = imageURL {
            if let imageDate = NSData(contentsOfURL: url){
                image = UIImage(data: imageDate)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
        imageURL = NSURL(string: "http://www.planwallpaper.com/static/images/Fall-wallpaper-1366x768-HD-wallpaper.jpg")
    }

}
