//
//  DatabaseService.swift
//  GlobalWeather
//
//  Created by Kanat on 17.08.2023
//	
//

import Foundation
import RealmSwift
import Combine

protocol DatabaseServiceProtocol {
    func setup(version: UInt64, key: Data)
    
    func addOrUpdate<T>(object: T,
                        callbackQueue: DispatchQueue,
                        completion: EmptyBlock?) where T: RunTimeModelProtocol
    
    func addOrUpdate<T>(objects: [T],
                        callbackQueue: DispatchQueue,
                        completion: EmptyBlock?) where T: RunTimeModelProtocol
    
    func remove<T>(object: T,
                   callbackQueue: DispatchQueue,
                   completion: EmptyBlock?) where T: RunTimeModelProtocol
    
    func removeAll<T>(of type: T.Type,
                      callbackQueue: DispatchQueue,
                      completion: EmptyBlock?) where T: RunTimeModelProtocol
    
    func getAll<T>(of type: T.Type,
                   callbackQueue: DispatchQueue,
                   completion: BlockObject<[T], Void>) where T: RunTimeModelProtocol
    
    func get<T>(primaryKey: Any,
                callbackQueue: DispatchQueue,
                completion: BlockObject<T?, Void>) where T: RunTimeModelProtocol
    
    func getAll<T: RunTimeModelProtocol>(of type: T.Type, callbackQueue: DispatchQueue) -> Future<[T], Never>
}

extension DatabaseServiceProtocol {
    func addOrUpdate<T>(object: T,
                        completion: EmptyBlock?) where T: RunTimeModelProtocol {
        addOrUpdate(object: object, callbackQueue: .main, completion: completion)
    }
    
    func addOrUpdate<T>(objects: [T],
                        completion: EmptyBlock?) where T: RunTimeModelProtocol {
        addOrUpdate(objects: objects, callbackQueue: .main, completion: completion)
    }
    
    func remove<T>(object: T,
                   completion: EmptyBlock?) where T: RunTimeModelProtocol {
        remove(object: object, callbackQueue: .main, completion: completion)
    }
    
    func removeAll<T>(of type: T.Type,
                      completion: EmptyBlock?) where T: RunTimeModelProtocol {
        removeAll(of: type, callbackQueue: .main, completion: completion)
    }
    
    func getAll<T>(of type: T.Type,
                   completion: BlockObject<[T], Void>) where T: RunTimeModelProtocol {
        getAll(of: type, callbackQueue: .main, completion: completion)
    }
    
    func getAll<T>(of type: T.Type) -> Future<[T], Never> where T: RunTimeModelProtocol {
        getAll(of: type, callbackQueue: .main)
    }

    func get<T>(primaryKey: Any,
                completion: BlockObject<T?, Void>) where T: RunTimeModelProtocol {
        get(primaryKey: primaryKey, callbackQueue: .main, completion: completion)
    }
}

final class DatabaseService: DatabaseServiceProtocol {
    static let shared = DatabaseService()
    
    private let queue = DispatchQueue(label: "com.smartbank.DatabaseService.queue")
    private var realm: Realm?
    
    private init() { }
    
    func inLibraryFolder(filename: String) -> URL {
        return URL(fileURLWithPath:
                    NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0],
                   isDirectory: true).appendingPathComponent(filename)
    }
    
    func setup(version: UInt64, key: Data) {
        queue.sync {
            var configuration = Realm.Configuration(fileURL: inLibraryFolder(filename: "encrypted.realm"), encryptionKey: key)
            configuration.schemaVersion = version
             realm = try? Realm(configuration: configuration, queue: queue)
        }
    }
    
    public func addOrUpdate<T>(object: T,
                               callbackQueue: DispatchQueue = .main,
                               completion: EmptyBlock? = nil) where T: RunTimeModelProtocol {
        queue.sync { [weak self] in
            guard let realm = self?.realm else {
                return
            }
            
            do {
                try realm.write {
                    autoreleasepool {
                        realm.add(object.convertToStorable(), update: .modified)
                        
                        callbackQueue.async {
                            completion?.execute(())
                        }
                    }
                }
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    public func addOrUpdate<T>(objects: [T],
                               callbackQueue: DispatchQueue = .main,
                               completion: EmptyBlock? = nil) where T: RunTimeModelProtocol {
        queue.sync { [weak self] in
            guard let realm = self?.realm else {
                return
            }
            
            do {
                try realm.write {
                    autoreleasepool {
                        let objectsToStore = objects.map { $0.convertToStorable() }
                        realm.add(objectsToStore, update: .modified)
                        
                        callbackQueue.async {
                            completion?.execute(())
                        }
                    }
                }
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    public func remove<T>(object: T,
                          callbackQueue: DispatchQueue = .main,
                          completion: EmptyBlock? = nil) where T: RunTimeModelProtocol {
        queue.sync { [weak self] in
            guard let realm = self?.realm else {
                return
            }
            
            do {
                try realm.write {
                    autoreleasepool {
                        realm.delete(object.convertToStorable())
                        
                        callbackQueue.async {
                            completion?.execute(())
                        }
                    }
                }
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    public func removeAll<T>(of type: T.Type,
                             callbackQueue: DispatchQueue = .main,
                             completion: EmptyBlock? = nil) where T: RunTimeModelProtocol {
        queue.sync { [weak self] in
            guard let realm = self?.realm else {
                return
            }
            
            autoreleasepool {
                do {
                    let objects = realm.objects(type.storableType())
                    
                    try realm.write {
                        
                        realm.delete(objects)
                        
                        callbackQueue.async {
                            completion?.execute(())
                        }
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
        }
    }
    
    public func getAll<T>(of type: T.Type,
                          callbackQueue: DispatchQueue = .main,
                          completion: BlockObject<[T], Void>) where T: RunTimeModelProtocol {
        queue.sync { [weak self] in
            guard let realm = self?.realm else {
                return
            }
            
            autoreleasepool {
                let results = realm.objects(type.storableType()).compactMap { ($0 as? StorableProtocol)?.createRuntimeModel() }
                let array = Array(results) as? [T] ?? []
                callbackQueue.async {
                    completion.execute(array)
                }
            }
        }
    }
    
    public func getAll<T: RunTimeModelProtocol>(of type: T.Type, callbackQueue: DispatchQueue = .main) -> Future<[T], Never> {
        return Future<[T], Never> { promise in
            self.queue.async { [weak self] in
                guard let realm = self?.realm else {
                    callbackQueue.async {
                        promise(.success([]))
                    }
                    return
                }
                
                autoreleasepool {
                    let results = realm.objects(type.storableType()).compactMap { ($0 as? StorableProtocol)?.createRuntimeModel() }
                    let array = Array(results) as? [T] ?? []
                    callbackQueue.async {
                        promise(.success(array))
                    }
                }
            }
        }
    }

    
    public func get<T>(primaryKey : Any,
                       callbackQueue: DispatchQueue = .main,
                       completion: BlockObject<T?, Void>) where T: RunTimeModelProtocol{
        queue.sync { [weak self] in
            guard let realm = self?.realm else {
                return
            }
            
            autoreleasepool {
                let result = realm.object(ofType: T.storableType(), forPrimaryKey: primaryKey) as? StorableProtocol
                let runtimeModel = result?.createRuntimeModel() as? T
                
                callbackQueue.async {
                    completion.execute(runtimeModel)
                }
            }
        }
    }
}
