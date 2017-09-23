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

  static function main() {
  }
}
