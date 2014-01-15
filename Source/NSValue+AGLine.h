

#import <Foundation/Foundation.h>
#import "AGLine.h"

@interface NSValue (AGLine)

+ (NSValue *)valueWithAGLine:(AGLine)l;
- (AGLine)AGLineValue;

@end

