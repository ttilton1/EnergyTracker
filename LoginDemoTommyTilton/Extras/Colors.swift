import UIKit

enum Colors {
    
    
    case tableViewCellBackgroundColor, tableViewBackgroundColor, tableCellTextColor, tableCellLineColor
    
    var color: UIColor {
        switch self {
      
        case .tableViewCellBackgroundColor:
            return UIColor.white
       //      button.backgroundColor = UIColor.init(red: 21/255, green: 70/255, blue: 232/255, alpha: 1)
        case .tableViewBackgroundColor:
         //   return UIColor(red: 21/255, green: 70/255, blue: 232/255, alpha: 1)
            return UIColor(red: 21/255, green: 70/255, blue: 232/255, alpha: 1)
        case .tableCellTextColor:
            return UIColor(red: 21/255, green: 70/255, blue: 232/255, alpha: 1)
            //return UIColor(red: 142.0 / 255.0, green: 141.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0)
        case .tableCellLineColor:
            return UIColor(red: 214.0 / 255.0, green: 214.0 / 255.0, blue: 214.0 / 255.0, alpha: 1.0)
            
            
    }
}

}
