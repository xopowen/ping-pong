import h2d.Tile;
import h2d.Bitmap;

abstract class Game{
    public  var logo(get,default):h2d.Tile;
	var scene:h2d.Scene;
    public var name:String;
    public var score:Int;
    var level:Int;

    function get_logo():Tile {
        return logo;
    }

 

    public function new(){
        level = 1;
    }

    function levelUp(){
        if(level<9){
            level += 1;
        }
       
    }

    public function start(){
        score = 0;

    }

    public function end(){
        
    }
    public function update(d:Float) {
        trace(name );
    }
} 
