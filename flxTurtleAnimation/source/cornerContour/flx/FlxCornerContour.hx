package cornerContour.flx;

// contour code
import cornerContour.Sketcher;
import cornerContour.Pen2D;
import cornerContour.animate.Turtle;
import cornerContour.StyleSketch;
import cornerContour.StyleEndLine;
// SVG path parser
import justPath.*;
import justPath.transform.ScaleContext;
import justPath.transform.ScaleTranslateContext;
import justPath.transform.TranslationContext;

import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

using flixel.util.FlxSpriteUtil;

inline
function colorAlpha( color: Int, alpha: Float ): Int
    return ( toHexInt( alpha ) << 24 ) | rgbInt( color );

inline
function toHexInt( c: Float ): Int
    return Math.round( c * 255 );

inline
function rgbInt( c: Int ): Int
    return ( c << 8 ) >> 8;

class FlxCornerContour extends FlxSprite {
    public var pen2D: Pen2D;
    public var sketcher: Sketcher;
    public var wid: Int = 1024;
    public var hi: Int = 768;
    public
    function new( x: Float, y: Float ){
        super( x, y );
        clear();
        pen2D = new Pen2D( 0xFFFFFFFF );
        pen2D.currentColor = 0xFFfF0000;
        sketcher = new Sketcher( pen2D, StyleSketch.Fine, StyleEndLine.both );
        sketcher.width = 1.;
    }
    public
    function createSketcher(): Sketcher {
        return new Sketcher( pen2D, StyleSketch.Fine, StyleEndLine.no );
    }
    public
    function createTurtle(): Turtle {
        return new Turtle( createSketcher() );
    }
    public
    function rearrageDrawData(){
        var pen = pen2D;
        var data = pen.arr;
        var totalTriangles = Std.int( data.size/7 );
        for( i in 0...totalTriangles ){
            pen.pos = i;
            // draw to canvas surface
            triangle2DFill( data.ax, data.ay
                , data.bx, data.by
                , data.cx, data.cy
                , Std.int( data.color ) );
        }
    }
    public inline
    function triangle2DFill( ax: Float, ay:Float
                           , bx: Float, by: Float
                           , cx: Float, cy: Float
                           , color: Null<Int> )
    {
        drawTriangle( ax, ay, bx, by, cx, cy, color );
        return 1;
    }
    public inline
    function triangle2DFillandAlpha( ax: Float, ay: Float
                                   , bx: Float, by: Float
                                   , cx: Float, cy: Float
                                   , color: Null<Int>, ?alpha: Null<Float> ): Int {
        if( alpha != 1. ) color = colorAlpha( color, alpha ); 
        drawTriangle( ax, ay, bx, by, cx, cy, color );
        return 1;
    }
    inline
    function drawTriangle( ax: Float, ay:Float, bx: Float, by: Float, cx: Float, cy: Float, FillColor:FlxColor = FlxColor.WHITE, ?lineStyle:LineStyle,
                ?drawStyle:DrawStyle ){
        var fg = FlxSpriteUtil.flashGfx;
        FlxSpriteUtil.beginDraw( FillColor, lineStyle );
        fg.moveTo( ax, ay );
        fg.lineTo( bx, by );
        fg.lineTo( cx, cy );
        fg.lineTo( ax, ay );
        FlxSpriteUtil.endDraw( this, drawStyle );
        return this;
    }
    public
    function whiteBackground(){
        FlxSpriteUtil.drawRect( this, 0, 0, wid, hi, FlxColor.WHITE );
    }
    public
    function blackBackground(){
        FlxSpriteUtil.drawRect( this, 0, 0, wid, hi, FlxColor.BLACK );
    }
    public
    function background( color: FlxColor ){
        FlxSpriteUtil.drawRect( this, 0, 0, wid, hi, color );
    }
    public
    function clear(){
        makeGraphic( wid, hi, FlxColor.TRANSPARENT, true );
    }
}