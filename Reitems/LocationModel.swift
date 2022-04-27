//
//  LocationModel.swift
//  Reitems
//
//  Created by Dennis Anthony on 27/04/22.
//

import Foundation

struct Category {
    let location: [LocationDetail]?
}

struct LocationDetail {
    var detailName: String?
    var detailAttribute: DetailAtributeModel?
}

struct DetailAtributeModel {
    var location: String?
    var desc: String?
    var date: String?
}
