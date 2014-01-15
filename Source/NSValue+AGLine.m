

#import "NSValue+AGLine.h"

@implementation NSValue (AGLine)

+ (NSValue *)valueWithAGLine:(AGLine)l
{
    double values[4];
    for(int i = 0; i < 2; i++)
    {
        AGPoint p = l.v[i];
        values[(i*2)] = p.v[0];
        values[(i*2)+1] = p.v[1];
    }
    NSValue *value = [NSValue value:&l withObjCType:@encode(double[4])];
    return value;
}

- (AGLine)AGLineValue
{
    AGLine l = AGLineZero;
    double values[4];
    [self getValue:values];
    for(int i = 0; i < 2; i++)
    {
        AGPoint p = AGPointMake(values[(i*2)], values[(i*2)+1]);
        l.v[i] = p;
    }
    return l;
}

@end
