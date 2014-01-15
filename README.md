<<<<<<< HEAD
#AGGeometryKit

Create CATransform3D with quadrilaterals, useful math functions, calculate angle between views ++

### Consists of

* Additions for CGGeometry for common CGRect, CGSize and CGPoint calculations
* AGQuad which helps you create CATransform3D from convex quadrilaterals (basically you can turn any rectangle into any convex four-cornered shape)
* Some useful math functions

More about quadrilaterals: http://en.wikipedia.org/wiki/Quadrilateral

**Keywords**: Convex quadrilateral, simple quadrilateral, tangential, kite, rhombus, square, trapezium, trapezoid, parallelogram, bicentric, cyclic


Usage
------

I'm most curious myself about this part. You can use the quadrilateral on any view, even webviews with just as good performance as you would have not using it. 
Send me mail or twitter me anytime if you want to discuss possibilities and things you try to acheive. :)

Bartosz Ciechanowski created a ![genie effect](https://github.com/Ciechan/BCGenieEffect/) around desember 2012 which derives from a fraction of the code found here.


Example video animation with AGQuad
------

[![ScreenShot](https://raw.github.com/hfossli/AGGeometryKit/master/DemoApplication/AGGeometryKit/screenshot_youtube_XuzLhqe10u0.png)](http://www.youtube.com/watch?v=XuzLhqe10u0)


Example code property 'quadrilateral' on CALayer
------

You can access `quadrilateral` as a property just like you would do with `frame`, `center` or `bounds`.

    AGQuad quad = self.imageView.layer.quadrilateral;
    NSLog(@"Quad: %@", NSStringFromAGQuad(quad));
    
    quad.br.x += 20; // bottom right x
    quad.br.y += 50; // bottom right y
    
    self.imageView.layer.quadrilateral = quad;
    
It acts very similar to how `frame` relates to `center`, `transform` and `bounds`. In other words always reflects current presented state. With no transform as identity the quadrilateral returned will be the quadrilateral for `bounds`.

Example code animation with AGQuad
------

    - (IBAction)animateToOtherShape:(id)sender
    {
        AGQuad quad = AGQuadMakeWithCGRect(self.imageView.bounds);
        quad.tl.x -= 40; // top left x
        quad.tr.y -= 125; // top right y
        quad.br.y += 65; // bottom right y
        quad.bl.x += 40; // bottom left x
        [self animateToQuad:quad];
    }
    
    - (void)animateToQuad:(AGQuad)quad
    {        
        double (^interpolationFunction)(double) = ^(double p) {
            return (double) ElasticEaseOut(p); 
        };
        
        [self.imageView.layer animateFromPresentedStateToQuadrilateral:quad
                                                     forNumberOfFrames:2.0 * 60
                                                              duration:2.0
                                                                 delay:0.0
                                                               animKey:@"demo"
                                                 interpolationFunction:interpolationFunction
                                                            onComplete:nil];
    }

Standard CoreAnimation-animation using CATransform3D with custom interpolation between quad points.


Debugging
------

These things usually tend to mess up
- autoresizing mask (to be 100% sure it is good for debugging to turn off `autoresizesSubviews`)
- anchorPoint MUST be {0, 0} always when using quadrilaterals

I sometimes create a view to *represent* the quadrilateral if I'm having issues getting the right quadrilateral.

    UIView *quadPreview = [[UIView alloc] init];
    quadPreview.frame = quadView.frame;
    quadPreview.layer.shadowPath = [UIBezierPath bezierPathWithAGQuad:quad].CGPath;
    quadPreview.layer.shadowColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5].CGColor;
    quadPreview.layer.shadowOpacity = 1.0;
    quadPreview.layer.shadowRadius = 0.0;
    quadPreview.layer.shadowOffset = CGSizeZero;
    quadPreview.backgroundColor = [UIColor clearColor];
    [quadView.superview addSubview:quadPreview];

Cocoa pods
-------
    
It is added to the Cocoa Pods public repository as `AGGeometryKit`.    

[![Agens | Digital craftsmanship](http://static.agens.no/images/agens_logo_w_slogan_avenir_small.png)](http://agens.no/)
=======
MTGeometry
==========

An extension to Core Graphics Geometry. Intersections, scaling, etc.

### Installation

In your Podfile, add this line:

    pod "MTGeometry"

pod? => https://github.com/CocoaPods/CocoaPods/

NOTE: You may need to add `-all_load` to "Other Linker Flags" in your targets build settings if the pods library only contains categories.

### Functions

#### Points

    // Create a delta from x and y deltas
    CGDelta CGDeltaMake(CGFloat deltaX, CGFloat deltaY);
    
    // Get the distance between two points
    CGFloat	CGPointDistance(CGPoint p1, CGPoint p2);
    
    // A point along a line distance from point1.
    CGPoint CGPointAlongLine(CGLine line, CGFloat distance);
    
    // A point rotated around the pivot point by degrees.
    CGPoint CGPointRotatedAroundPoint(CGPoint point, CGPoint pivot, CGFloat degrees);

#### Lines

    // Create a line from 2 points.
    CGLine CGLineMake(CGPoint point1, CGPoint point2);
    
    // Returns true if two lines are exactly coincident.
    bool CGLineEqualToLine(CGLine line1, CGLine line2);
    
    // Get a line's midpoint.
    CGPoint CGLineMidPoint(CGLine line);
    
    // Get the point at which two lines intersect. Returns NOPOINT if they don't intersect.
    CGPoint CGLinesIntersectAtPoint(CGLine line1, CGLine line2);
    
    // Get the length of a line.
    CGFloat CGLineLength(CGLine line);
    
    // Returns a scaled line. Point 1 acts as the anchor and Point 2 is extended.
    CGLine CGLineScale(CGLine line, CGFloat scale);
    
    // Returns the delta x and y of the line from point 1 to point 2.
    CGDelta CGLineDelta(CGLine line);

#### Rectangles

    // Corner points of a CGRect
    CGPoint CGRectTopLeftPoint(CGRect rect);
    CGPoint CGRectTopRightPoint(CGRect rect);
    CGPoint CGRectBottomLeftPoint(CGRect rect);
    CGPoint CGRectBottomRightPoint(CGRect rect);
    
    // Returns a resized rect with the same centerpoint.
    CGRect	CGRectResize(CGRect rect, CGSize newSize);
    
    // Similar to CGRectInset but only insets one edge. All other edges do not move.
    CGRect	CGRectInsetEdge(CGRect rect, CGRectEdge edge, CGFloat amount);
    
    // Calculates the stacking of rectangles within a larger rectangle. The resulting rectangle is stacked counter clockwise along the edge specified. As soon as there are more rects than will fit, a new row is started, thus, they are stacked by column, then by row. `reverse` will cause them to be stacked counter-clockwise along the specified edge.
    CGRect	CGRectStackedWithinRectFromEdge(CGRect rect, CGSize size, int count, CGRectEdge edge, bool reverse);
    
    // Find the centerpoint of a rectangle.
    CGPoint CGRectCenterPoint(CGRect rect);
    
    // Assigns the closest two corner points to point1 and point2 of the rect to the passed in point.
    void	CGRectClosestTwoCornerPoints(CGRect rect, CGPoint point, CGPoint *point1, CGPoint *point2);
    
    // The point at which a line, extended infinitely past its second point, intersects the rectangle. Returns NOPOINT if no intersection is found.
    CGPoint CGLineIntersectsRectAtPoint(CGRect rect, CGLine line);


### Example Usage

Finding the point where two lines intersect:

    CGLine line1 = CGLineMake(CGPointMake(2, 0), CGPointMake(2, 4));
    CGLine line2 = CGLineMake(CGPointMake(0, 2), CGPointMake(4, 2));
    CGLinesIntersectAtPoint(line1, line2)	// => (2,2)

Find the closest two corner points of a rectangle to a point in space:

    CGRect rect = CGRectMake(2, 1, 4, 4);
    CGPoint point = CGPointMake(0, 0);
    CGPoint point1 = CGPointZero;
    CGPoint point2 = CGPointZero;
    CGRectClosestTwoCornerPoints(rect, point, &point1, &point2);	// => (0,0) (2,1)

The point where a line intersects a rect, if at all:

    CGRect rect = CGRectMake(1, 1, 4, 4);
    CGLine line = CGLineMake(CGPointMake(0, 1), CGPointMake(2, 2));
    CGLineIntersectsRectAtPoint(rect, line);	// => (5, 3.5)

>>>>>>> 777d58cc14af57ac262c4d4486cd6945db3d9f65
