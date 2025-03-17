//
//  CoreDataRealEstateRepository.swift
//  IdealistaChallenge
//
//  Created by David López on 15/3/25.
//

import Foundation
import CoreData

protocol RealEstateRepository {
    func getAllRealEstates() -> [RealEstate]
    func getRealEstate(byCode code: String) -> RealEstate?
    func save(realEstate: RealEstate)
    func delete(realEstate: RealEstate)
    func deleteAll()
    func toggleFavorite(for realEstate: RealEstate) -> RealEstate
    func isRealEstateFavorite(propertyCode: String) -> Bool
}

class FavoritesRealEstateRepository: RealEstateRepository {
    
    let coreDataStack: CoreDataStack
    private let mapper: RealEstateEntityMapper
    
    init(coreDataStack: CoreDataStack = CoreDataStack.shared, mapper: RealEstateEntityMapper = RealEstateEntityMapper()) {
        self.coreDataStack = coreDataStack
        self.mapper = mapper
    }
    
    func getAllRealEstates() -> [RealEstate] {
        
        let fetchRequest: NSFetchRequest<RealEstateEntity> = RealEstateEntity.fetchRequest()
        
        do {
            let entities = try coreDataStack.viewContext.fetch(fetchRequest)
            
            return entities.compactMap { entity in
                return mapper.mapToDomain(entity: entity)
            }
            
        } catch {
            print("Error al obtener propiedades: \(error)")
            return []
        }
    }
    
    func getRealEstate(byCode code: String) -> RealEstate? {
        
        let fetchRequest: NSFetchRequest<RealEstateEntity> = RealEstateEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "propertyCode == %@", code)
        fetchRequest.fetchLimit = 1
        
        do {
            
            if let entity = try coreDataStack.viewContext.fetch(fetchRequest).first {
                return mapper.mapToDomain(entity: entity)
            }
            
            return nil
            
        } catch {
            print("Error al obtener propiedad por código: \(error)")
            return nil
        }
    }
    
    /*func save(realEstate: RealEstate) {
        
        let fetchRequest: NSFetchRequest<RealEstateEntity> = RealEstateEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "propertyCode == %@", realEstate.propertyCode)
        
        do {
            let results = try coreDataStack.viewContext.fetch(fetchRequest)
            
            let entity: RealEstateEntity
            
            if let existingEntity = results.first {
                entity = existingEntity
                
            } else {
                entity = RealEstateEntity(context: coreDataStack.viewContext)
            }
            
            configureRealEstateEntity(entity, with: realEstate)
            
            try coreDataStack.viewContext.save()
            
        } catch {
            print("Error al guardar propiedad: \(error)")
        }
    }*/
    
    func save(realEstate: RealEstate) {
        
        let _ = mapper.mapToEntity(domain: realEstate, in: coreDataStack.viewContext)
        
        do {
            try coreDataStack.viewContext.save()
            
        } catch {
            print("Error al guardar propiedad: \(error)")
        }
    }
    
    func delete(realEstate: RealEstate) {
        
        let fetchRequest: NSFetchRequest<RealEstateEntity> = RealEstateEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "propertyCode == %@", realEstate.propertyCode)
        
        do {
            let results = try coreDataStack.viewContext.fetch(fetchRequest)
            
            for entity in results {
                coreDataStack.viewContext.delete(entity)
            }
            
            try coreDataStack.viewContext.save()
            
        } catch {
            print("Error al eliminar propiedad: \(error)")
        }
    }
    
    func deleteAll() {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "RealEstateEntity")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeObjectIDs
        
        do {
            let result = try coreDataStack.persistentContainer.persistentStoreCoordinator.execute(batchDeleteRequest, with: coreDataStack.viewContext) as? NSBatchDeleteResult
            
            if let objectIDs = result?.result as? [NSManagedObjectID] {
                let changes = [NSDeletedObjectsKey: objectIDs]
                NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [coreDataStack.viewContext])
            }
            
        } catch {
            print("Error al eliminar todas las propiedades: \(error)")
        }
    }
    
    func toggleFavorite(for realEstate: RealEstate) -> RealEstate {
        
        if isRealEstateFavorite(propertyCode: realEstate.propertyCode) {
            
            // if favorite, remove it
            delete(realEstate: realEstate)
            // return with isFavorite to false
            return RealEstateBuilder.from(realEstate: realEstate)
                .withFavorite(false)
                .build()
            
        } else {
            // if no favorite, add it
            // Create copy with isFavorite to true
            let updatedRealEstate = RealEstateBuilder.from(realEstate: realEstate)
                .withFavorite(true)
                .build()
            
            save(realEstate: updatedRealEstate)
            return updatedRealEstate
        }
    }
        
    func isRealEstateFavorite(propertyCode: String) -> Bool {
        
        let fetchRequest: NSFetchRequest<RealEstateEntity> = RealEstateEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "propertyCode == %@", propertyCode)
        fetchRequest.fetchLimit = 1
        
        do {
            let result = try coreDataStack.viewContext.fetch(fetchRequest)
            return !result.isEmpty
            
        } catch {
            print("Error al verificar si la propiedad es favorita: \(error)")
            return false
        }
        
    }
}
