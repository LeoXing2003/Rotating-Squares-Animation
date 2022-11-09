class Square {

  //Fields
  //Input Values
  float xwidth;
  float yheight;
  float side;
  color sideC;
  color colour;
  int number;

  //Speed Arrays
  float[] xspeed1;
  float[] yspeed1;

  //Coordinates and side length arrays
  float[] xc;
  float[] yc;
  float[] side1;

  //The distance between the first square and the centre square
  float distance;
  
  //Which quadrant the square is in relative to the centre square
  int quadrant;

  //Used to keep track of framerates in each quadrant
  int frame;
  int frame1;
  int frame2;
  int frame3;

  //Constructor
  //Sets all the initial values
  Square(float x, float y, float s, color sc, color c, int n) {
    this.xwidth = x;
    this.yheight = y;
    this.side = s;
    this.sideC = sc;
    this.colour = c;
    this.number = n;

    this.xc = new float[this.number];
    this.yc = new float[this.number];
    this.side1 = new float[this.number];

    this.xspeed1 = new float[this.number];
    this.yspeed1 = new float[this.number];

    //Sets the first item of the arrays to the input values
    //These values are for the centre square
    this.xc[0] = this.xwidth;
    this.yc[0] = this.yheight;
    this.side1[0] = this.side;

    //Set the speed of the centre square(first item in the array) to 0
    this.xspeed1[0] = 0;
    this.yspeed1[0] = 0;

    for (int i = 1; i < this.number; i++) { //Loop starts at the second square          

      //Draws a new rectangle with the values from the arrays
      rect(xc[i], yc[i], side1[i], side1[i]); 

      //Finds the initial distance between the central square and the first square at the corner
      //Used as a control value
      distance = dista(xc[0], yc[0], xc[1], yc[1]);

      //For each consecutive square, its length is divided by 2
      side1[i] = this.side/pow(2, i); 

      //Equation used to determine the location of each consecutive square
      xc[i] = xc[i-1] - (side1[i]/2 + side1[i-1]/2);
      yc[i] = yc[i-1] - (side1[i]/2 + side1[i-1]/2);
    }
  }

  //Draws the squares onto the screen
  void display(int num,int col1, int col2, int col3) { 
    this.number = num;
    this.colour = color(col1,col2,col3);
    fill(this.colour);
    stroke(this.sideC);

    //Draws the centre square with the input values
    rect(xc[0], yc[0], this.side, this.side); 

    //Draws all the smaller squares
    for (int i = 1; i < this.number; i++) {
      rect(this.xc[i], this.yc[i], this.side1[i], this.side1[i]);
    }
  }
  
  //Handles all the calculations and is responsible for updating the values for the square
  void update() {
    quadrant = quadr(xc[1], yc[1], xc[0], yc[0]); //Finds the quadrant     
    rect(xc[0], yc[0], side1[0], side1[0]);  //Centre square

    //Finds the distance between the centre square and the first square at the corner
    float distance1 = dista(xwidth, yheight, xc[1], yc[1]); 

    //Loops through the array
    for (int i =1; i< xc.length; i++) { //The loop start with the first moving square

      if (distance1 == distance) { //If it is at the corner

        if (quadrant == 4) { //At quadrant 4

          if (pause == false) { //Only increments the frames when the game is not paused
            //The frame variable for this quadrant is increased by one
            frame3++;
          }
          //Sets the other frame variables to 0
          frame = 0;
          frame2 = 0;
          frame1 = 0;
          //If the specified number of frames has been reached the square will move to the next corner
          if (frame3 >= (10*this.side + (50*this.number))) {            
            xspeed1[i] = -(this.side/20);            
            yspeed1[i] = 0;
          }
          
          //If the smaller squares are not aligned
          else if ((yc[i] < yc[i-1] + (side1[i]/2 + side1[i-1]/2))) {            
            if (i > 1) {//For all the squares after the first one            
              xspeed1[i] = 0;
              yspeed1[i] = 2;
            }           
            
            //Set the speed of the first and largest square in the corner to 0
            xspeed1[1] = 0;
            yspeed1[1] = 0;
          } 
          else {
            //Sets their speed to 0 after they have been aligned
            xspeed1[i] = 0;
            yspeed1[i] = 0;
          }
        } 
        else if (quadrant == 3) { //Quadrant 3
          //Each quadrant will be using a different frame variable
          if (pause == false) { 
            frame2++;
          }

          frame1 = 0;
          frame = 0;
          frame3 = 0;
          if (frame2 >=  (10*this.side+(50*this.number))) {            
            xspeed1[i] = 0;
            yspeed1[i] = (this.side/20); //The speed of the squares is dependent on its side length
          } 
          else if (xc[i] < (xc[i-1] + (side1[i]/2 + side1[i-1]/2))) {                                                       
            if (i != 1) {
              xspeed1[i] = 2;
              yspeed1[i] = 0;
            }

            xspeed1[1] = 0;
            yspeed1[1] = 0;
          } 
          else {             
            xspeed1[i] = 0;
            yspeed1[i] = 0;
          }
        } 
        else if (quadrant == 2) { //Quadrant 2

          if (pause == false) {
            frame1++;
          }

          frame2 = 0;
          frame = 0;
          frame3 = 0;
          
          //The number of frames set for each quadrant is dependent on the side length and the number of squares
          if (frame1 >=  (10*this.side+ (50*this.number))) {

            xspeed1[i] = 0;
            yspeed1[i] = -(this.side/20);
          } 
          else if (xc[i] > xc[i-1] - (side1[i]/2 + side1[i-1]/2)) {

            if (i != 1) {
              xspeed1[i] = -2;
              yspeed1[i] = 0;
            }
            xspeed1[1] = 0;
            yspeed1[1] = 0;
          } 
          else {
            xspeed1[i] = 0;
            yspeed1[i] = 0;
          }
        } 
        else if (quadrant ==1) {//Quadrant 1

          if (pause == false) {
            frame++;
          }

          frame1 = 0;
          frame3 = 0;
          frame2 = 0;
          if (frame >=  (10*this.side+ (50*this.number))) {
            xspeed1[i] = (this.side/20);
            yspeed1[i] = 0;
          } 
          else if (yc[i] > yc[i-1] - (side1[i]/2 + side1[i-1]/2)) {
            if (i != 1) {
              xspeed1[i] = 0;
              yspeed1[i] = -2;
            }


            xspeed1[1] = 0;
            yspeed1[1] = 0;
          } 
          else {
            xspeed1[i] = 0;
            yspeed1[i] = 0;
          }
        }
      } 

      //The increment statements are called only if the animation is not paused
      if (pause == false) {
        xc[i] += xspeed1[i];
        yc[i] += yspeed1[i];
      }
    }
  }
  
}
