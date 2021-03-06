//
//  GraphView.swift
//  Get-up-from-your-chair
//
//  Created by Emil Shafigin on 28/6/21.
//

import UIKit

private enum Constants {
  static let cornerRadiusSize = CGSize(width: 8.0, height: 8.0)
  static let margin: CGFloat = 20.0
  static let topBorder: CGFloat = 60
  static let bottomBorder: CGFloat = 50
  static let colorAlpha: CGFloat = 0.3
  static let circleDiameter: CGFloat = 5.0
}

@IBDesignable
class GraphView: UIView {
  
  var activities = [4, 2, 6, 4, 5, 8, 3]
    
  @IBInspectable var startColor: UIColor = UIColor(red: 250/255, green: 233/255, blue: 222/250, alpha: 1)
  @IBInspectable var endColor: UIColor = UIColor(red: 252/255, green: 79/255, blue: 8/255, alpha: 1)
  
  override func draw(_ rect: CGRect) {
    
    let width = rect.width
    let height = rect.height
    
    let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: Constants.cornerRadiusSize)
    path.addClip()
    
    guard let context = UIGraphicsGetCurrentContext() else { return }
    
    let colors = [startColor.cgColor, endColor.cgColor]
    
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    
    let colorLocations: [CGFloat] = [0.0, 1.0]
    
    guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLocations) else {
      return
    }
    
    let startPoint = CGPoint.zero
    let endPoint = CGPoint(x: 0, y: bounds.height)
    context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
    
    let margin = Constants.margin
    let graphWidth = width - margin * 2 - 4
    let columnXPoint = { (column: Int) -> CGFloat in
      let spacing = graphWidth / CGFloat(self.activities.count - 1)
      return CGFloat(column) * spacing + margin + 2
    }
    let topBorder = Constants.topBorder
    let bottomBorder = Constants.bottomBorder
    let graphHeight = height - topBorder - bottomBorder
    guard let maxValue = activities.max() else { return }
    let columnYPoint = { (graphPoint: Int) -> CGFloat in
      let yPoint = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
      return graphHeight + topBorder - yPoint
    }
    
    UIColor.white.setFill()
    UIColor.white.setStroke()
    
    let graphPath = UIBezierPath()
    graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnYPoint(activities[0])))
    
    for i in 1..<activities.count {
      let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(activities[i]))
      graphPath.addLine(to: nextPoint)
    }
    
    context.saveGState()
    
    guard let clippingPath = graphPath.copy() as? UIBezierPath else {
      return
    }
    
    clippingPath.addLine(to: CGPoint(x: columnXPoint(activities.count - 1), y: height))
    clippingPath.addLine(to: CGPoint(x: columnXPoint(0), y: height))
    clippingPath.close()
    clippingPath.addClip()
    
    let highestYPoint = columnYPoint(maxValue)
    let graphStartPoint = CGPoint(x: margin, y: highestYPoint)
    let graphEndPoint = CGPoint(x: margin, y: bounds.height)
    
    context.drawLinearGradient(gradient, start: graphStartPoint, end: graphEndPoint, options: [])
    context.restoreGState()
    
    graphPath.lineWidth = 2.0
    graphPath.stroke()
    
    for i in 0..<activities.count {
      var point = CGPoint(x: columnXPoint(i), y: columnYPoint(activities[i]))
      point.x -= Constants.circleDiameter / 2
      point.y -= Constants.circleDiameter / 2
      
      let circle = UIBezierPath(ovalIn: CGRect(origin: point, size: CGSize(width: Constants.circleDiameter, height: Constants.circleDiameter)))
      circle.fill()
      
      let linePath = UIBezierPath()
      linePath.move(to: CGPoint(x: margin, y: topBorder))
      linePath.addLine(to: CGPoint(x: width - margin, y: topBorder))
      
      linePath.move(to: CGPoint(x: margin, y: graphHeight / 2 + topBorder))
      linePath.addLine(to: CGPoint(x: width - margin, y: graphHeight / 2 + topBorder))
      
      linePath.move(to: CGPoint(x: margin, y: height - topBorder))
      linePath.addLine(to: CGPoint(x: width - margin, y: height - topBorder))
      let color = UIColor(white: 1.0, alpha: Constants.colorAlpha)
      color.setStroke()
      
      linePath.lineWidth = 1.0
      linePath.stroke()
    }
  }

}
