//
//  Article+CoreDataProperties.swift
//  bchelste2022
//
//  Created by Artem Potekhin on 21.08.2022.
//
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var language: String?
    @NSManaged public var image: Data?
    @NSManaged public var creationDate: Date?
    @NSManaged public var modificationDate: Date?
    
    public override var description: String {
        """
        
        title:              \(title ?? "empty data")
        content:            \(content ?? "empty data")
        language:           \(language ?? "empty data")
        image:              \(image?.description ?? "empty data")
        creationDate:       \(creationDate ?? Date())
        modificationDate:   \(modificationDate ?? Date())
        
        """
    }

}
