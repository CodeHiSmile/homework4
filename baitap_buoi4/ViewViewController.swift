//
//  ViewViewController.swift
//  baitap_buoi4
//
//  Created by thanmanhvinh on 21/10/2021.
//
import RealmSwift
import UIKit

class ViewViewController: UIViewController, UITextFieldDelegate {

    public var item: ToDoListItem?
    public var deletionHandler: (()-> Void)?
    
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    private let realm = try! Realm()

    static let dateFormater: DateFormatter = {
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .medium
        return dateFormater
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        itemLabel.text = item!.titleTask
        dateLabel.text = Self.dateFormater.string(from: item!.date )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
    }
    
    @objc private func didTapDelete(){
        guard let myItem = self.item else {
            return
        }
        
        realm.beginWrite()
        
        realm.delete(myItem)
        
        try! realm.commitWrite()
        
        deletionHandler?()
        navigationController?.popToRootViewController(animated: true)
    }
}
