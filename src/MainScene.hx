import com.haxepunk.Scene;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Joystick;

class MainScene extends Scene
{

  // set the movement speed
  private static inline var my_shape_speed:Float = 10;

  // set the rotation speed
  private static inline var my_shape_rotate_speed:Float = 10;

  // strict static input labels, (optional, you could just use literal strings)
  private static var INPUTS:{ LEFT:String, RIGHT:String, UP:String, DOWN:String} = {
    LEFT : "LEFT",
    RIGHT : "RIGHT",
    UP : "UP",
    DOWN : "DOWN"
  };

  /*
    The shape that we will be moving
   */
  private var my_shape:Entity;

  /*
    The Image object for my_shape
   */
  private var shape_image:Image;

  /*
    Store my_shape movement speed
   */
  private var my_shape_x_velocity:Float;
  private var my_shape_y_velocity:Float;
  private var my_shape_rotation_velocity:Float;

  /*
    Store Player 1 GamePad
   */
  private var player_1_gamepad:Joystick;

  public override function begin()
  {
    /*
      Create a new Entity
      http://haxepunk.com/documentation/api/com/haxepunk/Entity.html
     */
    my_shape = new Entity();

    /*
      Initialize my_shape movement speed
     */
    my_shape_x_velocity = 0;
    my_shape_y_velocity = 0;
    my_shape_rotation_velocity = 0;

    /*
      Create a new Image graphic
      http://haxepunk.com/documentation/api/com/haxepunk/graphics/Image.html#createRect
     */
    shape_image = Image.createRect( 100, 100, 0x3366FF );

    /*
      Make sure the shape rotates around a center origin
      instead of the default upper right corner
     */
    shape_image.originX = 50;
    shape_image.originY = 50;

    /*
      Set the Entity.graphic to the new image
      http://haxepunk.com/documentation/api/com/haxepunk/Entity.html#graphic
     */
    my_shape.graphic = shape_image;


    /*
      Add the new entity to this scene
      http://haxepunk.com/documentation/api/com/haxepunk/Scene.html#add
     */
    add( my_shape );

    // position the box
    my_shape.x = 250;
    my_shape.y = 250;

    /*
      Rotate the shape
      http://haxepunk.com/documentation/api/com/haxepunk/graphics/Image.html#angle
     */
    shape_image.angle = 125;

    /*
      Store a reference to Player 1
     */
    player_1_gamepad = Input.joystick(0);

    if( !player_1_gamepad.connected ){
      trace( "Did not detect a gamepad. Connect a gamepad and restart this demo." );
    }

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
   * moves my_shape
   */
  public inline function handleAnimation()
  {
    my_shape.x += my_shape_x_velocity;
    my_shape.y += my_shape_y_velocity;

    shape_image.angle += my_shape_rotation_velocity;
  }

  /**
   * Checks if keyboard input is triggered
   */
  private inline function handleInput()
  {

    /*
      Horizontal Movement
     */
    if ( player_1_gamepad.getAxis( XBOX_GAMEPAD.LEFT_ANALOGUE_X ) != 0 ){

      // move shape towards negative x axis
      my_shape_x_velocity = my_shape_speed * player_1_gamepad.getAxis( XBOX_GAMEPAD.LEFT_ANALOGUE_X ) ;

    }else{

      // stop moving horizontally
      my_shape_x_velocity *= .9; // set to = 0; to stop hard

    }

    /*
      Vertical Movement
     */
    if ( player_1_gamepad.getAxis( XBOX_GAMEPAD.LEFT_ANALOGUE_Y ) != 0 ){

      // move shape towards negative y axis
      my_shape_y_velocity = my_shape_speed * player_1_gamepad.getAxis( XBOX_GAMEPAD.LEFT_ANALOGUE_Y );

    }else{

      // stop moving vertically
      my_shape_y_velocity *= .9; // set to = 0; to stop hard

    }

    /*
      Rotation Control
      (this registered as Y axis for my test gamepad)
     */
    if ( player_1_gamepad.getAxis( XBOX_GAMEPAD.RIGHT_ANALOGUE_X ) != 0 ){

      // rotate shape
      my_shape_rotation_velocity = my_shape_rotate_speed * player_1_gamepad.getAxis( XBOX_GAMEPAD.RIGHT_ANALOGUE_X );

    }else{

      // stop rotating
      my_shape_rotation_velocity *= .9; // set to = 0; to stop hard

    }


  }

}