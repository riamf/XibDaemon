//
//  MobileMap.swift
//  Deamon
//
//  Created by Pawel Kowalczuk on 18/05/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import Foundation

protocol MapperType {
    func value(with key: String) -> String
}

struct Mapper: MapperType {
    let mapper: MapperType
    
    init(mapper: MapperType = MobileMap()) {
        self.mapper = mapper
    }
    
    func value(with key: String) -> String {
        return mapper.value(with:key)
    }
}

struct MobileMap: MapperType {
    private let prefix = "UI"
    private let map = [
        "mapView" : "MKMapView"
    ]
    
    func value(with key: String) -> String {
        return map[key] ?? prefix + key.UICapitalized
    }
}

private extension String {
    
    var UICapitalized: String {
        
        let capitalizeWords = [
            "view", "cell", "indicator", "control", "Field", "Picker"
        ]
        var capitalized = self.capitalized
        
        for word in capitalizeWords {
            capitalized = capitalized.replacingOccurrences(of: word, with: word.capitalized)
        }
        return capitalized
    }
}
