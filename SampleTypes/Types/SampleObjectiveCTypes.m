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


//  MARK: - Sample Objective-C structure equatability

BOOL SampleObjectiveCStructuresEqual(SampleObjectiveCStructure lhs, SampleObjectiveCStructure rhs) {
    return lhs.value == rhs.value;
}


@implementation SampleObjectiveCClass


+ (NSString *)className {
    return NSStringFromClass(self);
}

//  MARK: - Lifecycle

- (instancetype)init:(NSInteger)value {
    if (self = [self init]) {
        _value = value;
    }

    return self;
}


- (id)copy {
    SampleObjectiveCClass *copyOfObject = [[SampleObjectiveCClass alloc] init:self.value];
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
    return self.value == other.value;
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
