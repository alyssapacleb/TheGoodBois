//
//  AboutViewController.swift
//  TheGoodBois
//
//  Created by Argandona Vite, Angel R on 5/5/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVc(viewController: "tutorial2"), self.newVc(viewController: "tutorial1"), self.newVc(viewController: "tutorial3")]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSlideScrollView(slides: orderedViewControllers)
        
        scrollView.delegate = self
        
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = 0
        view.bringSubview(toFront: pageControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newVc(viewController: String) -> UIViewController{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
    func setupSlideScrollView(slides: [UIViewController]){
        scrollView.frame = CGRect(x: 0, y: 0, width: 375, height: 420)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: 420/*view.frame.height*/)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].view.frame = CGRect(x: view.frame.width*CGFloat(i), y: 0, width: 375, height: 420)
            scrollView.addSubview(slides[i].view)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
