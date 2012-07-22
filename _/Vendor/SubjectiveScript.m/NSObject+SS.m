//
//  NSObject+SS.m
//  SubjectiveScript.m
//
//  Created by Kevin Malakoff on 7/17/12.
//  Copyright (c) 2012 Kevin Malakoff. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "NSObject+SS.h"
#import "SS+Types.h"
#import "SS+Number.h"
#import "SS+Arguments.h"
#import "NSString+SS.h"
#import "NSArray+SS.h"
#import "NSNumber+SS.h"

typedef id(^SSBlock0)();
typedef id(^SSBlock1)(id arg1);
typedef id(^SSBlock2)(id arg1, id arg2);
typedef id(^SSBlock3)(id arg1, id arg2, id arg3);
typedef id(^SSBlock4)(id arg1, id arg2, id arg3, id arg4);
typedef id(^SSBlock5)(id arg1, id arg2, id arg3, id arg4, id arg5);
typedef id(^SSBlock6)(id arg1, id arg2, id arg3, id arg4, id arg5, id arg6);

const NSS* SSTypeObject = @"object";

@implementation NSObject (SS)

- (const NSS*)typeof {return SSTypeObject; }
- (NSS*(^)())toString
{
  return ^() {
    if (SS.isNull(self)) return @"";
    return self.description;
  };
}
- (NSO*(^)(id key))get
{
  return ^NSO*(id key) {
    I index;
  
    // requesting a property
    if ([key isKindOfClass:[NSString class]])
    {
      NSS* stringKey = (NSS*)key;
      if ([(NSS*)key isEqual:@"length"])
        return N.I(self.length);

      // support JavaScript-style indexing by string
      N* indexNumber = SS.parseInt(stringKey);
      NSAssert(indexNumber, @"get did not recognize key '%@'", stringKey);
      index = indexNumber.I;
    }
    else
      index = ((N*)key).I;
    return self.getAt(index);
  };
}
- (NSO*(^)(I index))getAt
{
  return ^NSO*(I index) {
    NSAssert(nil, @"getAt not implemented for this type");
    return nil;
  };
}

- (NSS*)className { return NSStringFromClass([self class]); }

// use dynamic type checking for some JavaScript operations to reduce manual casting
- (UI)length
{
  // base class can be triggered by KeyValueCoding
  if (SS.isArray(self)) return ((NSA*)self).count;
  if (SS.isString(self)) return ((NSS*)self).length;
  return 0;
}
- (S*(^)(NSS* separator))join
{
  NSAssert(nil, @"join not implemented for this type");
  return nil;
}

- (id(^)(SEL method, id arg1, ...))call {
  return ^(SEL method, id arg1, ...) {
    AO_ARGS(arguments, arg1);
    return self.apply(method, arguments);
  };
}

- (id(^)(SEL method, NSA* arguments))apply {
  return ^(SEL method, NSA* arguments) {
    id returnValue;

    NSMethodSignature *methodSig = [[self class] instanceMethodSignatureForSelector:method];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
    [invocation setSelector:method];
    [invocation setTarget:self];

    // assume it could be a block style method
    if (methodSig.numberOfArguments == 2) {

      // call and get the return value
      [invocation invoke];
      [invocation getReturnValue:&returnValue];

      // if it is a function-style call, it will return a block so call the block
      if (SS.isBlock(returnValue))
      {
        // TODO: figure out a safe way to call blocks by signature
        if (arguments.length==0)
          return ((SSBlock0)returnValue)();
        if (arguments.length==1)
          return ((SSBlock1)returnValue)(arguments.getAt(0));
        if (arguments.length==2)
          return ((SSBlock2)returnValue)(arguments.getAt(0), arguments.getAt(1));
        if (arguments.length==3)
          return ((SSBlock3)returnValue)(arguments.getAt(0), arguments.getAt(1), arguments.getAt(2));
        if (arguments.length==4)
          return ((SSBlock4)returnValue)(arguments.getAt(0), arguments.getAt(1), arguments.getAt(2), arguments.getAt(3));
        if (arguments.length==5)
          return ((SSBlock5)returnValue)(arguments.getAt(0), arguments.getAt(1), arguments.getAt(2), arguments.getAt(3), arguments.getAt(4));
        if (arguments.length==6)
          return ((SSBlock6)returnValue)(arguments.getAt(0), arguments.getAt(1), arguments.getAt(2), arguments.getAt(3), arguments.getAt(4), arguments.getAt(5));
        NSAssert(nil, @"number of parameters not yet supported for apply");
      }
    }
    
    // call directly
    else {
      // set up the arguments
      I count = arguments.count;
      for (I index=0; index<count; index++) {
        [invocation setArgument:(__bridge void*)[arguments objectAtIndex:index] atIndex:index];
      }

      // call and get the return value
      [invocation invoke];
      [invocation getReturnValue:&returnValue];
    }
    
    return returnValue;
  };
}

- (B(^)(NSO* obj))in
{
  return ^B(NSO* obj) {
    return obj.get(self) != nil;
  };
}

// helper
- (NSComparisonResult)compare:(NSO*)other
{
  if (SS.isString(self)) return [(NSS*)self compare:(NSS*)other];
  if (SS.isNumber(self)) return [(N*)self compare:(N*)other];
  NSAssert(nil, @"cannot compare the provided objects");
  return NSOrderedSame;
}

@end