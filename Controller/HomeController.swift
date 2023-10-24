//
//  HomeController.swift
//  StartUp
//
//  Created by עומר צרויה on 11/12/2020.
//

import UIKit
import Firebase

class HomeController: UIViewController {
    
    // properties
    private var user: User?
    private let topStack = HomeNavagationStackView()
    private let  bottomStack = BottomControllsStackView()
    private var topCardView: CardView?
    private var cardViews = [CardView]()
    
    
    
    
    
    private var viewModels = [CardViewModel]() {
        didSet {configureCards()}
    }
    
    //deckview cards 
    private let deckView: UIView = {
        let view = UIView()
        var img = UIImage(named: "deckview")
    
        view.backgroundColor = UIColor(patternImage: img!)
        view.layer.cornerRadius = 5
        return view
    }()
    
    //lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        checkUserIsLoggedIn()
        configureUI()
        fetchCurrentUserAndCards()
        
       
    }
    
    
    //MARK: - API
    
   
    func fetchUsers(){
        Service.fetchUsers { users in
            self.viewModels = users.map({CardViewModel(user: $0)})
        }
    }
    
    func fetchCurrentUserAndCards(){
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Service.fetchUser(withUid: uid) { user in
            self.user = user
            self.fetchUsers()
            
        }
        
    }
    
    
    func checkUserIsLoggedIn(){
        if Auth.auth().currentUser == nil {
            presentLoginControlller()
        }else {
            print("DEBUG: the user is log in ")
        }
        
    }
    
    func Logout(){
        do{
            try Auth.auth().signOut()
            presentLoginControlller()
        } catch {
            print("DEBUG: Failed to sign out")
        }
        
    }
    
    func saveSwipeAndCheckForMatch(forUser user: User, didLike: Bool) {
        Service.saveSwipe(forUser: user, isLike: didLike) { error in
            self.topCardView = self.cardViews.last
            
            guard didLike == true else { return }
            
            Service.checkIfMatchExists(forUser: user) { didMatch in
                self.presentMatchView(forUser: user)
                
                guard let currentUser = self.user else { return }
                Service.uploadMatch(currentUser: currentUser, matchedUser: user)
            }
        }
    }
    
    // Helpers func
    
    
    
    
    //crads
    func configureCards(){
        
        viewModels.forEach { viewModel in
            let cardView = CardView(viewModel: viewModel)
            cardView.delegate = self
           // cardViews.append(cardView)
            deckView.addSubview(cardView)
            cardView.fillSuperview()
            
            
        }
        
        cardViews = deckView.subviews.map({ ($0 as? CardView)!})
        topCardView = cardViews.last
       
        
    }
    
    //stack view
    func configureUI(){
        
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        
        topStack.delegate = self
        bottomStack.delegate = self

        let stack = UIStackView(arrangedSubviews: [topStack,deckView,bottomStack])
        stack.axis = .vertical
        
        view.backgroundColor =  .white
        
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor , bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
        stack.isLayoutMarginsRelativeArrangement = true
        stack .layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        stack.bringSubviewToFront(deckView)
        
        
        
    }
    
    
    
    func presentLoginControlller(){
        DispatchQueue.main.async {
            let controller = LoginController()
            controller.delegate = self
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
            
        }
    }
    
    
    
    
    func presentMatchView(forUser user: User) {
        guard let currentUser = self.user else { return }
        let viewModel = MatchViewViewModel(currentUser: currentUser, matchedUser: user)
        let matchView = MatchView(viewModel: viewModel)
        matchView.delegate = self
        view.addSubview(matchView)
        matchView.fillSuperview()
    }
    
    func performSwipeAnimation(shouldLike:Bool){
        
        let translation: CGFloat = shouldLike ? 700 : -700
        UIView.animate(withDuration: 1.0 , delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity:
                        0.1 , options: .curveEaseOut , animations:  {
        self.topCardView?.frame = CGRect(x: translation ,y: 0 , width: (self.topCardView?.frame.width)! , height: (self.topCardView?.frame.height)! )
                            
        }) { _ in
            self.topCardView?.removeFromSuperview()
            guard !self.cardViews.isEmpty else {return}
            self.cardViews.remove(at: self.cardViews.count - 1 )
            self.topCardView = self.cardViews.last
        }

        
    }
    
    fileprivate func startChat(withUser user: User) {
        guard let currentUser = self.user else { return }
        let controller = MessagesController(user: currentUser)
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true) {
            let controller = ChatController(user: user)
            nav.pushViewController(controller, animated: true)
        }
    }
}
    
    
    



// MARK - HomeNavigationStackViewDeleget

extension HomeController: HomeNavigationStackViewDeleget {
    func ShowSettings() {
        
        guard let user = self.user else {return}
       let controller = SettingsController(user: user)
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
        
    }
    
    func ShowMessages() {
        guard let user = user else { return }
        let controller = MessagesController(user: user)
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    
}

// MARK - SettingsControllerDelegate

extension HomeController:SettingsControllerDelegate {
    func SettingsControllerWantsToLogout(_controller: SettingsController) {
        _controller.dismiss(animated: true, completion: nil)
        Logout()
    }
    
    
    func settingsController(_ controller: SettingsController, wantsToUpdate user: User) {
        controller.dismiss(animated: true, completion: nil)
        self.user = user
    }
}

// MARK - CardViewDelegate

extension HomeController: CardViewDelegate {
    
    func cardView(_ view: CardView, didLikeUser: Bool) {
        view.removeFromSuperview()
        self.cardViews.removeAll(where: { view == $0 })
        
        guard let user = topCardView?.viewModel.user else {return}
        saveSwipeAndCheckForMatch(forUser: user, didLike: didLikeUser)

        self.topCardView = cardViews.last
    }
    
    
    
    func cardView(_view: CardView, wantsToShowProfileFor user: User) {
    let conroller = ProfileConroller(user: user)
        conroller.modalPresentationStyle = .fullScreen
         present(conroller, animated: true, completion: nil)
    }
    
}

extension HomeController:BottomControllsStackViewDelegate{
    func handleLike() {
        guard let topCard = topCardView else {return}
        
        performSwipeAnimation(shouldLike: true)
        saveSwipeAndCheckForMatch(forUser: topCard.viewModel.user, didLike: true)
   
    }
    
    func handleDislike() {
        
        guard let topCard = topCardView else {return}
        performSwipeAnimation(shouldLike: false)
        Service.saveSwipe(forUser:topCard.viewModel.user , isLike: false, completion: nil)
        
        
    }
    
    func handleRefresh() {
        print("regresh here ")
    }
    
    
}

extension HomeController: AuthnticationDelegate{
    func authenticationComplete() {
        dismiss(animated: true, completion: nil)
        fetchCurrentUserAndCards()
    }
    
}


extension HomeController: MatchViewDelegate {
    func matchView(_ view: MatchView, wantsToSendMessageTo user: User) {
        UIView.animate(withDuration: 0.5, animations: {
            view.alpha = 0
        }) { _ in
            view.removeFromSuperview()
            self.startChat(withUser: user)
        }
    }
}
