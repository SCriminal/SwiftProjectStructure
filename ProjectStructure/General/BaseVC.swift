import UIKit

class BaseVC: UIViewController, UITextFieldDelegate, RequestDelegate{
    lazy var loadingView: LoadingView = {
        let view = LoadingView()
        print("lazy init loading view")
        return view
    }()
//    private var _noticeView: UnsafeMutablePointer<NoticeView>!
    lazy var viewBG: UIView = {
        let view = UIView()
        view.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        return view
    }()
//    private var _noResultView: UnsafeMutablePointer<NoResultView>!
//    private var _noResultLoadingView: UnsafeMutablePointer<NoResultView>!
    var isNotShowNoticeView: Bool = false
    var isNotShowLoadingView: Bool = false
    //不显示notice
    var isShowNoResult: Bool = false
    //不显示loading
    var isShowNoResultLoadingView: Bool = false
   
  
  

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

//    func viewBG() -> UIView! {
//        if !_viewBG {
//            _viewBG = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
//            _viewBG.backgroundColor = COLOR_BACKGROUND
//        }
//
//        return _viewBG
//    }
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.navigationController?.responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)) ?? false {
            //增加侧滑
            self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        }
        if #available(iOS 11, *){
        }else{
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.view.backgroundColor = UIColor.white
        //设置背景颜色
        self.view.insertSubview(self.viewBG, at: 0)
    }
    //无结果页
    func addObserveOfKeyboard() {
        self.isKeyboardObserve = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = GlobalMethod.canLeftSlide()

        if self.isKeyboardObserve {
            self.addKeyboardObserve()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isKeyboardObserve {
            self.removeKeyboardObserve()
        }
    }
   /*
    func noticeView() -> UnsafeMutablePointer<NoticeView>! {
        if _noticeView == nil {
            _noticeView = NoticeView()
        }

        return _noticeView
    }
    func noResultView() -> UnsafeMutablePointer<NoResultView>! {
        if !_noResultView {
            _noResultView = NoResultView()
        }

        return _noResultView
    }
    func noResultLoadingView() -> UnsafeMutablePointer<NoResultView>! {
        if !_noResultLoadingView {
            _noResultLoadingView = NoResultView()
        }

        return _noResultLoadingView
    }
    func protocolWillRequest() {
        self.showNoResultLoadingView()
        self.showLoadingView()
    }
    //无结果页
    func showLoadingView() {
        //show loading view
        self.loadingView.hideLoading()

        if self.isNotShowLoadingView {
            return
        }

        self.loadingView.resetFrame(CGRect(x: 0, y: NAVIGATIONBAR_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT), viewShow: self.view)
    }
    func showNoResultLoadingView() {
        self.noResultLoadingView.removeFromSuperview()

        if !self.isShowNoResultLoadingView {
            return
        }

        self.noResultLoadingView.showInView(self.view, frame: CGRect(x: 0, y: NAVIGATIONBAR_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT))
    }
    func showNoResult() {
        self.noResultLoadingView.removeFromSuperview()
        self.noResultView.removeFromSuperview()

        if !self.isShowNoResult {
            return
        }

        self.noResultView.showInView(self.view, frame: CGRect(x: 0, y: NAVIGATIONBAR_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT))
    }
    func protocolDidRequestSuccess() {
        self.loadingView.hideLoading()
    }
    func protocolDidRequestFailure(_ errorStr: String!) {
        self.loadingView.hideLoading()

        if self.isNotShowNoticeView {
            return
        }

        GlobalMethod.endEditing()

        if self.view.isShowInScreen() && isStr(errorStr) {
            self.noticeView.showNotice(errorStr, time: 1, frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), viewShow: UIApplication.sharedApplication().keyWindow)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool {
        self.view.endEditing(true)

        return true
    }
    func preferredStatusBarStyle() -> UIStatusBarStyle {
        return GlobalData.sharedInstance().statusBarStyle
    }
    func prefersStatusBarHidden() -> Bool {
        return GlobalData.sharedInstance().statusHidden
    }
 */
}
