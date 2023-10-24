//
//  CardView.swift
//  StartUp
//
//  Created by עומר צרויה on 11/12/2020.
//

import UIKit
import SDWebImage

//utils

enum SwipeDirection: Int {
    
    case left =  -1
    case right = 1
    
}

protocol CardViewDelegate:class {
    func cardView(_view:CardView,wantsToShowProfileFor user:User)
    func cardView(_ view:CardView,didLikeUser: Bool)
    
}

class CardView: UIView {
    
    // MARK: - pripeties
    
    weak var delegate:CardViewDelegate?
    
    private let gradientLayer = CAGradientLayer()
    
     let viewModel:CardViewModel
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
        
    }()
    
    private lazy var infoLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 1
        label.attributedText = viewModel.userInfoText
        return label
        
    }()
    
 
    
    private let whatIknowlabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 1
        let atributedText = NSMutableAttributedString(string: "יכולות שאני מביא איתי" , attributes: [.font : UIFont.systemFont(ofSize:30, weight: .heavy) ,.foregroundColor:UIColor.white])
        label.attributedText = atributedText
        return label
        
    }()
    
    private lazy var anwerWhatiKnow: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 1
        label.attributedText = viewModel.userInfoText3
        return label
        
    }()
    
    private let experiencelabel: UILabel = {
        
        let label = UILabel()
        let atributedText = NSMutableAttributedString(string: "ניסיון סטארט-אפיסטי" , attributes: [.font : UIFont.systemFont(ofSize:30, weight: .heavy) ,.foregroundColor:UIColor.white])
        label.numberOfLines = 1
        label.attributedText = atributedText

        return label
        
    }()
    
    private lazy var anwerexperiencelabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 1
        label.attributedText = viewModel.userInfoText4

        return label
        
    }()
    
    private let experiencelabelfriend: UILabel = {
        
        let label = UILabel()
        let atributedText = NSMutableAttributedString(string:"יכולות רצויות בשותף" , attributes: [.font : UIFont.systemFont(ofSize:30, weight: .heavy) ,.foregroundColor:UIColor.white])
        label.numberOfLines = 1
        label.attributedText = atributedText

        return label
        
    }()
    
    private lazy var anwerexperiencelabelfriend: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 1
        label.attributedText = viewModel.userInfoText5

        return label
        
    }()
    
    
    
    private lazy var infoButton:UIButton = {
       
        let button = UIButton(type:  .system)
        button.setDimensions(height: 100, width: 120)
        button.setImage(#imageLiteral(resourceName: "info_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleShowProile), for: .touchUpInside)
        return button
        
    }()
    
    
    private lazy var blockButton:UIButton = {
       
        let button = UIButton(type:  .system)
        button.setDimensions(height: 100, width: 120)
        button.setImage(#imageLiteral(resourceName: "blockuse").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleShowReport), for: .touchUpInside)
        return button
        
    }()
   
    // MARK: - lifecycele
    
        init(viewModel: CardViewModel) {
            self.viewModel = viewModel
        super.init(frame: .zero)
        
        configureGestureRecognizeres()
            
        imageView.sd_setImage(with: viewModel.imageUrl)
      
        
        backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.fillSuperview()
        
        configureGradientLayer()
            
            
           
        
        addSubview(infoLabel)
        infoLabel.anchor(  bottom: bottomAnchor , right: rightAnchor , paddingLeft: 16 , paddingBottom:220, paddingRight: 16)
        
       
        
        addSubview(whatIknowlabel)
        whatIknowlabel.anchor(  bottom: bottomAnchor , right: rightAnchor , paddingLeft: 16 , paddingBottom:178, paddingRight: 16)
        
        
        addSubview(anwerWhatiKnow)
        anwerWhatiKnow.anchor(  bottom: bottomAnchor , right: rightAnchor , paddingLeft: 16 , paddingBottom:160, paddingRight: 16)
        
        addSubview(experiencelabel)
        experiencelabel.anchor(  bottom: bottomAnchor , right: rightAnchor , paddingLeft: 16 , paddingBottom:120, paddingRight: 16)
        
        
        addSubview(anwerexperiencelabel)
        anwerexperiencelabel.anchor(  bottom: bottomAnchor , right: rightAnchor , paddingLeft: 16 , paddingBottom:100, paddingRight: 16)
        
        addSubview(experiencelabelfriend)
        experiencelabelfriend.anchor(  bottom: bottomAnchor , right: rightAnchor , paddingLeft: 16 , paddingBottom:55, paddingRight: 16)
        
        
        addSubview(anwerexperiencelabelfriend)
        anwerexperiencelabelfriend.anchor(  bottom: bottomAnchor , right: rightAnchor , paddingLeft: 16 , paddingBottom:35, paddingRight: 16)
           
          
          
        
        addSubview(infoButton)
        infoButton.setDimensions(height: 40, width:40)
        infoButton.centerY(inView: infoLabel)
        infoButton.anchor(left:leftAnchor , paddingLeft: 16)
            
        addSubview(blockButton)
            blockButton.setDimensions(height: 50, width:500)
           
      
        
    }
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - actions
    
    
    @objc func handleShowProile(){
        delegate?.cardView(_view: self, wantsToShowProfileFor: viewModel.user)
    }
    
    
    
    @objc func handleShowReport(){
        
        
        let alert = UIAlertController(title: " דיווח",message:"תודה על הדיווח על שימוש לרעה אנו נטפל בכך",
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "סגור",style:UIAlertAction.Style.default,handler: nil))
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    
        let userBlock = viewModel.user.uid
        let Data = ["uid": userBlock]
       
       COLLECTION_Report.document(userBlock).collection("Report").document(userBlock).setData(Data)
    
    }
    
    @objc func handlepanGesture(sender: UIPanGestureRecognizer){
        let translation = sender.translation(in: nil)
 
        switch sender.state {
        
        
        case .began:
            superview?.subviews.forEach({ $0.layer.removeAllAnimations() })
            
        case .changed:
            let degrees: CGFloat = translation.x / 20
            let angle = degrees * .pi / 180
            let rotationTransform = CGAffineTransform(rotationAngle: angle)
            self.transform = rotationTransform.translatedBy(x: translation.x, y:translation.y)
            
        case .ended:
            resetCardPosition(sender: sender)
            default: break
                
        }
        
    }
    
  
    
    // MARK: - helpers
    
    func resetCardPosition(sender: UIPanGestureRecognizer){
          
        let direction: SwipeDirection = sender.translation(in: nil).x > 100 ? .right : .left
        let shouldDismissCard = abs(sender.translation(in: nil).x) > 100

        UIView.animate(withDuration: 0.75, delay:0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {

            if shouldDismissCard{
                let xTranslation = CGFloat(direction.rawValue) * 1000
                let offScreenTransform = self.transform.translatedBy(x: xTranslation, y: 0)
                self.transform = offScreenTransform
            }else {
                
                self.transform = .identity
            }
            
        }) { _ in
            if shouldDismissCard{
                let didLike = direction == .right
                self.delegate?.cardView(self, didLikeUser: didLike)
            }
        }

    }
    
    func configureGradientLayer(){
        
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5,1.1]
        layer.addSublayer(gradientLayer)
       
        
    }
    
    func configureGestureRecognizeres(){
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlepanGesture))
        addGestureRecognizer(pan)
        
        
    }
    
    
    
    
}
