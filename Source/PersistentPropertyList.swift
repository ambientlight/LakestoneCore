﻿//
//  PersistentPropertyList.swift
//  LakestoneCore
//
//  Created by Taras Vozniuk on 6/13/16.
//  Copyright © 2016 GeoThings. All rights reserved.
//
// --------------------------------------------------------
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#if COOPER
	import android.content
	import android.preference
#else
	import Foundation
#endif

public class PersistentPropertyList {
	
	#if COOPER
	
	fileprivate let sharedPreference: SharedPreferences
	fileprivate let sharedPreferenceEditor: SharedPreferences.Editor
	public init(applicationContext: Context, preferenceFileKey: String? = nil){
		
		if let passedPreferenceKey = preferenceFileKey {
			self.sharedPreference = applicationContext.getSharedPreferences(preferenceFileKey, Context.MODE_PRIVATE)
		} else {
			self.sharedPreference = PreferenceManager.getDefaultSharedPreferences(applicationContext)
		}
		
		self.sharedPreferenceEditor = self.sharedPreference.edit()
	}
	
	public convenience init(applicationContext: Context){
		self.init(applicationContext: applicationContext, preferenceFileKey: nil)
	}
	
	#else
	
	fileprivate let userDefaults: UserDefaults
	public init(){
		self.userDefaults = UserDefaults.standard
	}
	
	#endif
	
	public func setBool(_ value: Bool, forKey key: String){
		#if COOPER
			self.sharedPreferenceEditor.putBoolean(key, value)
		#else
			self.userDefaults.set(value, forKey: key)
		#endif
	}
	
	public func setInt(_ value: Int, forKey key: String){
		#if COOPER
			self.sharedPreferenceEditor.putLong(key, value)
		#else
			self.userDefaults.set(value, forKey: key)
		#endif
	}
	
	public func setFloat(_ value: Float, forKey key: String){
		#if COOPER
			self.sharedPreferenceEditor.putFloat(key, value)
		#else
			self.userDefaults.set(value, forKey: key)
		#endif
	}
	
	public func setDouble(_ value: Double, forKey key: String){
		#if COOPER
			//android sharedPreference for some reason doesn't have double support, store as string then instead
			self.sharedPreferenceEditor.putString(key, value.toString())
		#else
			self.userDefaults.set(value, forKey: key)
		#endif
	}
	
	public func setString(_ value: String, forKey key: String){
		#if COOPER
			self.sharedPreferenceEditor.putString(key, value)
		#else
			self.userDefaults.set(value, forKey: key)
		#endif
	}
	
	public func setStringSet(_ value: Set<String>, forKey key: String){
		#if COOPER
			var javaSet = java.util.HashSet<String>(value)
			self.sharedPreferenceEditor.putStringSet(key, javaSet)
		#else
			self.userDefaults.set([String](value), forKey: key)
		#endif
	}
	
	public func bool(forKey key: String) -> Bool? {
		#if COOPER
			return (self.sharedPreference.contains(key)) ? self.sharedPreference.getBoolean(key, false) : nil
		#else
			return (self.userDefaults.object(forKey: key) != nil) ? self.userDefaults.bool(forKey: key) : nil
		#endif
	}
	
	public func integer(forKey key: String) -> Int? {
		#if COOPER
			return (self.sharedPreference.contains(key)) ? self.sharedPreference.getLong(key, 0) : nil
		#else
			return (self.userDefaults.object(forKey: key) != nil) ? self.userDefaults.integer(forKey: key) : nil
		#endif
	}
	
	public func float(forKey key: String) -> Float? {
		#if COOPER
			return (self.sharedPreference.contains(key)) ? self.sharedPreference.getFloat(key, 0.0) : nil
		#else
			return (self.userDefaults.object(forKey: key) != nil) ? self.userDefaults.float(forKey: key) : nil
		#endif
	}
	
	public func double(forKey key: String) -> Double? {
		#if COOPER
		//android sharedPreference for some reason doesn't have double support, it is stored as string instead
			return (self.sharedPreference.contains(key)) ? Double.parseDouble(self.sharedPreference.getString(key, "0.0")) : nil
		#else
			return (self.userDefaults.object(forKey: key) != nil) ? self.userDefaults.double(forKey: key) : nil
		#endif
	}
	
	public func string(forKey key: String) -> String? {
		#if COOPER
			return (self.sharedPreference.contains(key)) ? self.sharedPreference.getString(key, "") : nil
		#else
			return self.userDefaults.string(forKey: key)
		#endif
	}
	
	public func stringSet(forKey key: String) -> Set<String>? {
		#if COOPER
		
			if (self.sharedPreference.contains(key)){
				let javaStringSet = java.util.HashSet<String>(self.sharedPreference.getStringSet(key, java.util.HashSet<String>()))
				
				let returnSet = Set<String>()
				for entity in javaStringSet {
					returnSet.insert(entity)
				}
				return returnSet
				
			} else {
				return nil
			}
			
		#else
		
			guard let stringArray = self.userDefaults.stringArray(forKey: key) else {
				return nil
			}
			return Set<String>(stringArray)
			
		#endif   
	}
	
	public func removeObject(forKey key: String){
		
		#if COOPER
			self.sharedPreferenceEditor.remove(key)
		#else
			self.userDefaults.removeObject(forKey: key)
		#endif
	}
	
	public func synchronize(){
		#if COOPER
			self.sharedPreferenceEditor.apply()
		#else
			//_ = self.userDefaults.synchronize()
		#endif
	}
	
	public func contains(key: String) -> Bool {
		#if COOPER
			return self.sharedPreference.contains(key)
		#else
			return self.userDefaults.object(forKey: key) != nil
		#endif
	}
	
	
	#if COOPER
	
	public var allKeys: Set<String> {
	
		let javaStringSet = self.sharedPreference.getAll().keySet()
		let returnSet = Set<String>()
		for entity in javaStringSet {
					returnSet.insert(entity)
		}
	
		return returnSet
	}
	
	#elseif !os(Linux)
	
	public var allKeys: Set<String> {
		return Set<String>(self.userDefaults.dictionaryRepresentation().keys)
	}
	
	#endif
	
	
}

// Array, Dictionary, Date, String, URL, UUID


extension PersistentPropertyList {
	 
	/// -remark: Overloading with '_ value:' will result in dex failure in Silver
	public func setArray(_ array: [Any], forKey key: String) {
		
		#if COOPER
		
			guard let jsonString = try? JSONSerialization.string(withJSONObject: array) else {
				return
			}
			
			self.setString(jsonString, forKey: key)
			
		#else
		
			self.userDefaults.set(array, forKey: key)
			
		#endif
	}
	
	public func setSet(_ `set`: Set<AnyHashable>, forKey key: String){
		self.setArray([AnyHashable](`set`), forKey: key)
	}
	
	public func setDictionary(_ value: [String: Any], forKey key: String) {
		
		#if COOPER
		
			guard let jsonString = try? JSONSerialization.string(withJSONObject: value) else {
				return
			}
			
			self.setString(jsonString, forKey: key)
			
		#else
			
			self.userDefaults.set(value, forKey: key)
		
		#endif
	}
	
	
	public func setDate(_ value: Date, forKey key: String) {
		
		#if COOPER
		
			let timeInterval = value.timeIntervalSince1970
			self.setDouble(timeInterval, forKey: key)
			
		#else
		
			self.userDefaults.set(value, forKey: key)
			
		#endif
	}
	
	public func setURL(_ value: URL, forKey key: String) {
		
		#if COOPER
		
			let absoluteString = value.absoluteString
			self.setString(absoluteString, forKey: key)
			
		#else
		
			self.userDefaults.set(value, forKey: key)
		
		#endif
	}
	
	public func setUUID(_ uuid: UUID, forKey key: String){
		
		self.setString(uuid.uuidString, forKey: key)
	}
	
	public func array(forKey key: String) -> [Any]? {
		
		#if COOPER
		
			guard let jsonString = self.string(forKey: key),
				  let jsonData = Data.with(utf8EncodedString: jsonString)
			else {
				return nil
			}
				  
			guard let jsonObject = try? JSONSerialization.jsonObject(with: jsonData)
			else {
				return nil
			}
			
			return jsonObject as? [Any]
			
		#else
		
			return self.userDefaults.array(forKey: key)
			
		#endif
	}
	
	public func set(forKey key: String) -> Set<AnyHashable>? {
		
		guard let array = self.array(forKey: key) as? [AnyHashable] else {
			return nil
		}
		
		return Set<AnyHashable>(array)
	}
	
	public func dictionary(forKey key: String) -> [String: Any]? {
		
		#if COOPER
			
			guard let jsonString = self.string(forKey: key),
				  let jsonData = Data.with(utf8EncodedString: jsonString)
			else {
				return nil
			}
				
			guard let jsonObject = try? JSONSerialization.jsonObject(with: jsonData)
			else {
				 return nil
			}
			
			return jsonObject as? [String: Any]
			
		#else
			
			return self.userDefaults.dictionary(forKey: key)
			
		#endif
	}
	
	
	
	public func date(forKey key: String) -> Date? {
		
		#if COOPER
		
			guard let timeInterval = self.double(forKey: key) else {
				return nil
			}
			
			return Date(timeIntervalSince1970: timeInterval)
			
		#else
		
			return self.userDefaults.object(forKey: key) as? Date
			
		#endif
	}
	
	public func url(forKey key: String) -> URL? {
	
		#if COOPER
		
			guard let absoluteString = self.string(forKey: key) else {
				return nil
			}
			
			return URL(string: absoluteString)
			
		#else
			
			return self.userDefaults.url(forKey: key)
		
		#endif
	}
	
	public func uuid(forKey key: String) -> UUID? {
		
		guard let uuidString = self.string(forKey: key) else {
			return nil
		}
		
		return UUID(uuidString: uuidString)
	}
	
	
}

// CustomSerializable support
extension PersistentPropertyList {
	
	public func setCustomSerializable(_ customSerializable: CustomSerializable, forKey key: String) throws {
		
		let serializedDict = try CustomSerialization.dictionary(from: customSerializable)
		
		#if COOPER
			
			let jsonString = try JSONSerialization.string(withJSONObject: serializedDict)
			self.setString(jsonString, forKey: key)
			
		#else
			
			self.userDefaults.set(serializedDict, forKey: key)
			
		#endif
	}
	
	public func setCustomSerializableArray(_ customSerializableArray: [CustomSerializable], forKey key: String) throws {
		
		let serializedArray = try CustomSerialization.array(from: customSerializableArray)
		
		#if COOPER
			
			let jsonString = try JSONSerialization.string(withJSONObject: serializedArray)
			self.setString(jsonString, forKey: key)
			
		#else
			
			self.userDefaults.set(serializedArray, forKey: key)
			
		#endif
	}
	
	#if COOPER
	
	// if using generics with Class<T> in Silver, the return type of T? will be interpretted as? '? extends CustomSerializable'
	// while in Swift you can have strong typing with 
	// public func customSerializable<T: CustomSerializable>(forKey key: String, ofDesiredType: T.Type, withTotalCustomTypes: [CustomSerializableType]) -> T?
	// using the CustomSerializable return type for the sake of matching declarations for now
	
	private func _performCustomSerializationToUnderlyingParsedJSONEntity(forKey key: String, withCustomTypes: [CustomSerializableType]) -> Any? {
		
		guard let jsonString = self.string(forKey: key),
			  let jsonData = Data.with(utf8EncodedString: jsonString),
			  let jsonObject = try? JSONSerialization.jsonObject(with: jsonData),
			  let targetEntity = try? CustomSerialization.applyCustomSerialization(ofCustomTypes: withCustomTypes, to: jsonObject)
		else {
			return nil
		}
		
		return targetEntity
	}
	
	public func customSerializable(forKey key: String, withCustomTypes: [CustomSerializableType]) -> CustomSerializable? {
		return _performCustomSerializationToUnderlyingParsedJSONEntity(forKey: key, withCustomTypes: withCustomTypes) as? CustomSerializable
	}
	
	public func customSerializableArray(forKey key: String, withCustomTypes: [CustomSerializableType]) -> [CustomSerializable]? {
		return _performCustomSerializationToUnderlyingParsedJSONEntity(forKey: key, withCustomTypes: withCustomTypes) as? [CustomSerializable]
	}
	
	#else
	
	public func customSerializable(forKey key: String, withCustomTypes: [CustomSerializableType]) -> CustomSerializable? {
		
		guard let storedDictionary = self.userDefaults.dictionary(forKey: key),
			  let customSerializable = try? CustomSerialization.applyCustomSerialization(ofCustomTypes: withCustomTypes, to: storedDictionary)
		else {
			return nil
		}
		
		return customSerializable as? CustomSerializable
	}
	
	public func customSerializableArray(forKey key: String, withCustomTypes: [CustomSerializableType]) -> [CustomSerializable]? {
		
		guard let storedDictionary = self.userDefaults.array(forKey: key),
			  let customSerializableArray = try? CustomSerialization.applyCustomSerialization(ofCustomTypes: withCustomTypes, to: storedDictionary)
		else {
			return nil
		}
		
		return customSerializableArray as? [CustomSerializable]
	}
	
	#endif
}

#if COOPER
extension PersistentPropertyList {
	
	public func setBool(_ value: Bool, _ key: String){
		self.setBool(value, forKey: key)
	}
	
	public func setInt(_ value: Int, _ key: String){
		self.setInt(value, forKey: key)
	}
	
	public func setDouble(_ value: Double, _ key: String){
		self.setDouble(value, forKey: key)
	}
	
	public func setString(_ value: String, _ key: String){
		self.setString(value, forKey: key)
	}
	
	public func setStringSet(_ value: Set<String>, _ key: String){
		self.setStringSet(value, forKey: key)
	}
	
	public func boolForKey(_ key: String) -> Bool? {
		return self.bool(forKey: key)
	}
	
	public func integerForKey(_ key: String) -> Int? {
		return self.integer(forKey: key)
	}
	
	public func floatForKey(_ key: String) -> Float? {
		return self.float(forKey: key)
	}
	
	public func doubleForKey(_ key: String) -> Double? {
		return self.double(forKey: key)
	}
	
	public func stringForKey(_ key: String) -> String? {
		return self.string(forKey: key)
	}
	
	public func stringSetForKey(_ key: String) -> Set<String>? {
		return self.stringSet(forKey: key)
	}
	
	public func removeObjectForKey(_ key: String){
		self.removeObject(forKey: key)
	}
	
	public func containsObjectWithKey(_ key: String) -> Bool {
		return self.contains(key: key)
	}
	
	public func setArray(_ array: [Any], _ key: String){
		self.setArray(array, forKey: key)
	}
	
	public func setSet(_ `set`: Set<AnyHashable>, _ key: String){
		self.setSet(`set`, forKey: key)
	}
	
	public func setDictionary(_ value: [String: Any], _ key: String) {
		self.setDictionary(value, forKey: key)
	}
	
	public func setDate(_ value: Date, _ key: String) {
		self.setDate(value, forKey: key)
	}
	
	public func setURL(_ value: URL, _ key: String) {
		self.setURL(value, forKey: key)
	}
	
	public func setUUID(_ uuid: UUID, _ key: String){
		self.setUUID(uuid, forKey: key)
	}
	
	public func array(_ key: String) -> [Any]? {
		return self.array(forKey: key)
	}
	
	public func set(_ key: String) -> Set<AnyHashable>? {
		return self.`set`(forKey: key)
	}
	
	public func dictionary(_ key: String) -> [String: Any]? {
		return self.dictionary(forKey: key)
	}
	
	public func date(_ key: String) -> Date? {
		return self.date(forKey: key)
	}
	
	public func url(_ key: String) -> URL? {
		return self.url(forKey: key)
	}
	
	public func uuid(_ key: String) -> UUID? {
		return self.uuid(forKey: key)
	}
	
	public func setCustomSerializable(_ customSerializable: CustomSerializable, _ key: String) throws {
		try self.setCustomSerializable(customSerializable, forKey: key)
	}
	
	public func setCustomSerializableArray(_ customSerializableArray: [CustomSerializable], _ key: String) throws {
		try self.setCustomSerializableArray(customSerializableArray, key)
	}
	
	public func customSerializable(_ key: String, _ customTypes: [CustomSerializableType]) -> CustomSerializable? {
		return self.customSerializable(forKey: key, withCustomTypes: customTypes)
	}
	
	public func customSerializableArray(_ key: String, _ customTypes: [CustomSerializableType]) -> [CustomSerializable]? {
		return self.customSerializableArray(forKey: key, withCustomTypes: customTypes)
	}
}
#endif
