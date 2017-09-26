package;
import flixel.math.FlxRandom;

class MazeGeneration {
  static var M = 10;
  static var N = 10;
  static var grid:Array<Array<Int>> = [for (x in 0...M) [for (y in 0...N) 0]];
  public static var display:Array<Array<Int> > = [for (x in 0...2*M+2) [for (y in 0...2*N+2) 1]];
  static var check:Array<Array<Array<Int> > > = [for (x in 0...M) [for (y in 0...M) [for (z in 0...4) 0 ]]];

  static function dfs(startR:Int, startC:Int, prevR:Int, prevC: Int, dir: Int):Void {
		if(startR<0 || startC<0 || startR>=M || startC>=N || grid[startR][startC]>1
		) {
			return;
		} else {
			grid[startR][startC] = grid[startR][startC] + 1;
			if(prevR!=-1 && prevC!=-1) {
				// if(check)
				check[prevR][prevC][dir] = 1;

				// check.get(prevR).get(prevC).set(dir,1);
			}
		}

		var random = new FlxRandom();
		var rd = [0,1,2,3];
		random.shuffle(rd);

		for(x in 0...4) {
			if(rd[x]==0) {
				//up
				dfs(startR-1,startC,startR,startC,rd[x]);
			} else if(rd[x]==1) {
				//right
				dfs(startR,startC+1,startR,startC,rd[x]);
			} else if(rd[x]==2) {
				//down
				dfs(startR+1,startC,startR,startC,rd[x]);
			} else {
				//left
				dfs(startR,startC-1,startR,startC,rd[x]);
			}
		}
	}

  public static function generateMaze(rows:Int, cols:Int): Array<Array<Int> > {
		M = rows;
		N = cols;
		
    dfs(0,0,-1,-1,0);
    for(i in 0...M) {
      for(j in 0...N) {
        display[2*i+1][2*j+1] = 0;
      }
    }


    for(i in 0...M) {
			for(j in 0...N) {
				if(check[i][j][0]==1) {
					display[2*i+1-1][2*j+1]=0;
				}
			
				if(check[i][j][1]==1) {
					display[2*i+1][2*j+1+1]=0;
				}
			
				if(check[i][j][2]==1) {
					display[2*i+1+1][2*j+1]=0;
				}
			
				if(check[i][j][3]==1) {
					display[2*i+1][2*j+1-1]=0;
				}
			}
		}
    
    return display;
  }

	static function getDistance(i:Int, j:Int, i2:Int, j2:Int):Float {
		return Math.sqrt(Math.pow(i-i2,2)+Math.pow(j-j2,2));
	}

	public static function getCenters(r:Int, c:Int, points:Array<Array<Int> >, numPoints: Int): Array<Int> {
		var centers:Array<Int> = [for (x in 0...numPoints) -1];
		var centerIt = 0;

		var random:FlxRandom = new FlxRandom();
		var rand_point = random.int(0,r*c);
  	centers[centerIt] = rand_point;
		centerIt++;

	  var max_distance = 0.0;
  	var max_index = 0;

		// return centers;
		//calc euclidean distance for each point
		for(i in 0...r*c) {
    	if(i==rand_point) continue;
  	 	var current_distance:Float = getDistance(points[rand_point][0],points[rand_point][1],points[i][0],points[i][1]);
    	if(current_distance>max_distance){
      	max_distance = current_distance;
      	max_index = i;
    	}
  	}

		centers[centerIt] = max_index;
		centerIt++;

		while(centerIt<numPoints) {
			var max_point = 0.0;
    	var max_point_index = 0;

			for(i in 0...r*c){
				var moveon = false;
				for(j in 0...centerIt){
        	if(i==centers[j]) moveon = true;
      	}

				if(!moveon) {
					var min_distances:Array<Float> = [for (j in 0...centerIt) 1.0];
					var min_indicies:Array<Int> = [for (j in 0...centerIt) 0];	

					for(j in 0...centerIt) {
          	var current_distance = getDistance(points[centers[j]][0],points[centers[j]][1],points[i][0],points[i][1]);
          	min_distances[j] = current_distance;
					}
					var max_min = min_distances[0];
					for(k in 1...centerIt) {
						if(min_distances[k]<max_min) {
							max_min = min_distances[k];
						}
					}

					for(k in 0...centerIt){
						if(min_distances[k]==max_min){
							if(max_min>max_point){
								max_point = max_min;
								max_point_index = i;
							}
							break;
						}
        	}
				}
			}
			centers[centerIt] = max_point_index;
			centerIt++;
		}
		return centers;
	}


	static function getOp(i:Int):Int {
  	if(i==0) return 2;
  	if(i==1) return 3;
  	if(i==2) return 0;
  	if(i==3) return 1;
  	return 4;
	}

	// 2 = heart
	// 3 = enemy
	static function isvalid(display:Array<Array<Int> >,i:Int, j:Int):Bool {
  	if(i<=0 || j<=0 || i>=2*M-1 || j>=2*N-1) return false;
  	if(display[i][j]==1 ) return false;
  	return true;
	}

	public static function generatePath(display:Array<Array<Int> >, row:Int, col:Int, numPoints:Int):Array<Int> {
		var path:Array<Int> = [for (i in 0...numPoints) 0];
		var pathIt = 0;
		
		var prev = -1;
  	var prevdir = -1;
  	var valid = true;

	  var r = row;
  	var c = col;
		for(x in 0...numPoints) {
			var random = new FlxRandom();
			var rd = [0,1,2,3];
			random.shuffle(rd);

			var chosen = -1;
    	for(i in 0...4) {
      	if(rd[i]==0 && isvalid(display,r-1,c)  && (rd[i]!=getOp(prevdir))) {
        	chosen = 0;
        	// break;
      	} else if(rd[i]==1 && isvalid(display,r,c+1) && (rd[i]!=getOp(prevdir))) {
        	chosen = 1;
        	// break;
      	} else if(rd[i]==2 && isvalid(display,r+1,c) && (rd[i]!=getOp(prevdir))) {
        	chosen = 2;
        	// break;
      	} else if(rd[i]==3 && isvalid(display,r,c-1) && (rd[i]!=getOp(prevdir))) {
        	chosen = 3;
        	// break;
      	}
    	}

			if(chosen==-1) {
      	chosen = getOp(prevdir);
    	}

    	if(chosen == 0) {
      	path[pathIt] = 0;
				pathIt++;
      	--r;
    	} else if(chosen == 1) {
      	path[pathIt] = 1;
				pathIt++;
      	++c;
    	} else if(chosen == 2) {
      	path[pathIt] = 2;
				pathIt++;
      	++r;
    	} else if(chosen == 3) {
      	path[pathIt] = 3;
				pathIt++;
      	--c;
    	}
    	prevdir = chosen;
		}
		return path;
	}



  static function main() {
  }
}
