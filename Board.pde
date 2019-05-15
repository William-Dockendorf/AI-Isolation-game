class Board {
  boolean steppedOn[][] = new boolean[7][7];  //this array holds all the tiles that have been stepped on by a knight in the current game.
  Knight knight1 = new Knight();
  Knight knight2 = new Knight();
  int whoAI = -1; // 1 for knight1 and 2 for knight2
  int tempx, tempy;
  boolean isBoardMade;
  boolean isOver;
  
  //This variable is our weights for each space on the board.
  int[][] weights = {
      {-10, -7, -7, -7, -7, -7, -10}, 
      {-7, 0, 5, 5, 5, 0, -7}, 
      {-7, 5, 7, 7, 7, 5, -7}, 
      {-7, 5, 7, 10, 7, 5, -7}, 
      {-7, 5, 7, 7, 7, 5, -7}, 
      {-7, 0, 5, 5, 5, 0, -7}, 
      {-10, -7, -7, -7, -7, -7, -10}
  };
  
  /**
  *    This is the board initializer, it sets all the the stepped on tiles to be
  *    set to false, and setting the game over flag to false as well.
  **/
  Board() {
    for(int j = 0; j < 7; j++) {
      for(int h = 0; h < 7; h++) {
        steppedOn[j][h] = false;
      }
    }
    
    isOver = false;
  }


  /**
  *    another initialized form for board,  and just initialize the steppedOn array, sets the isOver flag to false, and places the knights at a location (like an initial start position)
  *    @param _steppedOn this parameter is a 2D boolean type array that represents the board tiles, and the value determines if that tiles has been stepped on or not
  *    @param _oneX This is the starting x board position for the first knight to be placed
  *    @param _oneY This is the starting y board position for the first kinght to be placed
  *    @param _twox This is the starting x board position for the second knight to be placed
  *    @param _twoy This is the starting y board position for the second knight to be placed
  **/
  Board(boolean[][] _steppedOn, int _oneX, int _oneY, int _twoX, int _twoY) {
    steppedOn = _steppedOn;
    
    knight1.knightX = _oneX;
    knight1.knightY = _oneY;
    knight2.knightX = _twoX;
    knight2.knightY = _twoY;
    
    isOver = false;
  } 
  
  /**
  *  This array returns a copy of the stepped on array, which will be used for the minimax and node classes
  *  @return cpy_array this is a 2D boolean array that has flags for each tile that will be set to true if that tile is in the knights move space, this array is just a copy of the actual array
  **/
  boolean[][] getSteppedOn() {
    boolean cpy_array[][] = new boolean[7][7];
    arrayCopy(steppedOn, cpy_array);
    return cpy_array; 
  }
 
 
 
  /**
  *    This method produces the board background for the game.
  *
  **/
  void makeBoard()
  {
    float k = 0;
    for(int i = 0; i < 50; i++) //for each tile (since there are 49 tiles on the board)
    {
        k = i;
        if((k%2)==0) //this is checking for every other tile, since every other tile is white
        {
            
            tempx = (i%7);
            tempy = (i/7);
            fill(255);
            rect((130*tempx), (130*tempy), 130, 130);  ///creating a white square that will be a tile
        }
    }
    isBoardMade = true;    ///changing the flag to true since the board is now made.
  }
  
  
  /**
  *    This method checks if the game is over, it does this by checking the available move space for both players
  *    If there is not available moves in one of the users move space, then they are made the loosers of the game
  *    @return winner this is an integer that holds which player is the winner (1 or 2)
  **/
  int checkOver() {
    int winner = -1;
    knight1.setAvailForKnight();  //creating the available move space for knight1
    knight2.setAvailForKnight();  //creating the available move space for knight2
    int totalAvalK1 = 0;
    int totalAvalK2 = 0;
    
    for(int i = 0; i < 8; i++) {  ///checking the available move flags in the movespace array for knight1
      if(knight1.avail[2][i] == 1) {  ///if the flag is set to 1 (for true)
        totalAvalK1++;  ///increase to total moves available for knight1 by 1
      }
    }
    
    for(int i = 0; i < 8; i++) {  ///checking all available move flags in the movespace array for knight2
      if(knight2.avail[2][i] == 1) {  ///if the flag is set to 1 (for true)
        totalAvalK2++;   ///increase the total moves available for knight2 by 1
      }
    }
      ///if the available moves are 0 and it was just their turn, that player looses, and the winner is set to the opposing player
    if(totalAvalK1 == 0 && whoseTurn == 1) {
      winner = 2;
    } else if(totalAvalK2 == 0 && whoseTurn == 2) {
      winner = 1;
    }
    
    return winner;
  }

  /// Centerx   Centery  are temp variables that holds the knights locations
  /** This Is The Initial Grid Set-Up That We Are Checking Around The Kight.
      0  1  2  3  4  <- X coordinate
  0 [ ][X][ ][X][ ]
  1 [X][ ][ ][ ][X]       X = Spots we are checking, if the knight can move there or not.
  2 [ ][ ][&][ ][ ]       &= Knight
  3 [X][ ][ ][ ][X]
  4 [ ][X][ ][X][ ]
  ^
  |- Y coordinate


  How this is numbered: ///////////////////////////////////////////////////////////////////////////////////////////////////////

      0  1  2  3  4  <- X coordinate
  0 [ ][0][ ][1][ ]
  1 [2][ ][ ][ ][3]       X = Spots we are checking, if the knight can move there or not.
  2 [ ][ ][&][ ][ ]       &= Knight
  3 [4][ ][ ][ ][5]
  4 [ ][6][ ][7][ ]
  ^
  |- Y coordinate


  When we are checking the move space, if we pass the if statements, we store it in the 'avail' array
  avail[R][T]  T = the tile number (look above for refrence to each tile's index)
              R = The section where the X, Y, and Available int is stored
                    0 = X tile value on the board
                    1 = Y tile value on the board
                    2 = Availabule int value ( 0 = not available  1 = available)
  **/
  
  /**
  *  prints all of the knights available move space onto the GUI
  *  @param knight This is the users knight object, and it uses it to find the knights location, and displays all possible moves they can make this turn on the GUI
  **/
  void printAvalBoxes(Knight knight)
  {
    int tilex, tiley;
    Knight newKnight = knight;
    tilex = newKnight.knightX;
    tiley = newKnight.knightY;
      
    if((tilex - 2) >= 0)
    {
      if((tiley - 1) >= 0 && !steppedOn[tilex-2][tiley-1])
      {
          fill(64, 231, 60);
          rect(((tilex-2)*130),((tiley-1)*130), 130, 130);
          knight.avail[0][2] = (tilex-2); 
          knight.avail[1][2] = (tiley-1);
          knight.avail[2][2] = 1;
      }
      if((tiley + 1) <= 6 && !steppedOn[tilex -2][tiley + 1])
      {
        fill(64, 231, 60);
        rect(((tilex-2)*130),((tiley+1)*130), 130, 130);
        knight.avail[0][4] = (tilex-2); 
        knight.avail[1][4] = (tiley+1);
        knight.avail[2][4] = 1;
      }
    }


    if((tilex - 1) >= 0)
    {
       if((tiley - 2) >= 0 && !steppedOn[tilex-1][tiley-2])
       {
           fill(64, 231, 60);
           rect(((tilex-1)*130),((tiley-2)*130),130,130);
           knight.avail[0][0] = (tilex-1); 
           knight.avail[1][0] = (tiley-2);
           knight.avail[2][0] = 1;
       }
       if((tiley + 2) <= 6 && !steppedOn[tilex -1][tiley + 2])
       {
         fill(64, 231, 60);
         rect(((tilex-1)*130),((tiley+2)*130), 130, 130);
         knight.avail[0][6] = (tilex-1); 
         knight.avail[1][6] = (tiley+2);
         knight.avail[2][6] = 1;
       }
    }

    if((tilex + 2) <= 6)
    {
       if((tiley - 1) >= 0 && !steppedOn[tilex+2][tiley-1])
       {
           fill(64, 231, 60);
           rect(((tilex+2)*130),((tiley-1)*130), 130, 130);
           knight.avail[0][3] = (tilex+2); 
           knight.avail[1][3] = (tiley-1);
           knight.avail[2][3] = 1;
       }
       if((tiley + 1) <= 6 && !steppedOn[tilex +2][tiley + 1])
       {
         fill(64, 231, 60);
         rect(((tilex+2)*130),((tiley+1)*130), 130, 130);
         knight.avail[0][5] = (tilex+2); 
         knight.avail[1][5] = (tiley+1);
         knight.avail[2][5] = 1;
       }
    }

    if((tilex + 1) <= 6)
    {
       if((tiley - 2) >= 0 && !steppedOn[tilex+1][tiley-2])
       {
           fill(64, 231, 60);
           rect(((tilex+1)*130),((tiley-2)*130),130,130);
           knight.avail[0][1] = (tilex+1); 
           knight.avail[1][1] = (tiley-2);
           knight.avail[2][1] = 1;
       }
       if((tiley + 2) <= 6 && !steppedOn[tilex +1][tiley + 2])
       {
         fill(64, 231, 60);
         rect(((tilex+1)*130),((tiley+2)*130), 130, 130);
         knight.avail[0][7] = (tilex+1); 
         knight.avail[1][7] = (tiley+2);
         knight.avail[2][7] = 1;
       }
     }
  }
}
