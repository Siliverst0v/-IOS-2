//
//  NetworkManager.swift
//  Тестовое IOS
//
//  Created by Анатолий Силиверстов on 13.10.2022.
//

import Foundation
import UIKit

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
    
    func loadImage(url: URL?, completion: @escaping (UIImage?) -> Void) {
        guard let url = url else { return }

        if let cachedImage = imageFrom(url: url) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
            return
        }
        URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
            guard let responseData = data, let image = UIImage(data: responseData),
              error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            self.saveImageToCache(image: image, url: url, cost: responseData.count)
        }.resume()
    }
    
    func imageFrom(url: URL) -> UIImage? {
        if let cachedImage = ImageCache.shared.object(forKey: url.absoluteString as NSString) {
            return cachedImage
        }
        return nil
    }
    
    func saveImageToCache(image: UIImage,url: URL, cost: Int) {
            ImageCache.shared.setObject(image, forKey: url.absoluteString as NSString, cost: cost)
    }
}
