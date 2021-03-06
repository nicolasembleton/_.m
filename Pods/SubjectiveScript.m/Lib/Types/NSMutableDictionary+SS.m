//
//  NSMutableDictionary+SS.m
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

#import "NSMutableDictionary+SS.h"
#import "NSDictionary+SS.h"

@implementation NSMutableDictionary (Object)

+ (O*(^)(const KV* values /* NIL_TERMINATED */))newWithKV
{
  return ^(const KV* values /* NIL_TERMINATED */) {
    O* result = O.new;
    for (const id* pair = (const id*) values; *pair != nil; pair+=2) {
      id value = pair[1];
      [result setValue:value ? value : NSNull.null forKey:pair[0]];
    }
    
    return result;
  };
}

+ (O*(^)(UI capacity))newC
{
  return ^(UI capacity) {
    return [O dictionaryWithCapacity:capacity];
  };
}

- (O*(^)())toMutable { return ^{ return self; }; }

- (NSO*(^)(id key, SSGetOrAddBlock add))getOrAdd
{
  return ^(id key, SSGetOrAddBlock add) {
    id value = [self objectForKey:key];
    if (value) return value;
    
    // create a new one
    value = add();
    [self setValue:value forKey:key];
    return value;
  };
}

- (O*(^)(id key, id value))set
{
  return ^(id key, id value) {
    if (!value) value = NSNull.null;
    [self setValue:value forKey:key];
    return self;
  };
}

- (O*(^)(const KV* values /* NIL_TERMINATION */))setKV
{
  return ^(const KV* values /* NIL_TERMINATION */) {
    for (const id* pair = (const id*) values; *pair != nil; pair+=2) {
      id value = pair[1];
      [self setValue:value ? value : NSNull.null forKey:pair[0]];
    }
    return self;
  };
}

- (O*(^)(NSD* other))setO
{
  return ^(NSD* other) {
    [other enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
      [self setValue:obj forKey:key];
    }];
    return self;
  };
}

@end
