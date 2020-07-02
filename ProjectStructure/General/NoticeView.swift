import UIKit

class NoticeView: UIView {
    lazy var control: UIControl = {
        let control = UIControl()
                   control.backgroundColor = UIColor.clear
        control.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        return control
    }()
    lazy var viewBG: UIView = {
        let viewBG = UIView()
        viewBG.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                   viewBG.addSubview(self.labelNotice)
        return viewBG
    }()
    lazy var labelNotice: UILabel = {
        let labelNotice = UILabel()
        labelNotice.numberOfLines = 0
        labelNotice.fontNum = F(13)
        labelNotice.textColor = .white
        labelNotice.fit(title: "",variable: 0)
        return labelNotice
    }()
    lazy var timer: Timer? = {
        return Timer()
    }()
    lazy var numTime: Int = 0
   
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.viewBG)
        self.addSubview(self.control)
        self.isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showNotice(_ strNotice: String!, time timeShow: CGFloat, frame: CGRect, viewShow: UIView!) {
        //去掉空格
        let aryStr = strNotice.split(separator: " ")
        let strNotice = aryStr.joined(separator: "")

        self.timerStop()

        //停止定时器
        self.frame = frame

        self.control.frame = self.bounds

        self.labelNotice.fit(title: strNotice, variable: SCREEN_WIDTH - W(40))

        //设置label
        self.viewBG.height = self.labelNotice.height + W(16)
        self.viewBG.width = self.labelNotice.width + W(20)
        self.viewBG.bottom = self.height - W(60)
        self.viewBG.addRoundCorner(corner: UIRectCorner.allCorners, radius: 5)
        self.viewBG.centerX = self.width / 2.0

        self.labelNotice.center = (x: self.viewBG.width / 2.0, y: self.viewBG.height / 2.0)

        viewShow.addSubview(self)

        self.numTime = Int(timeShow)

        //启动定时器
        self.timerStart()
    }
    func timerStart() {
        if timer == nil {
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerRun), userInfo: nil, repeats: true)
        }
    }
    @objc func timerRun() {
        if numTime <= 0 {
            //每秒的动作
            self.timerStop()

            return
        }

        numTime -= 1
    }
    func timerStop() {
        if timer != nil {
            timer?.invalidate()
            self.timer = nil
        }
        //停止定时器
        self.removeFromSuperview()
    }
    
    @objc func btnClick(_ sender: UIButton!) {
        self.timerStop()
    }
}
