
import UIKit

class ScreenshotsViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    var colors:[UIColor] = [UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor(), UIColor.yellowColor()]
    var frame: CGRect = CGRectMake(0, 0, 0, 0)
    @IBOutlet var pageControl: UIPageControl!
    
    
    override func viewDidLoad() {
        
        self.pageControl.numberOfPages = colors.count
        self.pageControl.currentPage = 0
        self.view.addSubview(pageControl)
        
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        
        for index in 0..<4 {
            
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            frame.size = self.scrollView.frame.size
            self.scrollView.pagingEnabled = true
            
            let subView = UIView(frame: frame)
            subView.backgroundColor = colors[index]

            self.scrollView.addSubview(subView)
        }
        
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 4, self.scrollView.frame.size.height)
        pageControl.addTarget(self, action: Selector("changePage:"), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPointMake(x, 0), animated: true)
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}