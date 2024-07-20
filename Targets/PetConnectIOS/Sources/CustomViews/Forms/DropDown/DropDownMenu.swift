//
//  DropDownLabel.swift
//  PetConnect
//
//  Created by SHREDDING on 20.08.2023.
//

import UIKit
import SnapKit

@objc protocol DropDownMenuDelegate{
    @objc optional func didSelect(_ tableView: UITableView, indexPath: IndexPath)
    @objc optional func didDeselect(_ tableView: UITableView, indexPath: IndexPath)
}

class DropDownMenu: UIView {
        
    // MARK: - Delegate
    
    public var delegate:DropDownMenuDelegate?
    
    private let cellHeight:CGFloat = 56
    private var dropDownIsFocused:Bool = false
    private var rowSelected:IndexPath?
    
    private var items:[String] = []
        
    // MARK: - Views
        
    private lazy var borderView:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.layer.masksToBounds = true
        view.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(showCloseDropDownMenu))
        view.addGestureRecognizer(gesture)
        
        return view
    }()
    
    lazy var label:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .regualar, ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    lazy var chevron:UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(systemName: "chevron.down")
        view.tintColor = .darkGray
        return view
    }()
    
    lazy var upperLabelView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var upperLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .semibold, ofSize: 12)
        label.textColor = .greetingGreen
        label.textAlignment = .center
        return label
    }()
    
    lazy var tableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .singleLine
        
        tableView.backgroundColor = UIColor(resource: .dropDownTableViewBg)
        
        tableView.layer.cornerRadius = 20
        tableView.layer.cornerRadius = 20
        tableView.layer.shadowColor = UIColor.black.cgColor
        tableView.layer.shadowOpacity = 0.3
        tableView.layer.shadowRadius = 3
        tableView.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        tableView.register(DropDownTableViewCell.self, forCellReuseIdentifier: "DropDownTableViewCell")
        
        return tableView
    }()
    
    // MARK: - private Properties
                
    // MARK: - Public Properties
                
    public var placeholder:String = ""{
        didSet{
            self.setPlaceholder()
        }
    }
    
    public var cornerRadius:CGFloat = 0{
        didSet{
            self.borderView.layer.cornerRadius = cornerRadius
        }
    }
    
    open var upperTextBackgroundColor:UIColor = .white{
        didSet{
            self.upperLabelView.backgroundColor = upperTextBackgroundColor
            self.upperLabel.backgroundColor = upperTextBackgroundColor
        }
    }
        
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        fatalError("init(coder:) has not been implemented")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(placeholder:String){
        super.init(frame: CGRectZero)
        self.placeholder = placeholder
        commonInit()
    }
    
    init(items:[String], placeholder:String){
        super.init(frame: CGRectZero)
        self.items = items
        self.placeholder = placeholder
        commonInit()
    }
    
    private func commonInit(){
        self.clipsToBounds = false
        
        self.addSubview(borderView)
        self.borderView.addSubview(label)
        self.borderView.addSubview(chevron)
        
        self.addSubview(upperLabelView)
        self.upperLabelView.addSubview(upperLabel)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        borderView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(16)
        }
        
        chevron.snp.makeConstraints { make in
            make.width.equalTo(25)
            make.top.bottom.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(label.snp.trailing).offset(16)
        }
        
        upperLabelView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-7)
            make.leading.equalToSuperview().offset(16)
        }
        
        upperLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.bottom.equalToSuperview()
        }
        
        setPlaceholder()
    }
    
    public func configure(){
        self.superview?.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.width.equalTo(self)
            make.height.equalTo(0)
            make.top.equalTo(self.snp.bottom)
            make.leading.equalTo(self)
        }
    }
    
    public func setItems(items:[String]){
        self.items = items
        self.tableView.reloadData()
    }
            
   @objc public func showCloseDropDownMenu(){
       self.superview?.bringSubviewToFront(tableView)
       
       if !self.dropDownIsFocused{
           UIView.transition(with: self.tableView, duration: 0.3) {
               self.tableView.snp.updateConstraints { make in
                   make.height.equalTo(self.cellHeight * (self.items.count <= 5 ? CGFloat(self.items.count) : 5))
               }
               self.superview!.layoutIfNeeded()
               self.setFocused()
           }
       }else{
           UIView.transition(with: self.tableView, duration: 0.3) {
               
               self.tableView.snp.updateConstraints { make in
                   make.height.equalTo(0)
               }
               
               self.superview!.layoutIfNeeded()
               self.removeFocused()
           }
       }
       
    }
    
    
    private func setPlaceholder(){
        self.label.text = placeholder
        self.upperLabel.text = placeholder
        self.label.layer.opacity = 0.5
        self.upperLabelView.setOpacity(opacity: 0, animated: true)
    }
    
    public func setText(text:String){
        self.label.text = text
        self.label.layer.opacity = 1
        
        self.upperLabelView.setOpacity(opacity: 1, animated: true)
    }
    
    private func setFocused(){
        dropDownIsFocused = true
        self.borderView.layer.borderColor = UIColor(named: "GreetingGreen")?.cgColor
        self.upperLabel.textColor = UIColor(named: "GreetingGreen")
    }
    
    private func removeFocused(){
        dropDownIsFocused = false
        self.borderView.layer.borderColor = UIColor.black.cgColor
        self.upperLabel.textColor = UIColor.black
    }
}

extension DropDownMenu:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownTableViewCell", for: indexPath) as! DropDownTableViewCell
        cell.label.text = items[indexPath.row]
        
        return cell
    }
    
}

extension DropDownMenu:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        let cell = self.tableView.cellForRow(at: indexPath)
        
        if let selected = rowSelected {
            if selected != indexPath{
                let selectedCell = self.tableView.cellForRow(at: selected)
                selectedCell?.accessoryType = .none
            }
        }
        
        if cell?.accessoryType == .checkmark{
            cell?.accessoryType = .none
            self.rowSelected = nil
            delegate?.didDeselect?(tableView, indexPath: indexPath)
        }else{
            cell?.accessoryType = .checkmark
            self.rowSelected = indexPath
            delegate?.didSelect?(tableView, indexPath: indexPath)
        }
        
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            self.setText(text: items[indexPath.row])
        }else{
            self.setPlaceholder()
        }
        
        self.showCloseDropDownMenu()
        
    }
}
