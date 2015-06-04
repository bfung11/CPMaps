//
//  Paged scroll view to display room floor plans
//
//

import UIKit

class FloorPlanPagedScrollViewController: UIViewController, UIScrollViewDelegate {
   
   @IBOutlet var scrollView: UIScrollView!
   @IBOutlet weak var pageControl: UIPageControl!
   
   var mainVC: MainViewController?
   var selectedBuilding: Building?
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
      
      self.navigationItem.leftBarButtonItem =
         UIBarButtonItem(barButtonSystemItem: .Cancel,
            target: self, action: "cancelButtonPressed:")
      self.navigationItem.title = selectedBuilding!.getNumber() + " - " + selectedBuilding!.getName()
      self.navigationItem.rightBarButtonItem =
         UIBarButtonItem(barButtonSystemItem: .Done,
            target: self, action: "doneButtonPressed:")
   }
   
   @IBAction func cancelButtonPressed(sender: AnyObject) {
      self.dismissViewControllerAnimated(true, completion: nil)
      //      self.performSegueWithIdentifier(cancelToLocationsTVC, sender: self)
   }
   
   @IBAction func doneButtonPressed(sender: AnyObject) {
      self.presentDoneActionSheet()
   }

   func setPages(building : Building) {
      self.selectedBuilding = building
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
   
   private func presentDoneActionSheet() {
      let mapTypesActionSheet: UIAlertController = UIAlertController(title:nil, message:nil, preferredStyle:UIAlertControllerStyle.ActionSheet)
      mapTypesActionSheet.addAction(UIAlertAction(title:"Set as current location", style:UIAlertActionStyle.Default, handler:{ action in
         self.mainVC!.mapViewController.showSelectedBuilding(self.selectedBuilding!)
         self.presentingViewController?.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
      }))
      mapTypesActionSheet.addAction(UIAlertAction(title:"Don't set as current location", style:UIAlertActionStyle.Default, handler:{ action in
         self.presentingViewController?.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
      }))
      mapTypesActionSheet.addAction(UIAlertAction(title:"Cancel", style:UIAlertActionStyle.Cancel, handler:nil))
      
      presentViewController(mapTypesActionSheet, animated:true, completion:nil)
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   
}
