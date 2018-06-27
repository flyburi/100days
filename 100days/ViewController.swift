//
//  ViewController.swift
//  100days
//
//  Created by buri on 2018. 6. 20..
//  Copyright © 2018년 tina. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var imagePageControl: UIPageControl!
    
    var imageArray = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainScrollView.frame = view.frame
        
        imageArray = [
            UIImage(named: "cafe3.jpeg")!,
            UIImage(named: "cafe2.jpeg")!,
            UIImage(named: "cafe1.jpeg")!
        ]
        
        mainScrollView.delegate = self
        for i in 0..<imageArray.count{
            let imageView = UIImageView()
            imageView.image = imageArray[i]
            imageView.contentMode = .scaleAspectFit
            let xPosition = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x:xPosition, y:0, width:self.mainScrollView.frame.width,
                                     height:self.mainScrollView.frame.height)
            mainScrollView.contentSize.width = mainScrollView.frame.width * CGFloat(i + 1)
            mainScrollView.addSubview(imageView);
            
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = mainScrollView.contentOffset.x / mainScrollView.frame.size.width
        imagePageControl.currentPage = Int(page)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

