//
//  SampleObjectiveCTypes.h
//  FoundationSwagger
//
//  Created by Sam Odom on 10/22/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SampleType.h"


//  MARK: - Well-known return values

FOUNDATION_EXPORT NSInteger const OriginalMethodReturnValue;
FOUNDATION_EXPORT NSInteger const AlternateMethodReturnValue;


//  MARK: - C Structure

typedef struct SampleObjectiveCStructure {
    NSUInteger value;
} SampleObjectiveCStructure;

BOOL SampleObjectiveCStructuresEqual(SampleObjectiveCStructure, SampleObjectiveCStructure);


//  MARK: - C Enumeration

typedef enum SampleObjectiveCEnumeration: NSUInteger {
    SampleObjectiveCEnumerationAlpha = 14,
    SampleObjectiveCEnumerationBeta = 42
} SampleObjectiveCEnumeration;


//  MARK: - Objective-C Class

@interface SampleObjectiveCClass: NSObject<SampleType>

@property (readonly) NSInteger value;

- (nonnull instancetype)init:(NSInteger)value;

@end
