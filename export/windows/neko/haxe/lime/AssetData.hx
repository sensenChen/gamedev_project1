package lime;


import lime.utils.Assets;


class AssetData {

	private static var initialized:Bool = false;
	
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var path = new #if haxe3 Map <String, #else Hash <#end String> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();	
	
	public static function initialize():Void {
		
		if (!initialized) {
			
			path.set ("assets/data/data-goes-here.txt", "assets/data/data-goes-here.txt");
			type.set ("assets/data/data-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/test.csv", "assets/data/test.csv");
			type.set ("assets/data/test.csv", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/Attacks_64x64x3.png", "assets/images/Attacks_64x64x3.png");
			type.set ("assets/images/Attacks_64x64x3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/duck.png", "assets/images/duck.png");
			type.set ("assets/images/duck.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/h1.png", "assets/images/h1.png");
			type.set ("assets/images/h1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/h2.png", "assets/images/h2.png");
			type.set ("assets/images/h2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/h3.png", "assets/images/h3.png");
			type.set ("assets/images/h3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/h4.png", "assets/images/h4.png");
			type.set ("assets/images/h4.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/h5.png", "assets/images/h5.png");
			type.set ("assets/images/h5.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/heart.png", "assets/images/heart.png");
			type.set ("assets/images/heart.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Heart_128x192_64x64.png", "assets/images/Heart_128x192_64x64.png");
			type.set ("assets/images/Heart_128x192_64x64.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Heart_64x64x6.png", "assets/images/Heart_64x64x6.png");
			type.set ("assets/images/Heart_64x64x6.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/images-go-here.txt", "assets/images/images-go-here.txt");
			type.set ("assets/images/images-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/Tiles.png", "assets/images/Tiles.png");
			type.set ("assets/images/Tiles.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Tiles_64x64x2.png", "assets/images/Tiles_64x64x2.png");
			type.set ("assets/images/Tiles_64x64x2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/music/BossLoop.wav", "assets/music/BossLoop.wav");
			type.set ("assets/music/BossLoop.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/music/music-goes-here.txt", "assets/music/music-goes-here.txt");
			type.set ("assets/music/music-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/music/Theme-1H.wav", "assets/music/Theme-1H.wav");
			type.set ("assets/music/Theme-1H.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/music/Theme-2H.wav", "assets/music/Theme-2H.wav");
			type.set ("assets/music/Theme-2H.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/music/Theme-3H.wav", "assets/music/Theme-3H.wav");
			type.set ("assets/music/Theme-3H.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/music/Theme-4H.wav", "assets/music/Theme-4H.wav");
			type.set ("assets/music/Theme-4H.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/music/Theme-5H.wav", "assets/music/Theme-5H.wav");
			type.set ("assets/music/Theme-5H.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/sounds-go-here.txt", "assets/sounds/sounds-go-here.txt");
			type.set ("assets/sounds/sounds-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("flixel/sounds/beep.ogg", "flixel/sounds/beep.ogg");
			type.set ("flixel/sounds/beep.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("flixel/sounds/flixel.ogg", "flixel/sounds/flixel.ogg");
			type.set ("flixel/sounds/flixel.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("flixel/fonts/nokiafc22.ttf", "flixel/fonts/nokiafc22.ttf");
			type.set ("flixel/fonts/nokiafc22.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("flixel/fonts/monsterrat.ttf", "flixel/fonts/monsterrat.ttf");
			type.set ("flixel/fonts/monsterrat.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("flixel/images/ui/button.png", "flixel/images/ui/button.png");
			type.set ("flixel/images/ui/button.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("flixel/images/logo/default.png", "flixel/images/logo/default.png");
			type.set ("flixel/images/logo/default.png", Reflect.field (AssetType, "image".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData
