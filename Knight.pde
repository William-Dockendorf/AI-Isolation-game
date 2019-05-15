class Knight {
  int knightX = -1;
  int knightY = -1;
  int avail[][] = new int[3][8];
  int count;
  
  
  /**
  *  Initialiaze the available move space for the knight
  *
  **/
  Knight() {
    count = 0;
    // This loop just initializes the array and fills it with 0's
    for(int i = 0; i < 3; i++)  //looping through the x and y coordinates of the array
    {
      for(int k = 0; k < 8; k++)  //looping through all the possible moves that the knight can take (a knight has a maximum of 8 possible moves)
      {
        avail[i][k] = 0;    //Setting them all to 0
      }
    }
  }
  
  /**
  *  This displays the knight to the GUI.
  *  @param r red color value
  *  @param g green color value
  *  @param b blue color value
  *  @return true once the knight has been displayed
  **/
  boolean printKnight(int r, int g, int b)
  {
    int centerx, centery;
    centerx = (knightX * 130) + 65;
    centery = (knightY * 130) + 65;
    fill(r, g, b);
    ellipse(centerx, centery, 65, 65);
    
    return true;
  }
  
  /**
  *  This is to move the knight.
  *  @param mx mouse x coordinate
  *  @param my mouse y coordiante
  *  @return knightMoved a boolean value that returns true if the knight has been moved
  **/
  boolean moveKnight(int mx, int my) {
    boolean knightMoved = false;
    for(int i = 0; i < 8; i++)  ///checking each possible move a night can take (since a knight has a max of 8 possible moves)
    {
      if(avail[2][i] == 1)  ///if the flag of that tile is 1 (for true)
      {
        count++;  ///increase the count of possible moves
        if((((avail[0][i] * 130) + 130) > mx && mx >= (avail[0][i] * 130)) &&  //this checks if the user clicked on a tile that is in
           ((avail[1][i] * 130) + 130) > my && my >= (avail[1][i] * 130))      //the available move space
        {
          knightX = avail[0][i];  ///changing the knights x coordinate to the clicked tile location
          knightY = avail[1][i];  ///changing the knights y coordinate to the clicked tile location
          board.steppedOn[avail[0][i]][avail[1][i]] = true;  ///setting the tile the knight JUST MOVED TO as a stepped on tile (rendering it as an unavailable space for the rest of the game)
          
          knightMoved = true;  ///updating the flag that the knight as moved.
        }
      }
    }
    
    if(count == 0){ ///if there are no moves, its game over
      board.isOver = true;
    }
      ///this is updating the available move space for the knights since the knight has moved, the move space has changed for one or possibly both.
    for(int i = 0; i < 3; i++) {  
        for(int k = 0; k < 8; k++) {
          avail[i][k] = 0;
        }
    } 
    
    return knightMoved;
  }
  
  
  ///This diagram is for the setAvailForKight method
  
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
  *  This checks for all available move spaces for the knight.
  *
  **/
  void setAvailForKnight() {
    
    int tilex, tiley;
    tilex = knightX;
    tiley = knightY;
      
    if((tilex - 2) >= 0)
    {
      if((tiley - 1) >= 0 && !board.steppedOn[tilex-2][tiley-1])
      {
          avail[0][2] = (tilex-2); 
          avail[1][2] = (tiley-1);
          avail[2][2] = 1;
      }
      if((tiley + 1) <= 6 && !board.steppedOn[tilex -2][tiley + 1])
      {
        avail[0][4] = (tilex-2); 
        avail[1][4] = (tiley+1);
        avail[2][4] = 1;
      }
    }


    if((tilex - 1) >= 0)
    {
       if((tiley - 2) >= 0 && !board.steppedOn[tilex-1][tiley-2])
       {
           avail[0][0] = (tilex-1); 
           avail[1][0] = (tiley-2);
           avail[2][0] = 1;
       }
       if((tiley + 2) <= 6 && !board.steppedOn[tilex -1][tiley + 2])
       {
         avail[0][6] = (tilex-1); 
         avail[1][6] = (tiley+2);
         avail[2][6] = 1;
       }
    }

    if((tilex + 2) <= 6)
    {
       if((tiley - 1) >= 0 && !board.steppedOn[tilex+2][tiley-1])
       {
           avail[0][3] = (tilex+2); 
           avail[1][3] = (tiley-1);
           avail[2][3] = 1;
       }
       if((tiley + 1) <= 6 && !board.steppedOn[tilex +2][tiley + 1])
       {
         avail[0][5] = (tilex+2); 
         avail[1][5] = (tiley+1);
         avail[2][5] = 1;
       }
    }

    if((tilex + 1) <= 6)
    {
       if((tiley - 2) >= 0 && !board.steppedOn[tilex+1][tiley-2])
       {
           avail[0][1] = (tilex+1); 
           avail[1][1] = (tiley-2);
           avail[2][1] = 1;
       }
       if((tiley + 2) <= 6 && !board.steppedOn[tilex +1][tiley + 2])
       {
         avail[0][7] = (tilex+1); 
         avail[1][7] = (tiley+2);
         avail[2][7] = 1;
       }
     }
  }
  
  
  /**
  *  This grabs the number of available move spaces for the knight
  *  @return total an integer that holds the number of available moves for the knight
  *
  **/
  int getNumOfAvail() {
    setAvailForKnight();
    int total = 0;
    for(int i = 0; i < 8; i++) {
       if(avail[2][i] == 1) {
         total++;
       }
    }
    
    return total;
  }
}
