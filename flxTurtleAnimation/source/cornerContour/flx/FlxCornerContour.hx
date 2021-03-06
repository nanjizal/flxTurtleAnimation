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

inline
function getAlpha( c: Float ): Float
    return ((Std.int(c) >> 24) & 255 )/255;
    
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
        FlxSpriteUtil.beginDraw( null, null );
        var fg = FlxSpriteUtil.flashGfx;
        for( i in 0...totalTriangles ){
            pen.pos = i;
            fg.lineStyle( 0, 0xFFFFFF, 0 );
            fg.beginFill( rgbInt( Std.int( data.color ) ), getAlpha( data.color ) );
            fg.moveTo( data.ax, data.ay );
            fg.lineTo( data.bx, data.by );
            fg.lineTo( data.cx, data.cy );
            fg.lineTo( data.ax, data.ay );
            fg.endFill();
        }
        FlxSpriteUtil.endDraw( this, {} );
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