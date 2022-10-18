//
//  Presenter.swift
//  Тестовое IOS
//
//  Created by Анатолий Силиверстов on 13.10.2022.
//

import Foundation

protocol PresenterProtocol {
    var teams: Welcome {get}
    var images:[String] {get}
    func fetchTeams(completion: @escaping () -> Void)
    func getTeam(for indexPath: IndexPath) -> WelcomeElement
    func getDivision(for indexPath: IndexPath) -> String
    func getImage(for indexPath: IndexPath) -> String
}

final class Presenter: PresenterProtocol {
    
    var teams: Welcome = []
    var images:[String] = ["volk", "medved", "korova", "laika"]
    private let divisions = [Division.дивизионБоброва, .дивизионТарасова, .дивизионХарламова, .дивизионЧернышева]
    
    func fetchTeams(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchTeamsData { teams in
            self.teams = teams.sorted(by: {$0.team.division.rawValue < $1.team.division.rawValue})
            completion()
        }
    }
    
    func getTeam(for indexPath: IndexPath) -> WelcomeElement {
        return self.teams[indexPath.row]
    }
        
    func getDivision(for indexPath: IndexPath) -> String {
        let rawDivisions = divisions.compactMap {$0.rawValue}
        return rawDivisions[indexPath.row]
    }
    
    func getImage(for indexPath: IndexPath) -> String {
        return images[indexPath.row]
    }
}
