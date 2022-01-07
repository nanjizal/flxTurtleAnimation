package;

import flixel.FlxState;
import cornerContour.flx.FlxCornerContour;
import cornerContour.io.IteratorRange;
// contour code
import cornerContour.Sketcher;
import cornerContour.Pen2D;
import cornerContour.StyleSketch;
import cornerContour.StyleEndLine;
// SVG path parser
import justPath.*;
import justPath.transform.ScaleContext;
import justPath.transform.ScaleTranslateContext;
import justPath.transform.TranslationContext;

class TurtleTest extends FlxState {
    var view1: FlxCornerContour;
    var view2: FlxCornerContour;
    var view3: FlxCornerContour;
    // using range for animation with Flixel is too slow.
    //var range: IteratorRange;
    var theta = 0.;
    override public function create(){
        super.create();
        view1 = new FlxCornerContour( 0, 0 );
        add( view1 );
        view2 = new FlxCornerContour( 0, 0 );
        add( view2 );
        view3 = new FlxCornerContour( 0, 0 );
        add( view3 );
        view1.pen2D.currentColor = 0xff0000FF;
        view2.pen2D.currentColor = 0xff0000FF;
        view3.pen2D.currentColor = 0xff0000FF;
        turtleStar();
        //turtleTest0();
        
        haxeLogo();
        heptagram();
        //var s = view.pen2D.pos;
        enneagram();
        //var e = view.pen2D.pos;
        //range = Std.int( s )...Std.int( e - 1 ); 
        view1.rearrageDrawData();
        view2.rearrageDrawData();
        view3.rearrageDrawData();
    }
    override public function update( elapsed: Float ){
        super.update( elapsed );
        //view1.clear();
        //view1.pen2D.arr.translateRange( range, 3*Math.sin( theta ), 3*Math.cos( theta ) );
        theta += 0.03;
        //view1.rearrageDrawData();
        view1.x += 3*Math.sin( theta );
        view1.y += 3*Math.cos( theta );
    }
    // Feel free to improve and pull better one.
    public 
    function haxeLogo(){
        // ( repeat 6 times so the star has last corner round. )
        var a = 10;
        var b = 47;
        var turtle = view1.createTurtle();
        turtle.setPosition( 500, 300 );
        turtle.turtleHistoryOn = true;
        turtle.penSize( 8 )
                .red()
                .fillOff()
                .circle( 10 )
                .orange()
                .north()
                .forward( 100 )
                .right( b-a/2 - 2 )
                .beginRepeat( 40 )
                .right( a )
                .forwardFactor( .98 )//( 100 )
                .right( b )
                .forwardFactor( .98 )//100 )
                .penSizeChange( -0.18 )
                .right( a*2+b )
                .right( a )
                .forwardFactor( .98 )//( 100 )
                .right( b )
                .forwardFactor( .98 )
                .left( 92 )
                .penSizeChange( -0.18 )
                .endRepeat()
                .orange();
        turtle.turtleHistoryOn = false;
        turtle.setPosition( 300, 500 );
        turtle.north();
        turtle.traceHistory();
        turtle.playHistory( 0 );
    }
    
    public
    function enneagram(){
        var sides = 9;
        var angle: Float = turtleGram( 9 );
        var turtle = view1.createTurtle();
        turtle.setPosition( 700, 180 )
                .penSize( 10 )
                .yellow()
                .penColorChange( -0.09, 0.01, 0.09 )
                .west()
                .fillOff()
                .beginRepeat( sides+1 ) // to make corners nice, do extra turn.
                .archBezier( 300, 150, -10 )
                .right( angle )
                .penColorChange( -0.09, 0.01, 0.09 )
                .endRepeat()
                .blue();
    }
    inline
    function turtleGram( sides: Int ){
        return 4.*(90.-360./sides);
    }
    public
    function heptagram(){
        var turtle = view2.createTurtle();
        turtle.setPosition(700, 400 )
                .penSize( 10 )
                .plum()
                .west()
                .fillOff()
                .beginRepeat( 7+1 ) // to make corners nice, do extra turn.
                .archBezier( 300, 150, 30 )
                .right( 4*(90-360/7) )
                .penColorChange( 0.09, 0.1, -0.09 )
                .endRepeat()
                .blue();
    }
    public
    function turtleStar(){
        // ( repeat 6 times so the star has last corner round. )
        var turtle = view3.createTurtle();
        turtle.setPosition( 50, 150 )
                .penSize( 10 )
                .blue()
                .west()
                .fillOff()
                .beginRepeat( 6 )
                .archBezier( 300, 150, 30 )
                .right( 144 )
                .penColorChange( 0.09, 0.1, -0.09 )
                .endRepeat()
                .blue();
    }
    public
    function turtleTest0(){
        var turtle = view1.createTurtle();
        turtle.setPosition( 400, 200 )
            .penSize( 30 )
            .forward( 60 )
            .right( 45 )
            .forward( 60 )
            .right( 45 )
            .forward( 70 )
            .arc( 50, 120 );
    }
}
