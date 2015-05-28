//
//  Paged scroll view to display room floor plans
//
//

import UIKit

class FloorPlanPagedScrollViewController: UIViewController, UIScrollViewDelegate {
   
   @IBOutlet var scrollView: UIScrollView!
   @IBOutlet var pageControl: UIPageControl!
   
   var pageImages: [UIImage] = []
   var pageViews: [UIImageView?] = []
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // initialize the pages
      let pageCount = pageImages.count
      pageControl.currentPage = 0
      pageControl.numberOfPages = pageCount
      
      // 3
      for _ in 0..<pageCount {
         pageViews.append(nil)
      }
      
      // size page
      let pagesScrollViewSize = scrollView.frame.size
      scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * CGFloat(pageImages.count), pagesScrollViewSize.height)
      
      // 5
      loadVisiblePages()
   }
   
   
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
      
      // First, determine which page is currently visible
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
   
   
   func scrollViewDidScroll(scrollView: UIScrollView!) {
      // Load the pages that are now on screen
      loadVisiblePages()
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   
}
