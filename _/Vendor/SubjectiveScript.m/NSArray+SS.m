//
//  NSArray+SS.m
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

#import "NSArray+SS.h"
#import "NSNumber+SS.h"

@implementation NSArray (SS)

- (S*(^)())toString { return ^() { return self.description.mutableCopy; }; }

- (UI)length
{
  return [self count];
}

- (NSO*(^)(I))get
{
  return ^(I index) {
    return (index<self.length) ? [self objectAtIndex:index] : NSNull.null;
  };
}

- (S*(^)(NSS* separator))join
{
  return ^(NSS* separator) {
    return [self componentsJoinedByString:separator].mutableCopy;
  };
}

- (A*(^)(UI start, UI count))slice
{
  return ^(UI start, UI count) {
    if ((start + count)>self.length-1) count = self.length - start; // clamp to end of array
    return [self subarrayWithRange:NSMakeRange(start, count)].mutableCopy;
  };
}


@end