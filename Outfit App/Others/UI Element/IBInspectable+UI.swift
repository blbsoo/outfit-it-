//
//  IBDesignable+UITextField.swift
//  No Ferpa No Party
//
//  Created by MacAdmin on 11/01/21.
//

import UIKit

@IBDesignable class main: UILabel {
    
    
    @IBInspectable var topInset: CGFloat = 0.0
        @IBInspectable var bottomInset: CGFloat = 0.0
        @IBInspectable var leftInset: CGFloat = 10.0
        @IBInspectable var rightInset: CGFloat = 10.0
        
        override func drawText(in rect: CGRect) {
            let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
            super.drawText(in: rect.inset(by: insets))
        }
        
        override var intrinsicContentSize: CGSize {
            let size = super.intrinsicContentSize
            return CGSize(width: size.width + leftInset + rightInset,
                          height: size.height + topInset + bottomInset)
        }


    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
      }
    }

@IBDesignable class BorderPaddingTextField : UITextField {
    
        @IBInspectable var paddingLeftCustom: CGFloat {
            get {
                return leftView!.frame.size.width
            }
            set {
                let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
                leftView = paddingView
                leftViewMode = .always
            }
        }
 
        @IBInspectable var paddingRightCustom: CGFloat {
            get {
                return rightView!.frame.size.width
            }
            set {
                let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
                rightView = paddingView
                rightViewMode = .always
            }
        }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
        layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
      }
    }

@IBDesignable class BorderButton : UIButton {
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
        layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}


@IBDesignable class BorderView : UIView {
    @IBInspectable var shadowColor: UIColor = .clear {
        didSet {
        layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
        layer.shadowOpacity = shadowOpacity
            layer.shadowOffset = .zero
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }

    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
        layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}


@IBDesignable class BorderImageView : UIImageView {
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
        layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}


@IBDesignable class radiusLabel: UILabel {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
      }
    }
