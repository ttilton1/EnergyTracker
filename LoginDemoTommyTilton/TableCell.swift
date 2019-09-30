import Foundation
import UIKit


class TableCell: UITableViewCell {
    
    init(text: String, style: UITableViewCell.CellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let PADDING: CGFloat = 20.0
        let titleLabel = UILabel()
        titleLabel.text = text
        titleLabel.textColor = Colors.tableCellTextColor.color
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
       
        self.addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: PADDING).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -PADDING).isActive = true
        //titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  -PADDING).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: PADDING).isActive = true
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
