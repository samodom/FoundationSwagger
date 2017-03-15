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


@end
