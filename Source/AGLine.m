//
// Author: Håvard Fossli <hfossli@agens.no>
//
// Copyright (c) 2013 Agens AS (http://agens.no/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AGLine.h"

const AGLine AGLineZero = (AGLine){(AGPoint){0.0, 0.0}, (AGPoint){0.0, 0.0}};

extern AGLine AGLineMake(AGPoint start, AGPoint end)
{
    return (AGLine){start, end};
}

extern AGLine AGLineMakeWithCGPoint(CGPoint start, CGPoint end)
{
    return AGLineMake(AGPointMakeWithCGPointZeroFill(start), AGPointMakeWithCGPointZeroFill(end));
}

extern double AGLineLength(AGLine l)
{
    return sqrt(pow(l.start.x - l.end.x, 2.0f) + pow(l.start.y - l.end.y, 2.0f));
}

BOOL AGLineIntersection(AGLine l1, AGLine l2, AGPoint *out_pointOfIntersection)
{
    // http://stackoverflow.com/a/565282/202451

    int x1 = l1.start.x, y1 = l1.start.y, x2 = l1.end.x, y2 = l1.end.y;
    int x3 = l2.start.x, y3 = l2.start.y, x4 = l2.end.x, y4 = l2.end.y;
    float d = ((float)(x1-x2) * (y3-y4)) - ((y1-y2) * (x3-x4));
    if (d)
    {
        AGPoint pt;
        pt.x = ((x1*y2 - y1*x2) * (x3-x4) - (x1-x2) * (x3*y4 - y3*x4)) / d;
        pt.y = ((x1*y2 - y1*x2) * (y3-y4) - (y1-y2) * (x3*y4 - y3*x4)) / d;
        //-10 is a threshold, the POI can be off by at most 10 pixels
        if(pt.x<MIN(x1,x2)-10||pt.x>MAX(x1,x2)+10||pt.y<MIN(y1,y2)-10||pt.y>MAX(y1,y2)+10){
            return NO;
        }
        if(pt.x<MIN(x3,x4)-10||pt.x>MAX(x3,x4)+10||pt.y<MIN(y3,y4)-10||pt.y>MAX(y3,y4)+10){
            return NO;
        }
        *out_pointOfIntersection = pt;
        return YES;
    }
    else {
        return NO;
    }

    
//    AGPoint p = l1.start;
//    AGPoint q = l2.start;
//    AGPoint r = AGPointSubtract(l1.end, l1.start);
//    AGPoint s = AGPointSubtract(l2.end, l2.start);
//    
//    double s_r_crossProduct = AGPointCrossProduct(r, s);
//    double t = AGPointCrossProduct(AGPointSubtract(q, p), s) / s_r_crossProduct;
//    double u = AGPointCrossProduct(AGPointSubtract(q, p), r) / s_r_crossProduct;
//    
//    if(t < 0 || t > 1.0 || u < 0 || u > 1.0)
//    {
//        if(out_pointOfIntersection != NULL)
//        {
//            *out_pointOfIntersection = AGPointZero;
//        }
//        NSLog(@"NO");
//        return NO;
//    }
//    else
//    {
//        if(out_pointOfIntersection != NULL)
//        {
//            AGPoint i = AGPointAdd(p, AGPointMultiply(r, t));
//            *out_pointOfIntersection = i;
//        }
//        return YES;
//    }
}