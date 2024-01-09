//
//  LifeForm.swift
//  Life-Form-Search
//
//  Created by Dax Gerber on 1/8/24.
//

import Foundation

struct LifeForm: Codable {
    var id: Int
    var title: String
    var link: String
    var content: String
}

struct LifeForms: Codable {
    var results: [LifeForm]
}

struct Page: Codable {
    var taxonConcept: TaxonConcept
}

struct TaxonConcept : Codable {
    var identifier: Int
    var dataObjects: [DataObject]?
    var taxonConcepts: [InsideTaxonConcept]?
}

struct DataObject: Codable {
    var eolMediaURL: String
    var title: String
    var rightsHolder: String?
    var license: String
    var agents: [Agent]
    var mimeType: String?
}

struct Agent: Codable {
    var full_name: String
    var role: String
}

struct InsideTaxonConcept: Codable {
    var identifier: Int
    var scientificName: String
    var nameAccordingTo: String
}

struct HierarchyPage: Codable {
    
}
