import com.haxepunk.Scene;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Joystick;

class MainScene extends Scene
{
  /*
    The shape that we will be moving
   */
  private var players:Array<Player>;

  public function new()
  {
    players = new Array<Player>();

    super();
  }
  
  public override function begin()
  {
    
    /*
      Create a player for every gamepad connected
     */
    for (player_num in 0...4) {
    
      if( Input.joystick( player_num ).connected ){
        trace( player_num, "connected" );
        var new_player = new Player( player_num );
        add( new_player );
        players.push( new_player );
      }

      /*
        Add the new entity to this scene
        http://haxepunk.com/documentation/api/com/haxepunk/Scene.html#add
       */

    }
    

    if( players.length == 0 ){
      trace( "Did not detect any gamepads. Connect a gamepad and restart this demo." );
    }

  }

}