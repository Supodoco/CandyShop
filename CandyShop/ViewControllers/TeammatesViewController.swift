//
//  TeammatesViewController.swift
//  CandyShop
//
//  Created by Supodoco on 25.10.2022.
//

import UIKit

class TeammatesViewController: UITableViewController {
    
    private let team = Teammate.getTeam()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        team.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Cells.teammate.rawValue,
            for: indexPath) as? TeammateCell
        else { return UITableViewCell() }
        let teammate = team[indexPath.row]
        cell.teammateImage.image = UIImage(named: teammate.image)
        cell.fullnameLabel.text = teammate.fullname
        cell.positionLabel.text = teammate.position
        let backView = UIView()
        backView.backgroundColor = .white
        cell.selectedBackgroundView = backView
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        312
    }
}
