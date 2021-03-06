﻿//
//  BoxedNumber.swift
//  LakestoneCore
//
//  Created by Volodymyr Andriychenko on 10/14/16.
//  Copyright © 2016 GeoThings. All rights reserved.
//
//  workaround for Silver not supporting numeric types correspondence to protocols
//  Proxy types will be user for variables which are used for structures or classes 

#if !COOPER
import Foundation

public typealias DoubleProxy = Double
public typealias IntProxy = Int

#else
public typealias DoubleProxy = BoxedDouble
public typealias IntProxy = BoxedInt
public typealias IntegerArithmetic = IntegerArithmeticType
#endif

public class BoxedInt {
    
    fileprivate let _underlyingEntity: Any
    public init(_ intValue: Int){
        _underlyingEntity = intValue
    }

}

extension BoxedInt: Equatable {

    #if COOPER
    
    public override func equals(_ o: Object!) -> Bool {
        
        guard let other = o as? Self else {
            return false
        }
        
        return (self == other)
    }
    
    #endif
}

extension BoxedInt: Comparable {}

public func <(lhs: BoxedInt, rhs: BoxedInt) -> Bool {
    
    if let lhsIntEntity = lhs._underlyingEntity as? Int,
        let rhsIntEntity = rhs._underlyingEntity as? Int {
           
            return lhsIntEntity < rhsIntEntity
        } else {
            return false
    }
}

public func <=(lhs: BoxedInt, rhs: BoxedInt) -> Bool {
 
    if let lhsIntEntity = lhs._underlyingEntity as? Int,
    let rhsIntEntity = rhs._underlyingEntity as? Int {
           
        return lhsIntEntity <= rhsIntEntity
    } else {
        return false
    }
}
public func >=(lhs: BoxedInt, rhs: BoxedInt) -> Bool {
    
    if let lhsIntEntity = lhs._underlyingEntity as? Int,
    let rhsIntEntity = rhs._underlyingEntity as? Int {
           
        return lhsIntEntity >= rhsIntEntity
    } else {
        return false
    }
    
}
public func >(lhs: BoxedInt, rhs: BoxedInt) -> Bool {
    if let lhsIntEntity = lhs._underlyingEntity as? Int,
    let rhsIntEntity = rhs._underlyingEntity as? Int {
           
        return lhsIntEntity > rhsIntEntity
    } else {
        return false
    }
}

public func ==(lhs: BoxedInt, rhs: BoxedInt) -> Bool {
    
    if let lhsIntEntity = lhs._underlyingEntity as? Int,
       let rhsIntEntity = rhs._underlyingEntity as? Int {
           
        return lhsIntEntity == rhsIntEntity
    } else {
        return false
    }
}
    
public class BoxedDouble {
    
    fileprivate let _underlyingEntity: Any
    public init(_ doubleValue: Double){
        _underlyingEntity = doubleValue
    }

}

extension BoxedDouble: Equatable {

    #if COOPER
    
    public override func equals(_ o: Object!) -> Bool {
        
        guard let other = o as? Self else {
            return false
        }
        
        return (self == other)
    }
    
    #endif
}

extension BoxedDouble: Comparable {}

public func <(lhs: BoxedDouble, rhs: BoxedDouble) -> Bool {
    
    if let lhsIntEntity = lhs._underlyingEntity as? Double,
        let rhsIntEntity = rhs._underlyingEntity as? Double {
           
            return lhsIntEntity < rhsIntEntity
        } else {
            return false
    }
}

public func <=(lhs: BoxedDouble, rhs: BoxedDouble) -> Bool {
 
    if let lhsIntEntity = lhs._underlyingEntity as? Double,
        let rhsIntEntity = rhs._underlyingEntity as? Double {
           
            return lhsIntEntity <= rhsIntEntity
        } else {
            return false
    }
}
public func >=(lhs: BoxedDouble, rhs: BoxedDouble) -> Bool {
    
    if let lhsIntEntity = lhs._underlyingEntity as? Double,
        let rhsIntEntity = rhs._underlyingEntity as? Double {
           
            return lhsIntEntity >= rhsIntEntity
        } else {
            return false
    }
    
}
public func >(lhs: BoxedDouble, rhs: BoxedDouble) -> Bool {
    if let lhsIntEntity = lhs._underlyingEntity as? Double,
        let rhsIntEntity = rhs._underlyingEntity as? Double {
           
            return lhsIntEntity > rhsIntEntity
        } else {
            return false
    }
}

public func ==(lhs: BoxedDouble, rhs: BoxedDouble) -> Bool {
    
    if let lhsIntEntity = lhs._underlyingEntity as? Double,
        let rhsIntEntity = rhs._underlyingEntity as? Double {
           
            return lhsIntEntity == rhsIntEntity
        } else {
            return false
    }
}
    
