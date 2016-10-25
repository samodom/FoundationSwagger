//
//  SampleObjectiveCTypes.m
//  FoundationSwagger
//
//  Created by Sam Odom on 10/22/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

#import "SampleObjectiveCTypes.h"

@implementation SampleObjectiveCClass

- (instancetype)init:(NSUInteger)value {
    _value = value;

    return self;
}


- (id)copy {
    SampleObjectiveCClass *copyOfObject = [[SampleObjectiveCClass alloc] init:self.value];
    return copyOfObject;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return [self copy];
}


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


+ (NSUInteger)sampleClassMethod:(NSString *)input {
    return 14;
}

+ (NSUInteger)otherClassMethod:(NSString *)input {
    return 42;
}


- (NSUInteger)sampleInstanceMethod:(NSString *)input {
    return 14;
}

- (NSUInteger)otherInstanceMethod:(NSString *)input {
    return 42;
}

@end


BOOL SampleObjectiveCStructuresEqual(SampleObjectiveCStructure lhs, SampleObjectiveCStructure rhs) {
    return lhs.value == rhs.value;
}
