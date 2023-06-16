//
//  AppIcons.swift
//  Alien
//
//  Created by Daniel Correia on 18.02.23.
//

public let AppIconGroups: [(String, [String])] =
[
    ApplianceAndEletronic,
    BasicDesign,
    BeautyAndCosmetics,
    BusinessAndFinance,
    ClothesAndAccessory,
    CommunicationAndMultimedia,
    EnergyAndEnvironment,
    EngineerAndConstruction,
    InteriorAndHomedecor,
    LifestyleAndEntertainment,
    MedicalAndHealthcare,
    SportAndFitness,
    Transportation,
    Tasks
]

public func getAllIcons() -> [String] {
    var icons: [String] = []
    for iconGroup in AppIconGroups {
        icons.append(contentsOf: iconGroup.1)
    }
    
    return icons
}
