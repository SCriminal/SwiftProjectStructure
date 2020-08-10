import UIKit

class SectionIndexView: UIView {
    var tableView: UITableView!
    lazy var aryDatas: Array<String?> = {
        var ary = Array<String?>.init()
        return ary
    }()
    lazy var sectionIndexColor: UIColor = {
        var color = UIColor.init()
        return color
    }()
    var itemHeight: CGFloat = 0.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        let tap: UITapGestureRecognizer! = UITapGestureRecognizer(target: self, action: #selector(tapClick(_:)))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    func resetWithAry(_ ary: Array<String?>, tableView: UITableView!, viewShow view: UIView!, rightCenterY: (CGFloat, CGFloat)) {
        self.tableView = tableView

        self.aryDatas = ary

        self.width = W(50)

        self.removeAllSubViews()

        var top: CGFloat = 0
        for modelSection in ary {
            if let modelSection = modelSection {
                let label = UILabel()
                label.backgroundColor = .clear
                label.font = UIFont.systemFont(ofSize: F(10), weight: .regular)
                label.textColor = self.sectionIndexColor
                label.numberOfLines = 1
                label.textAlignment = .center
                label.fit(title: modelSection ??? "", variable: W(15))
                label.centerXTop = (self.width/2.0,top)
                top = label.bottom + W(3)
                self.addSubview(label)
                if self.itemHeight == 0 {
                    self.itemHeight = top
                }
            }
        }
       
        self.height = top
        self.rightCenterY = rightCenterY
        view.addSubview(self)
    }
    @objc func tapClick(_ tap: UITapGestureRecognizer!) {
        let point = tap.location(in: self)
        let index = Int(point.y / self.itemHeight)
        if self.tableView.numberOfSections > index {
            self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: Int(index)), at: .top, animated: true)
        }
    }
}
