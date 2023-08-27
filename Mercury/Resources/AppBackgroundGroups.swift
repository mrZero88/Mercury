//
//  AppBackgrounds.swift
//  Alien
//
//  Created by Daniel Correia on 18.06.23.
//

public let AppBackgroundGroups: [(String, [String])] =
[
    Ooorganize,
    Ccchaos,
    Uuundulate,
    Wwwhirl
]

public func getAllBackgrounds() -> [String] {
    var backgrounds: [String] = []
    for iconGroup in AppBackgroundGroups {
        backgrounds.append(contentsOf: iconGroup.1)
    }
    
    return backgrounds
}
