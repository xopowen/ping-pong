import h2d.Object;
import h2d.Scene;
import Game;
import hxd.Event;
class CompilationGames{
    

    var games:Array<Game>;

    var gameRunning:Null<Game>;
	var scene:h2d.Scene;

    var menyShowStatus:Bool;
 
    var height:Float;
    var width:Float;
    var startPositionsLogo:Array<Array<Float>>;

    var gamesBitmap:Array<h2d.Bitmap>;

    var H1:Null<h2d.Text>;
    
    public function  new(scene,res){
        this.scene = scene;
        
        scene.setScale(0.9);
        height = scene.getSize().height;
        width = scene.getSize().width;
        games = new Array<Game>();

        games.push(new Pong(this.scene,res,exitGame));
        games.push(new FlappyBird());
        gamesBitmap = new Array<h2d.Bitmap>();
        startPositionsLogo = [[width/2 - 256,height/2 - 256]];
        menyShowStatus = false;
    }

    function removeMenu() {
        for (i in gamesBitmap){
            i.remove();
            startPositionsLogo.pop();
        }
        gamesBitmap = new Array<h2d.Bitmap>();
        menyShowStatus = !menyShowStatus;
       
    }

    function showMenu(){
        if(!menyShowStatus){
            for( i in games){
                var s:h2d.Bitmap =  new h2d.Bitmap(i.logo, this.scene);
                gamesBitmap.push(s);
                var startPoslast:Array<Float> = startPositionsLogo[startPositionsLogo.length-1];
                s.setPosition(startPoslast[0],startPoslast[1] );
                s.height=256;
                s.width=256;
                startPositionsLogo.push([ startPoslast[0] + s.getSize().width,startPoslast[1]]);

            };
            menyShowStatus = !menyShowStatus;
        }
        selectionGame();
    }

    function selectionGame(){
        //выбераим игру навидением миши
        var  mouseX = scene.mouseX;
        var  mouseY = scene.mouseY;
        
        for ( i in 0...startPositionsLogo.length-1){
            var startPoslast:Null<Array<Float>> = startPositionsLogo[i];
            if(startPoslast == null){
                return;
            }
            if(mouseX > startPoslast[0] && mouseX < startPoslast[0]+256){
                if(mouseY > startPoslast[1] && mouseY < startPoslast[1]+256){
                    gameRunning = games[i];
                    gameRunning.start();
                    removeMenu();
                }
            }
        }

    }
    // создать функцию выхода из игры и передать её играм .
    public function exitGame(str:String){
        gameRunning=null;
        H1 = new h2d.Text(hxd.res.DefaultFont.get(), scene);
        H1.textColor = 0x6b1de9;
        H1.setScale(2);
        H1.text = str;

    }


    function onEvent(event:Event){
        
    }


    public function update(dt:Float){
        if(gameRunning==null){
            showMenu();
        }else{
            if(H1 != null){
                H1.remove();
            }
            gameRunning.update(dt);
        }

    }


}

