//
//  SampleObjectiveCTypes.h
//  FoundationSwagger
//
//  Created by Sam Odom on 10/22/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

#import <Foundation/Foundation.h>


//  MARK: - C Structure

typedef struct SampleObjectiveCStructure {
    NSUInteger value;
} SampleObjectiveCStructure;

extern BOOL SampleObjectiveCStructuresEqual(SampleObjectiveCStructure, SampleObjectiveCStructure);


//  MARK: - C Enumeration

typedef enum SampleObjectiveCEnumeration: NSUInteger {
    SampleObjectiveCEnumerationAlpha = 14,
    SampleObjectiveCEnumerationBeta = 42
} SampleObjectiveCEnumeration;

//BOOL SampleObjectiveCEnumerationsEqual(SampleObjectiveCEnumeration, SampleObjectiveCEnumeration);


//  MARK: - Objective-C Class

@interface SampleObjectiveCClass : NSObject

@property NSUInteger value;

- (_Nonnull instancetype)init NS_UNAVAILABLE;
- (_Nonnull instancetype)init:(NSUInteger)value;

+ (NSUInteger)sampleClassMethod:(nullable NSString *)input;
- (NSUInteger)sampleInstanceMethod:(nullable NSString *)input;

@end
