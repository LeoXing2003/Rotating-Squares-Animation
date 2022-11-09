import g4p_controls.*;
boolean pause = false; //Set the initial pause variable to false

color StrokeColor = 255;

//Variables that can be changed through the GUI tab
float xcoord1;
float ycoord1;
float initialSize;
int Colour1;
int Colour2;
int Colour3;
color Colour;
int numberOfSquares;
int initialNumOfSquares;

Square square;


void setup(){
  size(800,800);  
  createGUI();
  rectMode(CENTER); 
  
  //Set the initial values
  
  //Stores the initial number of squares
  initialNumOfSquares = Number_Slider.getValueI(); //Will remain constant to make sure that the range of the arrays is not changed by reset
  numberOfSquares = Number_Slider.getValueI();
    
  xcoord1 = XSlider.getValueI();
  ycoord1 = YSlider.getValueI();
  initialSize = SizeSlider.getValueI();
  Colour1 = ColorSlider.getValueI(); 
  Colour2 = ColorSlider2.getValueI();
  Colour3 = ColorSlider3.getValueI();
  Colour = color(Colour1, Colour2, Colour3);
  
  //Creates Square
  square = new Square(xcoord1,ycoord1,initialSize,StrokeColor,Colour,numberOfSquares);  
}

void draw(){
  background(0);  
  rectMode(CENTER);  
  square.display(numberOfSquares,Colour1,Colour2, Colour3);   
  square.update();  
}

void reset(){
  //Resets the values by creating a new Square object with new values
  square = new Square(xcoord1,ycoord1,initialSize,StrokeColor,Colour,initialNumOfSquares);
}
