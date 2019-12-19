//
//  MyTableViewController.swift
//  MenuApp
//
//  Created by Денис Андреев on 30.11.2019.
//  Copyright © 2019 Денис Андреев. All rights reserved.
//

import UIKit


class MyTableViewController: UITableViewController {
    
    let foodArray = ["Пельмени", "Борщ", "Вареники"]
    
    override func viewDidLoad() {
        
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = foodArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main) // Создаем константу с нашим Storyboard.
        let destination = storyboard.instantiateViewController(withIdentifier: "moreTextVC")
        switch row {
        case 0:
            rowNumber = 0
            navigationController?.pushViewController(destination, animated: true)
        case 1:
            rowNumber = 1
            navigationController?.pushViewController(destination, animated: true)
        case 2:
            rowNumber = 2
            navigationController?.pushViewController(destination, animated: true)
        default:
            print("Error")
        }
    }
    
    
}
