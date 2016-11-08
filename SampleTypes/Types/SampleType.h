//
//  SampleType.h
//  FoundationSwagger
//
//  Created by Sam Odom on 10/29/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSInteger(^NullaryIntegerClosure)(void);
typedef NullaryIntegerClosure SampleMethod;


@protocol SampleType

@required

+ (nonnull NSString *)className;

+ (NSInteger)sampleClassMethod;
+ (NSInteger)otherClassMethod;

- (NSInteger)sampleInstanceMethod;
- (NSInteger)otherInstanceMethod;

@end
