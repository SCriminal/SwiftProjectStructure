import UIKit

class BaseVC: UIViewController, UITextFieldDelegate, RequestDelegate{
    lazy var loadingView: LoadingView = {
        let view = LoadingView()
        return view
    }()
    lazy var noticeView: NoticeView = {
        let view = NoticeView.init()
        return view
    }()
    lazy var viewBG: UIView = {
        let view = UIView()
        view.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        return view
    }()
    lazy var noResultView: NoResultView = {
        let view = NoResultView()
        return view
    }()
    lazy var noResultLoadingView: NoResultView = {
        let view = NoResultView()
        return view
    }()
    var isNotShowNoticeView: Bool = false
    var isNotShowLoadingView: Bool = false
    //不显示notice
    var isShowNoResult: Bool = false
    //不显示loading
    var isShowNoResultLoadingView: Bool = false
   
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

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
    
    //MARK: request protocol
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
        self.noResultLoadingView.show(view: self.view, frame: CGRect(x: 0, y: NAVIGATIONBAR_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT))
    }
    func showNoResult() {
        self.noResultLoadingView.removeFromSuperview()
        self.noResultView.removeFromSuperview()
        if !self.isShowNoResult {
            return
        }
        self.noResultView.show(view: self.view, frame: CGRect(x: 0, y: NAVIGATIONBAR_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT))
    }
    
     
    func protocolDidRequestSuccess() {
        self.loadingView.hideLoading()
    }
    func protocolDidRequestFailure(error: String?) {
        self.loadingView.hideLoading()

        if self.isNotShowNoticeView {
            return
        }

        if self.view.isShowInScreen() && (error?.count ?? 0) > 0 {
            noticeView.show(notice:error , time: 1, frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), viewShow: UIApplication.shared.keyWindow)
        }
        
    }
   
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    func preferredStatusBarStyle() -> UIStatusBarStyle {
        return GlobalData.statusBarStyle
    }
    func prefersStatusBarHidden() -> Bool {
        return GlobalData.isStatusHidden
    }
}
