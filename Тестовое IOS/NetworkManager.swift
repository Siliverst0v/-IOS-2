//
//  NetworkManager.swift
//  Тестовое IOS
//
//  Created by Анатолий Силиверстов on 13.10.2022.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private let url = "https://khl.api.webcaster.pro/api/khl_mobile/teams_v2.json"
    
    func fetchTeamsData(completion: @escaping (_ teams: Welcome) -> Void) {
        guard let url = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let teams = try JSONDecoder().decode(Welcome.self, from: data)
                    completion(teams)
                
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
