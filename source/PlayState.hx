package;

import haxe.Json;

import openfl.Assets;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.group.FlxGroup;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.math.FlxMath;

class PlayState extends FlxState {
  private var babyBlue = FlxColor.fromString("#ABE5F5");
  private var niceRed = FlxColor.fromString("#ED2898");

  private var text: FlxText;

  private var options: FlxTypedGroup<FlxText>;

  private var story: Map<String, Block>;
  private var current: Block;

  private var selected = 0;

	override public function create(): Void {
		super.create();

    FlxG.camera.bgColor = babyBlue;

    var rawStory: Story = Json.parse(Assets.getText("assets/data/story.json"));
    trace(rawStory.story[0]);
  
    story = new Map<String, Block>();
    for (block in rawStory.story) {
      story.set(block.name, block);
    }
 
    options = new FlxTypedGroup<FlxText>();

    for (i in 0...10) {
      var txt = new FlxText(0, FlxG.height - FlxG.height/4, FlxG.width, "", 32);
      txt.exists = true;

      options.add(txt);
    }

    add(options);

    text = new FlxText(0, FlxG.height/3, FlxG.width, "", 32);
    text.alignment = FlxTextAlign.CENTER;
    text.addFormat(new FlxTextFormat(niceRed));

    add(text);

    changeBlock();
 	}

	override public function update(elapsed: Float): Void {
		super.update(elapsed);

    if (FlxG.keys.justPressed.LEFT) {
      selected -= 1;
    } else if (FlxG.keys.justPressed.RIGHT) {
      selected += 1;
    }

    if (FlxG.keys.justPressed.ENTER) {
      var finalSelected = selected % current.links.length;
      trace(finalSelected);

      changeBlock(current.links[finalSelected].to);
    }
	}

  private function changeBlock(key: String = "start") {
    current = story.get(key);

    options.forEachExists(function(option: FlxText) {
        option.exists = false;
      });

    var optionWidth = FlxG.width / current.links.length;

    for (i in 0...current.links.length) {
      var link = current.links[i];

      var option = options.getFirstAvailable();
      option.width = optionWidth;
      option.x = optionWidth * i;
      option.text = link.name;
      option.alignment = FlxTextAlign.CENTER;
      option.exists = true;
    }

    text.text = current.text.join("\n");
  }
}

typedef Story = {
  story: Array<Block>
};

typedef Block = {
  name: String,
  text: Array<String>,
  links: Array<Link>
};

typedef Link = {
  name: String,
  to: String
}
