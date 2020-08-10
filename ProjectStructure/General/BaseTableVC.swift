///*

let PAGE_ORIGIN = 1

class BaseTableVC: BaseVC, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: NAVIGATIONBAR_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.addSubview(self.tableBackgroundView)
        if #available(iOS 11, *){
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.estimatedRowHeight = 0
            tableView.estimatedSectionFooterHeight = 0
            tableView.estimatedSectionHeaderHeight = 0
        }
        return tableView
    }()
    lazy var tableBackgroundView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: -W(400), width: SCREEN_WIDTH, height: W(400))
                      view.backgroundColor = UIColor.clear
                      view.tag = TAG_LINE
        return view
    }()
    lazy var aryDatas: Array<Any> = {
        let ary:Array<Any> = Array()
        return ary
    }()
    var pageNum: Int = PAGE_ORIGIN
    lazy var sectionIndexView: SectionIndexView = {
        var view = SectionIndexView.init()
        return view
    }()

    //索引
    func addRefresh() {
        self.addRefreshHeader()
        self.addRefreshFooter()
    }
    func addRefreshHeader() {
        self.tableView.mj_header = MJRefreshNormalHeader.init()
        self.tableView.mj_header.setRefreshingTarget(self, refreshingAction: #selector(refreshHeaderAll))
        self.tableView.insertSubview(self.tableBackgroundView, at: 0)
    }
    func addRefreshFooter() {
        self.tableView.mj_footer = MJRefreshFooter.init()
        self.tableView.mj_footer.setRefreshingTarget(self, refreshingAction: #selector(refreshFooterAll))
    }
    @objc func refreshHeaderAll() {
        self.tableView.mj_footer.isUserInteractionEnabled = false
        self.pageNum = PAGE_ORIGIN
        self.requestList()
    }
    @objc func refreshFooterAll() {
        self.tableView.mj_header.isUserInteractionEnabled = false
        self.requestList()
    }
    func endRefreshing() {
        self.tableView.mj_header.isUserInteractionEnabled = true
        self.tableView.mj_footer.isUserInteractionEnabled = true
        self.tableView.mj_header.endRefreshing()
        self.tableView.mj_footer.endRefreshing()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.aryDatas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return ({ () -> UITableViewCell in
            var cell: UITableViewCell! = self.tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
            if cell == nil {
                cell = UITableViewCell.init()
            }
            return cell
        })()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func requestList() {
    }
    override func showNoResult() {
        self.noResultLoadingView.removeFromSuperview()
        self.noResultView.removeFromSuperview()
        if !self.isShowNoResult {
            return
        }
        if self.aryDatas.count == 0 {
            var top: CGFloat = 0
            if self.tableView.tableHeaderView != nil {
                top = self.tableView.tableHeaderView?.height ?? 0
            }
            self.noResultView.show(view: self.tableView, frame: CGRect.init(x: 0, y: top, width: self.tableView.width, height: self.tableView.height))
        }
    }
    override func showNoResultLoadingView() {
        self.noResultLoadingView.removeFromSuperview()
        if !self.isShowNoResultLoadingView {
            return
        }
        if self.aryDatas.count == 0 {
            var top: CGFloat = 0
            if self.tableView.tableHeaderView != nil {
                top = self.tableView.tableHeaderView?.height ?? 0
            }
            self.noResultLoadingView.show(view: self.tableView, frame:  CGRect(x: 0, y: top, width: self.tableView.width, height: self.tableView.height))
        }
    }
}
// */
