//
//  SampleObjectiveCTypes.m
//  FoundationSwagger
//
//  Created by Sam Odom on 10/22/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

#import "SampleObjectiveCTypes.h"


NSInteger const OriginalMethodReturnValue = 14;
NSInteger const AlternateMethodReturnValue = 42;

NSString * const OriginalPropertyValue = @"Tony Stewart";
NSString * const AlternatePropertyValue = @"Kyle Larson";


//  MARK: - Sample Objective-C structure equatability

BOOL SampleObjectiveCStructuresEqual(SampleObjectiveCStructure lhs, SampleObjectiveCStructure rhs) {
    return lhs.value == rhs.value;
}


@implementation SampleObjectiveCClass

+ (NSString *)className {
    return NSStringFromClass(self);
}


static NSString * _Nonnull _classProperty;

+ (NSString * _Nonnull)classProperty {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_classProperty) {
            _classProperty = OriginalPropertyValue;
        }
    });

    return _classProperty;
}

+ (void)setClassProperty:(NSString * _Nonnull)newValue {
    _classProperty = newValue;
}


//  MARK: - Lifecycle

- (instancetype)init {
    if (self = [super init]) {
        _instanceProperty = OriginalPropertyValue;
    }

    return self;
}


- (id)copy {
    SampleObjectiveCClass *copyOfObject = [[SampleObjectiveCClass alloc] init];
    copyOfObject->_instanceProperty = self.instanceProperty;
    return copyOfObject;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return [self copy];
}


//  MARK: - Equatability

- (BOOL)isEqual:(id)object {
    return [self isEqualToSampleClass:object];
}

- (BOOL)isEqualToSampleClass:(id)object {
    if (self == object) {
        return YES;
    }

    if (![object isKindOfClass:[self class]]) {
        return NO;
    }

    SampleObjectiveCClass *other = object;
    return self.instanceProperty == other.instanceProperty;
}


//  MARK: - Sample methods

+ (NSInteger)sampleClassMethod {
    return OriginalMethodReturnValue;
}

+ (NSInteger)otherClassMethod {
    return AlternateMethodReturnValue;
}


- (NSInteger)sampleInstanceMethod {
    return OriginalMethodReturnValue;
}

- (NSInteger)otherInstanceMethod {
    return AlternateMethodReturnValue;
}


//  MARK: - Property alternates

+ (NSString * _Nonnull)otherClassPropertyGetter {
    return AlternatePropertyValue;
}

+ (void)otherClassPropertySetter:(NSString * _Nonnull)newValue {
    _classProperty = [newValue stringByAppendingString:newValue];
}


- (NSString * _Nonnull)otherInstancePropertyGetter {
    return AlternatePropertyValue;
}

- (void)otherInstancePropertySetter:(NSString * _Nonnull)newValue {
    _instanceProperty = [newValue stringByAppendingString:newValue];
}


@end
