//
//  MessagesController.swift
//  StartUp
//
//  Created by עומר צרויה on 15/12/2020.
//

import UIKit

private let reuseIdentifier = "MessageCell"

class MessagesController: UITableViewController {
    
    
    
    // MARK: - Properties
    
    private let user: User
    
    private lazy var headerView: MatchHeader = {
        let header = MatchHeader()
        header.delegate = self
        return header
    }()
    
   private var matches = [Match]() {
        didSet { tableView.reloadData() }
    }
    
    private var conversations = [Conversation]() {
        didSet { tableView.reloadData() }
    }
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationBar()
        fetchMatches()
        fetchRecentMessages()
        
    }
    
    // MARK: - Selectors
    
    @objc func handleDismissal() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - API
    
    func fetchRecentMessages() {
        MessagingService.shared.fetchConversations { conversations in
            self.conversations = conversations
           
        }
    }
    
    func fetchMatches() {
        Service.fetchMatches { matches in
            self.headerView.matches = matches
        }
    }
    
    // MARK: - Helpers
    
    func configureTableView() {
        tableView.rowHeight = 80
        tableView.tableFooterView = UIView()
        
        tableView.register(ConversationCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 180)
        tableView.tableHeaderView = headerView
    }
    
    func configureNavigationBar() {
        
        
        let tap = UIBarButtonItem(title: "חזור", style: .plain, target: self, action: #selector(handleDismissal))
        tap.tintColor = .gray
        navigationItem.leftBarButtonItem = tap
        
        
        let icon = UIImageView(image: #imageLiteral(resourceName: "message").withRenderingMode(.alwaysOriginal))
        icon.setDimensions(height: 50, width: 50)
        navigationItem.titleView = icon
    }
}

// MARK: - UITableViewDataSource

extension MessagesController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return conversations.count
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ConversationCell
        cell.viewModel = ConversationViewModel(conversation: conversations[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MessagesController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = conversations[indexPath.row].user
        let controller = ChatController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.text = "הודעות"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        view.addSubview(label)
        label.centerY(inView: view, leftAnchor: view.leftAnchor, paddingLeft:12)
        
        return view
    }
}

// MARK: - MatchHeaderDelegate

extension MessagesController: MatchHeaderDelegate {
    func matchHeader(_ header: MatchHeader, wantsToStartChatWith uid: String) {
        Service.fetchUser(withUid: uid) { user in
            let controller = ChatController(user: user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
