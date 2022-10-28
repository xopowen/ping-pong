import hxd.Event;
import hxd.Window;
import h2d.Console;
import Vector2d;
import Entity;
import CompilationGames;


class Main extends hxd.App {

  var width: Int;
  var height: Int;

  var sky: h2d.Bitmap;
  var center: Vector2d;
  var tf:h2d.Text;

  var entity:Entity;
  var CompilationGames:CompilationGames ;

  override function init():Void {
   
    hxd.Res.initEmbed();
    intitScene();
    CompilationGames = new CompilationGames(s2d,hxd.Res);
  }
  function intitScene():Void{
    var bg:h2d.Bitmap = new h2d.Bitmap(hxd.Res.skybox.toTile(), s2d);
    width = Std.int(bg.getBounds().width);
    height = Std.int(bg.getBounds().height);
    //s2d.scaleMode = ScaleMode.Stretch(width, height);
    center = new Vector2d(width / 2, height / 2);
    Window.getInstance().resize(width,height);
  }
  override function update(dt:Float) {
      CompilationGames.update(dt);
    }

    static function main() {
      trace('start' );
      new Main();
    }
 
}