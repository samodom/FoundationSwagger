//
//  TypedAssociationAccessors.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 11/21/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//


public extension ObjectAssociating {

    //  MARK: - Booleans

    /// Typed method for associated boolean values.
    /// - parameter for: The key for the association to retrieve.
    /// - returns: The associated boolean value or `nil` if no such boolean association exists.
    public func booleanAssociation(for key: ObjectAssociationKey) -> Bool? {
        return association(for: key) as? Bool
    }

    /// Typed method for associated boolean values with a default value to use.
    /// - parameter for: The key for the association to retrieve.
    /// - parameter defaultValue: Boolean value to use when the boolean association does not exist.
    /// - returns: The associated boolean value or `defaultValue` if no such boolean association exists.
    public func booleanAssociation(for key: ObjectAssociationKey, defaultValue: Bool) -> Bool {
        return booleanAssociation(for: key) ?? defaultValue
    }


    //  MARK: - Signed integers

    /// Typed method for associated signed integer values.
    /// - parameter for: The key for the association to retrieve.
    /// - returns: The associated signed integer value or `nil` if no such signed integer association exists.
    public func integerAssociation(for key: ObjectAssociationKey) -> Int? {
        return association(for: key) as? Int
    }

    /// Typed method for associated signed integer values with a default value to use.
    /// - parameter for: The key for the association to retrieve.
    /// - parameter defaultValue: Signed integer value to use when the signed integer association does not exist.
    /// - returns: The associated signed integer value or `defaultValue` if no such signed integer association exists.
    public func integerAssociation(for key: ObjectAssociationKey, defaultValue: Int) -> Int {
        return integerAssociation(for: key) ?? defaultValue
    }
    

    //  MARK: - Unsigned integers

    /// Typed method for associated unsigned integer values.
    /// - parameter for: The key for the association to retrieve.
    /// - returns: The associated unsigned integer value or `nil` if no such unsigned integer association exists.
    public func unsignedIntegerAssociation(for key: ObjectAssociationKey) -> UInt? {
        return association(for: key) as? UInt
    }

    /// Typed method for associated unsigned integer values with a default value to use.
    /// - parameter for: The key for the association to retrieve.
    /// - parameter defaultValue: Unsigned integer value to use when the unsigned integer association does not exist.
    /// - returns: The associated unsigned integer value or `defaultValue` if no such unsigned integer association exists.
    public func unsignedIntegerAssociation(for key: ObjectAssociationKey, defaultValue: UInt) -> UInt {
        return unsignedIntegerAssociation(for: key) ?? defaultValue
    }
    

    //  MARK: - Floats

    /// Typed method for associated float values.
    /// - parameter for: The key for the association to retrieve.
    /// - returns: The associated float value or `nil` if no such float association exists.
    public func floatAssociation(for key: ObjectAssociationKey) -> Float? {
        return association(for: key) as? Float
    }

    /// Typed method for associated float values with a default value to use.
    /// - parameter for: The key for the association to retrieve.
    /// - parameter defaultValue: Float value to use when the float association does not exist.
    /// - returns: The associated float value or `defaultValue` if no such float association exists.
    public func floatAssociation(for key: ObjectAssociationKey, defaultValue: Float) -> Float {
        return floatAssociation(for: key) ?? defaultValue
    }


    //  MARK: - Doubles

    /// Typed method for associated double values.
    /// - parameter for: The key for the association to retrieve.
    /// - returns: The associated double value or `nil` if no such double association exists.
    public func doubleAssociation(for key: ObjectAssociationKey) -> Double? {
        return association(for: key) as? Double
    }

    /// Typed method for associated double values with a default value to use.
    /// - parameter for: The key for the association to retrieve.
    /// - parameter defaultValue: Double value to use when the double association does not exist.
    /// - returns: The associated double value or `defaultValue` if no such double association exists.
    public func doubleAssociation(for key: ObjectAssociationKey, defaultValue: Double) -> Double {
        return doubleAssociation(for: key) ?? defaultValue
    }
    

    //  MARK: - Strings

    /// Typed method for associated string values.
    /// - parameter for: The key for the association to retrieve.
    /// - returns: The associated string value or `nil` if no such string association exists.
    public func stringAssociation(for key: ObjectAssociationKey) -> String? {
        return association(for: key) as? String
    }

    /// Typed method for associated string values with a default value to use.
    /// - parameter for: The key for the association to retrieve.
    /// - parameter defaultValue: String value to use when the string association does not exist.
    /// - returns: The associated string value or `defaultValue` if no such string association exists.
    public func stringAssociation(for key: ObjectAssociationKey, defaultValue: String) -> String {
        return stringAssociation(for: key) ?? defaultValue
    }
    

    //  MARK: - URLs

    /// Typed method for associated URL values.
    /// - parameter for: The key for the association to retrieve.
    /// - returns: The associated URL value or `nil` if no such URL association exists.
    public func urlAssociation(for key: ObjectAssociationKey) -> URL? {
        return association(for: key) as? URL
    }

    /// Typed method for associated URL values with a default value to use.
    /// - parameter for: The key for the association to retrieve.
    /// - parameter defaultValue: URL value to use when the URL association does not exist.
    /// - returns: The associated URL value or `defaultValue` if no such URL association exists.
    public func urlAssociation(for key: ObjectAssociationKey, defaultValue: URL) -> URL {
        return urlAssociation(for: key) ?? defaultValue
    }
    
}
