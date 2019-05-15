// This node class is a abstract represantation of a board
class Node {
    Board nodeState;
    int value;
    ArrayList<Node> children = new ArrayList<Node>();

    Node(Board _board) {
      value = 0;
      nodeState = new Board(_board.getSteppedOn(), _board.knight1.knightX, _board.knight1.knightY, _board.knight2.knightX, _board.knight2.knightY);
    }
    
    /**
    *  This method generates the children of the node being passed in. It does this by generating a new board object but it changes it by taking a possible move, and stores that
    *  into the child. So the children are just all the available moves that can be taken by current player, stores that state into a node object, and stores that into an array list of
    *  type node, that is being held by the current node. 
    *  @param currentKnight a knight object, that is the objects of the current knight that we are going to make children of all its possible moves.
    *  @param knightNo an integer that tells if its player 1's turn or if its player 2's trun.
    **/
    void makeChildren(Knight currentKnight, int knightNo) {
      Board newState = new Board(nodeState.getSteppedOn(), nodeState.knight1.knightX, nodeState.knight1.knightY, nodeState.knight2.knightX, nodeState.knight2.knightY);
      currentKnight.setAvailForKnight();
      int[][] cur_availSpots = currentKnight.avail;
      
      
      ///Checking all available moves spaces and creating a child node that will take in the new board state that now has the new move made.
      for(int i = 0; i < 8; i++) {
        if(cur_availSpots[2][i] == 1) {
           int newX = cur_availSpots[0][i];
           int newY = cur_availSpots[1][i];
           
           if(knightNo == 1) {
             ///println("Child for knight1 created!");
             newState.knight1.knightX = newX;
             newState.knight1.knightY = newY;
             children.add(new Node(newState));
           } else {
             ///println("Child for knight2 created!");
             newState.knight2.knightX = newX;
             newState.knight2.knightY = newY;
             children.add(new Node(newState));
           }
        }
      }
    }
    
    /**
    *  This method calculates the knights score based on the number of available moves, and the weighted values of the board.
    *  @param numOfAval this is an integer value that holds the number of available moves of the knight
    *  @param x an integer value that holds the x coordinate of the tile to be evaluated
    *  @param y an integer value that holds the y coordinate of the tile to be evaluated
    *  @return: score an integer value that is the combined values of the weighted values of available moves, and the weighted values of the tile/board position.
    **/
    private int calcKnightScore(int numOfAval, int x, int y) {
      int score = 0;
      
      score = numOfAval * 10;
      score += board.weights[x][y];
      
      return score;
    }
    
    
    /**
    *  This method evaluates both knights current values, and depending on who is the AI we subtract the opposing players knight score from the AI's knight score.
    *  @return value an integer value that holds the value diffrence between the AI's kngiht score, and the humans (or opponents) knight score.
    **/
    public int evaluate()
    {
        int numOfAval1 = nodeState.knight1.getNumOfAvail();
        int numOfAval2 = nodeState.knight2.getNumOfAvail();
        
        /// Calculate knight 1's score
        int knight1Score = calcKnightScore(numOfAval1, nodeState.knight1.knightX, nodeState.knight1.knightY);
        
        /// Calculate knight 2's score
        int knight2Score = calcKnightScore(numOfAval2, nodeState.knight2.knightX, nodeState.knight2.knightY);
       
        
        if(nodeState.whoAI == 1) {
          value = knight1Score - knight2Score;
        } else {
          value = knight2Score - knight1Score; 
        }
        

        return value;
    }
}
