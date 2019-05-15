/**
*  This class performs the minimax functions for the AI to decide its move, and make it.
**/
class Minimax {
  ArrayList<Integer> allValues = new ArrayList<Integer>();
  ArrayList<Node> allNodes = new ArrayList<Node>();

  Minimax() {}
   
   /**
   *  This method finds the most optimal move based on the values pulled from the minimax method
   *  it holds the level one nodes of the minimax tree in the array
   *  @param state a board class object that is the current state of the board, such as player placements and stepped on tiles etc.
   *  @return bestCoordinates this is an integer array that holds the x and y coordinates of the tile that is the most optimal move.
   **/
  int[] optimal(Board state) {

      Node node = new Node(state);
      
      minimax(node, 2, true);

      int indexOfTheMove = findLargestIndex(allValues);
      Node theMove = allNodes.get(indexOfTheMove);

      int bestCoordinates[] = new int[2];
      if(board.whoAI == 1) {
        bestCoordinates[0] = theMove.nodeState.knight1.knightX;
        bestCoordinates[1] = theMove.nodeState.knight1.knightY;
      } else {
        bestCoordinates[0] = theMove.nodeState.knight2.knightX;
        bestCoordinates[1] = theMove.nodeState.knight2.knightY;
      }
      
      
      allNodes.clear();
      allValues.clear();
      println("Best Coor: " + bestCoordinates[0] + " " + bestCoordinates[1]);
      return bestCoordinates;
  }
  
  
  /**
  *  This method is the minimax itself, where it generates a tree, each level is all the possiblities of moves from the previous level, gives a value to each one
  *  and when it works up the tree, it takes the best valued one, until we hit the level one nodes, and returns all the level one nodes (to the optimal method)
  *  This method takes use of recursion.
  *  @param _node this is a node type object that holds children and has a score given to it.
  *  @param depth an integer of the curent depth of the tree (we start from the bottom and work up)
  *  @param maximizingPlayer a boolean that checks if we are maximizing the players values, or the ais values, this is dependent on what level your are in on the tree, if this value is true, we take the max value of the nodes children, if its false we take the minimum value of the nodes children.
  *  @return value an integer value that holds the value of the level one node from the tree.
  **/
  int minimax(Node _node, int depth, boolean maximizingPlayer) {
       println("=======DEPTH: " + depth);
       if(depth == 0) {
          allNodes.add(_node);
          int return_value = _node.evaluate();
          allValues.add(return_value);
          return return_value;
       }
       
       if (maximizingPlayer) {
         int value = Integer.MIN_VALUE;
         //println("MAXIMIZING FOR AI");
         _node.makeChildren(_node.nodeState.knight2, 2);
         ArrayList<Node> children = _node.children;
         
         for(int i = 0; i < children.size(); i++) {
            int eval = minimax(children.get(i), depth - 1, false);
            value = max(value, eval);
         }
         
         return value;
       } else {
         int value = Integer.MAX_VALUE;
         //println("MINIMIZING FOR USER");
         _node.makeChildren(_node.nodeState.knight1, 1);
         ArrayList<Node> children = _node.children;
         
         for(int i = 0; i < children.size(); i++) {
           int eval = minimax(children.get(i), depth - 1, true);
           value = min(value, eval);
         }
         
         return value;
       }
  }
  
  
  /**
  *  This method finds the index value of the largest value from the passed in array. Its used for finding the greatest value of the level one nodes
  *  @param arr an integer array list
  *  @return index this is an integer value that holds the index value of the greatest value in arr.
  **/
  int findLargestIndex(ArrayList<Integer> arr) {
      int max = arr.get(0);
      int index = 0;

      for (int i = 0; i < arr.size(); i++) 
      {
          if (max < arr.get(i))
          {
              max = arr.get(i);
              index = i;
          }
      }
      
      return index;
  }
}
