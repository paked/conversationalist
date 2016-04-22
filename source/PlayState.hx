package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.math.FlxMath;

class PlayState extends FlxState {
  private var babyBlue = FlxColor.fromString("#ABE5F5");
  private var niceRed = FlxColor.fromString("#ED2898");

  private var text: FlxText;

	override public function create(): Void {
    FlxG.camera.bgColor = babyBlue;

    text = new FlxText(0, FlxG.height/3, FlxG.width, "Hello", 32);
    text.alignment = FlxTextAlign.CENTER;
    text.addFormat(new FlxTextFormat(niceRed));
    text.text = "Fuck.";

    add(text);

		super.create();
	}

	override public function update(elapsed: Float): Void {
		super.update(elapsed);
	}
}
