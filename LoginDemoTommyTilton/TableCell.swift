import Foundation
import UIKit


class TableCell: UITableViewCell {
    
    init(text: String, style: UITableViewCell.CellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let PADDING: CGFloat = 20.0
        let titleLabel = UILabel()
        titleLabel.tintColor = Colors.appTintColor.color
        titleLabel.text = text
        titleLabel.textColor = Colors.tableCellTextColor.color
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
       
        self.addSubview(titleLabel)
        
  //      let imageView = UIImageView()
 //     let bundle = Bundle(for: ORKOrderedTask.self)
 //       let image = UIImage(named: iconName, in: bundle, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
 //      imageView.image = image
 //      imageView.contentMode = .scaleAspectFit
 //       imageView.translatesAutoresizingMaskIntoConstraints = false
 //       self.addSubview(imageView)
  /*
        imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: PADDING).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 25.0).isActive = true
        
        if image != nil {
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10.0).isActive = true
        } else {
            titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: PADDING).isActive = true
        }
     */
        
      
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: PADDING).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -PADDING).isActive = true
        //titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  -PADDING).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: PADDING).isActive = true
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
