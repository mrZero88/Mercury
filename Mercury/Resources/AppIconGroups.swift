//
//  AppIcons.swift
//  Alien
//
//  Created by Daniel Correia on 18.02.23.
//

public let AppIconGroups: [(String, [String])] =
[
    //AnimalKingdom,
    ApplianceAndEletronic,
    //BasicDesign,
    //BeautyAndCosmetics,
    BusinessAndFinance,
    //ChartAndGraph,
    //ChristmasAndNewYear,
    ClothesAndAccessory,
    CommunicationAndMultimedia,
    //EducationAndScience,
    //EnergyAndEnvironment,
    //EngineerAndConstruction,
    FamilyAndBaby,
    //FileAndDocument,
    //HumanCivilization,
    InteriorAndHomedecor,
    //Japan,
    //LifestyleAndEntertainment,
    //LoveAndWedding,
    //MedicalAndHealthcare,
    //MusicAndInstrument,
    NatureAndLandscape,
    SpaceAndAstronomy,
    SportAndFitness,
    Transportation,
    //WeatherForecast
]

public let AllIcons = getAllIcons()

public func getAllIcons() -> [String] {
    var icons: [String] = []
    for iconGroup in AppIconGroups {
        icons.append(contentsOf: iconGroup.1.prefix(upTo: 20))
    }
    return icons
}
