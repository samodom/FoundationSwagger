//
//  NSUserDefaultsSubscripting.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 12/7/14.
//  Copyright (c) 2014 Swagger Soft. All rights reserved.
//

import Foundation

public protocol NSUserDefaultsStorable { }

extension Bool: NSUserDefaultsStorable { }

extension Int: NSUserDefaultsStorable { }
extension Int8: NSUserDefaultsStorable { }
extension Int16: NSUserDefaultsStorable { }
extension Int32: NSUserDefaultsStorable { }
extension Int64: NSUserDefaultsStorable { }

extension Float: NSUserDefaultsStorable { }
extension Double: NSUserDefaultsStorable { }

extension String: NSUserDefaultsStorable { }
extension NSURL: NSUserDefaultsStorable { }

extension NSArray: NSUserDefaultsStorable { }
extension Array: NSUserDefaultsStorable { }

public extension NSUserDefaults {

    public subscript(key: String) -> NSUserDefaultsStorable? {
        get {
            let defaultsDictionary = dictionaryRepresentation()
            var storedDefault: AnyObject? = defaultsDictionary[key]
            if storedDefault == nil {
                return nil
            }

            if storedDefault! is NSNumber {
                return getNumberValue(fromNumber: storedDefault! as NSNumber)
            }

            if storedDefault! is String {
                return storedDefault as String
            }

            if storedDefault! is NSData {
                return URLForKey(key)
            }

            return nil
        }

        set {
            switch newValue {
            case is Bool:
                setBool(newValue as Bool, forKey: key)

            case is Int8:
                setIntegerTypeValue(newValue!, forKey: key)

            case is Int16:
                setIntegerTypeValue(newValue!, forKey: key)

            case is Int32:
                setIntegerTypeValue(newValue!, forKey: key)

            case is Int64:
                setIntegerTypeValue(newValue!, forKey: key)

            case is Int:
                setIntegerTypeValue(newValue!, forKey: key)

            case is Float:
                setFloat(newValue as Float, forKey: key)

            case is Double:
                setDouble(newValue as Double, forKey: key)

            case is String:
                setObject(newValue as String, forKey: key)

            case is NSURL:
                setURL(newValue as NSURL, forKey: key)

            case is NSArray:
                setObject(newValue as NSArray, forKey: key)

            default:
                break
            }
        }
    }

    private func getNumberValue(fromNumber number: NSNumber) -> NSUserDefaultsStorable {
        let typeCharacter = String.fromCString(number.objCType)!
        switch typeCharacter {
        case "c":
            return number.boolValue

        case "q":
            return number.integerValue

        case "f", "d":
            return getFloatingPointValueFromNumber(number)

        default:
            return Double.NaN
        }
    }

    private func getFloatingPointValueFromNumber(number: NSNumber) -> NSUserDefaultsStorable {
        let typeCharacter = String.fromCString(number.objCType)!
        if typeCharacter == "f" {
            return number.floatValue
        }
        else if typeCharacter == "d" {
            return number.doubleValue
        }

        return Double.NaN
    }


    private func setIntegerTypeValue(value: NSUserDefaultsStorable, forKey key: String) {
        switch value {
        case is Int8:
            setInteger(Int(value as Int8), forKey: key)

        case is Int16:
            setInteger(Int(value as Int16), forKey: key)

        case is Int32:
            setInteger(Int(value as Int32), forKey: key)

        case is Int64:
            setInteger(Int(value as Int64), forKey: key)

        case is Int:
            setInteger(value as Int, forKey: key)

        default:
            break
        }
    }

}
