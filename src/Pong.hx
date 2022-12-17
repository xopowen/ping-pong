import hxd.res.Image;
import h2d.Bitmap;
import haxe.Constraints.Function;
import Entity;
import Vector2d;
import hxd.Event;
import hxd.Window;


class Pong extends Game{
    var res:hxd.Res;

 
    var playerRackets:Entity;
    var botRackets:Entity;
    var ball:Entity;
 
    var exitGame:Function;

    var width:Float;
    var height:Float;
    var moveSade:Float;

    var racketsHeight:Float;
    var racketsWidth:Float;
    var rackets:hxd.res.Image;
    var H1:h2d.Text;
    public function new(scene,res,exitGame) {
        super();
        this.exitGame = exitGame;
        name  = "Pong";
        logo = hxd.Res.poing_Logo.toTile();
        this.scene = scene;
        width = scene.getSize().width;
        height = scene.getSize().height;
        racketsHeight = 500;
        racketsWidth = 50;
 
    }
    override public function  start(){
        score = 0;
        level = 1;
        H1 = new h2d.Text(hxd.res.DefaultFont.get(), scene);
        H1.text = ' ${score}';
        H1.textColor = 0x6b1de9;
        H1.setScale(2);
        trace(name+' started');
        hxd.Res.initEmbed();
        var logationPlayer = new Vector2d(0,0);
        rackets =  hxd.Res.rackets;
        playerRackets = new Entity(rackets,logationPlayer,scene,{width:racketsWidth,height:racketsHeight});

        var logationBot = new Vector2d(width - 50,0);
        botRackets = new Entity(rackets,logationBot,scene,{width:racketsWidth,height:racketsHeight});
    
        startLaval();

        playerRackets.EffectTouchUp = function(){
           playerRackets.stop();
        }
        playerRackets.EffectTouchDown = function(){
            playerRackets.stop();
         }
         botRackets.EffectTouchDown = function(){
            botRackets.stop();
            botRackets.applyForce(new Vector2d(0, - (botRackets.location.y - (height-102 - racketsHeight))));
         }
         botRackets.EffectTouchUp =function(){
            botRackets.stop();
            botRackets.applyForce(new Vector2d(0,-botRackets.location.y ));
         }
         hxd.Window.getInstance().addEventTarget(onEvent);

    }


    function chackWinOrlost(){
        trace(score);
        H1.text = ' ${score}';
        if(score>=9){
            end();
            exitGame('you win');
         
        }else if(score<= -9){
            end();
            exitGame('you lose');
        }
    }
 

    function startLaval(){
        var ballLogationStart = new Vector2d( width/2-25, height/2-25);
        ball = new Entity(rackets,ballLogationStart,scene,{width:25,height:25});
        
        ball.applyForce(new Vector2d(-40 + level*2,-40+ level*2));
       
        ball.EffectTouchLeft = function(){
            if(ball.location.x < racketsWidth){
                score  -= 1;
                ball.removeImage();
                startLaval();
                chackWinOrlost();
            }else if(Std.int(playerRackets.velocity.y) !=0){
                ball.applyForce(ball.velocity.mul(1.5* level));
            }
        }
        ball.EffectTouchRight =  function(){
            if(ball.location.x >  width-20){
                score +=1;
                levelUp();
                ball.removeImage();
                startLaval();
                chackWinOrlost();
            }else if(Std.int(playerRackets.velocity.y) !=0){
                ball.applyForce(ball.velocity.mul(1.5* level));
            }
        }

    }

    override function end(){
        ball.removeImage();
        playerRackets.removeImage();
        botRackets.removeImage();
        H1.remove();
        hxd.Window.getInstance().removeEventTarget(onEvent);
      
    }

    function botMove(){
        var extraSpace:Float = 0;
        var botCenterY =  botRackets.location.y+racketsHeight/2;
        var botSpeedY = botRackets.velocity.y;
        var ballCenterY = ball.location.y;
        var ballSpeedY = ball.velocity.y;
        var speed =  Vector2d.zero();
        if(ballCenterY < botCenterY - racketsHeight/2 || ballCenterY > botCenterY + racketsHeight/2){
            if(botSpeedY!=ballSpeedY){
                speed = new Vector2d(0,ballSpeedY).limit(3 * level);
            }
        }else{
            botRackets.stop();
        }
 
    
        botRackets.applyForce(speed);
    }
    

    function moveBall(){
        moveSade =  0;
        if(ball.location.x > width/2){
            if(botRackets.location.y < ball.location.y && botRackets.location.y + racketsHeight > ball.location.y){
                moveSade = -racketsWidth;
            }
        }else{
            if(playerRackets.location.y < ball.location.y && playerRackets.location.y + racketsHeight > ball.location.y){
                moveSade =  racketsWidth-10;
                if( ball.location.x < racketsWidth  && playerRackets.velocity.y>0){
                
                    ball.applyForce(ball.velocity.div(2));
                }
            } 
        }      
    
    }

    function moveEntity(entity:Entity,speed:Vector2d){
 
        entity.applyForce(speed);
       

      
    }

    override public function update(dt){
        playerRackets.update(dt);
        botRackets.update(dt);
        ball.update(dt);
        botMove();
        moveBall();
        ball.applyBoundaries(moveSade, width + moveSade,0, height-100);
        playerRackets.applyBoundaries(0 , width ,0-racketsHeight/2, height-100 - racketsHeight/2);
        botRackets.applyBoundaries(-10 , width ,0-racketsHeight/2, height-100 - racketsHeight/2);
    } 

    function onEvent(event:Event){
     
        switch(event.kind){
          case EKeyDown:{
            switch (event.keyCode){
              case hxd.Key.W: moveEntity(playerRackets,new Vector2d(0,-30)) ;
              case hxd.Key.S: moveEntity(playerRackets,new Vector2d(0, 30))  ;
              case _:
            }
          }
          case _:
        }
      }
  




}
