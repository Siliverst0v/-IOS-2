//
//  Model.swift
//  Тестовое IOS
//
//  Created by Анатолий Силиверстов on 13.10.2022.
//

import Foundation

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let team: Team
}

// MARK: - Team
struct Team: Codable {
    let id, khlID: Int
    let name, location: String
    let image: String
    let division: Division
    let divisionKey: DivisionKey
    let conference: Conference
    let conferenceKey: ConferenceKey

    enum CodingKeys: String, CodingKey {
        case id
        case khlID = "khl_id"
        case name, location, image, division
        case divisionKey = "division_key"
        case conference
        case conferenceKey = "conference_key"
    }
}

enum Conference: String, Codable {
    case конференцияВосток = "Конференция «Восток»"
    case конференцияЗапад = "Конференция «Запад»"
}

enum ConferenceKey: String, Codable {
    case east = "east"
    case west = "west"
}

enum Division: String, Codable {
    case дивизионБоброва = "Дивизион Боброва"
    case дивизионТарасова = "Дивизион Тарасова"
    case дивизионХарламова = "Дивизион Харламова"
    case дивизионЧернышева = "Дивизион Чернышева"
}

enum DivisionKey: String, Codable {
    case bobrov = "bobrov"
    case chernyshev = "chernyshev"
    case kharlamov = "kharlamov"
    case tarasov = "tarasov"
}

typealias Welcome = [WelcomeElement]

