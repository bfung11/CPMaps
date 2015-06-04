//
//  Paged scroll view to display room floor plans
//
//

import UIKit

class FloorPlanPagedScrollViewController: UIViewController, UIScrollViewDelegate {
   
   @IBOutlet var scrollView: UIScrollView!
   @IBOutlet weak var pageControl: UIPageControl!
   
   var pageImages: [UIImage] = []
   var pageViews: [UIImageView?] = []
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // initialize the pages
      let pageCount = pageImages.count
      pageControl.currentPage = 0
      pageControl.numberOfPages = pageCount
      
      for _ in 0..<pageCount {
         pageViews.append(nil)
      }
      
      // size scroll to how many pages exist
      let pagesScrollViewSize = scrollView.frame.size
      scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * CGFloat(pageImages.count), pagesScrollViewSize.height)
      
      // Zooming abilities
      var doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewDoubleTapped:")
      doubleTapRecognizer.numberOfTapsRequired = 2
      doubleTapRecognizer.numberOfTouchesRequired = 1
      scrollView.addGestureRecognizer(doubleTapRecognizer)
      
      let scrollViewFrame = scrollView.frame
      let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
      let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
      let minScale = min(scaleWidth, scaleHeight);
      scrollView.minimumZoomScale = minScale;
      scrollView.maximumZoomScale = 2.0
      scrollView.zoomScale = minScale;
      
      // Load pages
      loadVisiblePages()
      centerScrollViewContents()
      
      //UI management
      self.navigationItem.leftBarButtonItem =
         UIBarButtonItem(barButtonSystemItem: .Cancel,
            target: self, action: "cancelButtonPressed:")
      self.navigationItem.rightBarButtonItem =
         UIBarButtonItem(barButtonSystemItem: .Done,
            target: self, action: "doneButtonPressed:")
   }
   
   //UI management
   @IBAction func cancelButtonPressed(sender: AnyObject) {
      self.dismissViewControllerAnimated(true, completion: nil)
      //      self.performSegueWithIdentifier(cancelToLocationsTVC, sender: self)
   }
   
   @IBAction func doneButtonPressed(sender: AnyObject) {
      println("Done pressed")
   }

   
   // set pages to building
   func setPages(building : Building) {
      pageImages.removeAll(keepCapacity: false)
      
      for var floor = 1; floor <= building.numberOfFloors; ++floor {
         var fileName: String! = building.number + "-" + String(floor) + ".png"
         var image: UIImage? = UIImage(named:fileName)
         // only add the image if it exists
         if(image != nil) {
            pageImages.append(image!)
         }
      }
   }
   
   
   func loadPage(page: Int) {      
      if page < 0 || page >= pageImages.count {
         // If it's outside the range of what you have to display, then do nothing
         return
      }
      
      // 1
      if let pageView = pageViews[page] {
         // Do nothing. The view is already loaded.
      } else {
         // 2
         var frame = scrollView.bounds
         frame.origin.x = frame.size.width * CGFloat(page)
         frame.origin.y = 0.0
         
         // 3
         let newPageView = UIImageView(image: pageImages[page])
         newPageView.contentMode = .ScaleAspectFit
         newPageView.frame = frame
         scrollView.addSubview(newPageView)
         
         // 4
         pageViews[page] = newPageView
      }
   }
   
   func purgePage(page: Int) {
      if page < 0 || page >= pageImages.count {
         // If it's outside the range of what you have to display, then do nothing
         return
      }
      
      // Remove a page from the scroll view and reset the container array
      if let pageView = pageViews[page] {
         pageView.removeFromSuperview()
         pageViews[page] = nil
      }
   }
   
   func loadVisiblePages() {
      
      // First, determine which page is currentl visible
      let pageWidth = scrollView.frame.size.width
      let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
      
      // Update the page control
      pageControl.currentPage = page
      
      // Work out which pages you want to load
      let firstPage = page - 1
      let lastPage = page + 1
      
      
      // Purge anything before the first page
      for var index = 0; index < firstPage; ++index {
         purgePage(index)
      }
      
      // Load pages in our range
      for var index = firstPage; index <= lastPage; ++index {
         loadPage(index)
      }
      
      // Purge anything after the last page
      for var index = lastPage+1; index < pageImages.count; ++index {
         purgePage(index)
      }
   }
   
   func scrollViewDidScroll(scrollView: UIScrollView) {
      // Load the pages that are now on screen
      loadVisiblePages()
   }
   
   
   // Zooming
   func centerScrollViewContents() {
      let boundsSize = scrollView.bounds.size
      var contentsFrame = pageViews[pageControl.currentPage]!.frame
      
      if contentsFrame.size.width < boundsSize.width {
         contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
      } else {
         contentsFrame.origin.x = 0.0
      }
      
      if contentsFrame.size.height < boundsSize.height {
         contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
      } else {
         contentsFrame.origin.y = 0.0
      }
      
      pageViews[pageControl.currentPage]!.frame = contentsFrame
      
   }

   func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
      println("here")
      // 1
      let pointInView = recognizer.locationInView(pageViews[pageControl.currentPage])
      
      // 2
      var newZoomScale = scrollView.zoomScale * 1.5
      newZoomScale = min(newZoomScale, scrollView.maximumZoomScale)
      
      // 3
      let scrollViewSize = scrollView.bounds.size
      let w = scrollViewSize.width / newZoomScale
      let h = scrollViewSize.height / newZoomScale
      let x = pointInView.x - (w / 2.0)
      let y = pointInView.y - (h / 2.0)
      
      let rectToZoomTo = CGRectMake(x, y, w, h);
      
      // 4
      scrollView.zoomToRect(rectToZoomTo, animated: true)
   }
   
   func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
      return pageViews[pageControl.currentPage]
   }
   
   func scrollViewDidZoom(scrollView: UIScrollView) {
      centerScrollViewContents()
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
}
