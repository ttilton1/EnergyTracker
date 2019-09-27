import UIKit

enum Colors {
    
    
    private func tremorGraphColor() -> UIColor {
        return UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }
    
    private func dyskinesiaGraphColor() -> UIColor {
        return UIColor(red: 21/255, green: 70/255, blue: 232/255, alpha: 1)
    }
    
    case appTintColor, tableViewCellBackgroundColor, tableViewBackgroundColor, tableCellTextColor, tableCellLineColor
    
    var color: UIColor {
        switch self {
            
        case .appTintColor:
            
            let backgroundGradientLayer = CAGradientLayer()
            backgroundGradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 1000.0)
            
            let cgColors = [tremorGraphColor().cgColor, dyskinesiaGraphColor().cgColor]
            
            backgroundGradientLayer.colors = cgColors
            //    backgroundGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            backgroundGradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            //    backgroundGradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            backgroundGradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            UIGraphicsBeginImageContext(backgroundGradientLayer.bounds.size)
            backgroundGradientLayer.render(in: UIGraphicsGetCurrentContext()!)
            let backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return UIColor(patternImage: backgroundColorImage!)
      
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
