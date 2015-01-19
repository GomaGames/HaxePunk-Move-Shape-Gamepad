import com.haxepunk.Scene;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Joystick;

class Player extends Entity
{
  // set the movement speed
  private static inline var player_speed:Float = 10;

  // set the rotation speed
  private static inline var player_rotate_speed:Float = 10;

  // shape colors
  private static var PLAYER_COLORS:Array<Int> = [ 0x3399FF, 0x33FF66, 0xFF6633, 0x33FFFF ];

  // strict static input labels, (optional, you could just use literal strings)
  private static var INPUTS:{ LEFT:String, RIGHT:String, UP:String, DOWN:String} = {
    LEFT : "LEFT",
    RIGHT : "RIGHT",
    UP : "UP",
    DOWN : "DOWN"
  };

  /*
    The Image object for player
   */
  private var shape_image:Image;

  /*
    Store player movement speed
   */
  private var player_x_velocity:Float;
  private var player_y_velocity:Float;
  private var player_rotation_velocity:Float;

  private var image:Image;

  /*
    Store Player GamePad
   */
  private var player_gamepad:Joystick;

  /*
    Assigned by having a gamepad plugged in
   */
  private var player_number:Int;

  /*
    Create a new Entity
    http://haxepunk.com/documentation/api/com/haxepunk/Entity.html
   */
  public function new( player_number:Int ){
    
    this.player_number = player_number;
    this.player_gamepad = Input.joystick( player_number );

    super( 100 * (player_number+1), 250 );

    /*
      Initialize player movement speed
     */
    player_x_velocity = 0;
    player_y_velocity = 0;
    player_rotation_velocity = 0;


    /*
      Create a new Image graphic
      http://haxepunk.com/documentation/api/com/haxepunk/graphics/Image.html#createRect
     */
    image = Image.createRect( 50, 50, PLAYER_COLORS[ player_number ] );
    
    /*
      Make sure the shape rotates around a center origin
      instead of the default upper right corner
     */
    image.originX = 25;
    image.originY = 25;

    /*
      Rotate the shape
      http://haxepunk.com/documentation/api/com/haxepunk/graphics/Image.html#angle
     */
    image.angle = 125;

    /*
      Set the Entity.graphic to the new image
      http://haxepunk.com/documentation/api/com/haxepunk/Entity.html#graphic
     */
    this.graphic = image;

  }

  /*
    Performed by the game loop, updates all contained Entities.
    If you override this to give your Scene update code, remember to call super.update() or your Entities will not be updated.
    http://haxepunk.com/documentation/api/com/haxepunk/Scene.html#update
   */
  public override function update()
  {
    handleInput();

    handleAnimation();
    
    super.update();
  }

  /**
   * moves player
   */
  public inline function handleAnimation()
  {
    this.x += player_x_velocity;
    this.y += player_y_velocity;

    image.angle += player_rotation_velocity;
  }

  /**
   * Checks if keyboard input is triggered
   */
  private inline function handleInput()
  {

    /*
      Horizontal Movement
     */
    if ( player_gamepad.getAxis( XBOX_GAMEPAD.LEFT_ANALOGUE_X ) != 0 ){

      // move shape towards negative x axis
      player_x_velocity = player_speed * player_gamepad.getAxis( XBOX_GAMEPAD.LEFT_ANALOGUE_X ) ;

    }else{

      // stop moving horizontally
      player_x_velocity *= .9; // set to = 0; to stop hard

    }

    /*
      Vertical Movement
     */
    if ( player_gamepad.getAxis( XBOX_GAMEPAD.LEFT_ANALOGUE_Y ) != 0 ){

      // move shape towards negative y axis
      player_y_velocity = player_speed * player_gamepad.getAxis( XBOX_GAMEPAD.LEFT_ANALOGUE_Y );

    }else{

      // stop moving vertically
      player_y_velocity *= .9; // set to = 0; to stop hard

    }

    /*
      Rotation Control
      (this registered as Y axis for my test gamepad)
     */
    if ( player_gamepad.getAxis( XBOX_GAMEPAD.RIGHT_ANALOGUE_X ) != 0 ){

      // rotate shape
      player_rotation_velocity = player_rotate_speed * player_gamepad.getAxis( XBOX_GAMEPAD.RIGHT_ANALOGUE_X );

    }else{

      // stop rotating
      player_rotation_velocity *= .9; // set to = 0; to stop hard

    }


  }

}