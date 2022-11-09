//Used to determine which quadrant the shape lies in
int quadr(float a, float b,float x, float y){
  //a and b values are the current x and y coordinates
  //x and y here present the coordinates of the centre square
  int quadrant = 0; //Set it to 0 
  
  if(a < x){ //If the current x coordinates of the moving squares is smaller than that of the centre square
    if(b < y){ //If it is above the centre square
      quadrant = 1; //The square is in the first quadrant
    }
    else if(b > y){ //If it is below the centre square
      quadrant = 2; //It is in the second quadrant
    }
  }
  else if(a > x){ //If it is larger than the x coordinates of the centre square
    if(b < y){ //If it is above the centre square
      quadrant = 3; //It is in the third quadrant
    }
    else{ //If it is below the centre square
      quadrant = 4; //It is in the fourth quadrant
    }
  }
  
  return quadrant;
  
}

//Used to calculate the distance between a square and the centre square
float dista(float x, float y, float x1, float y1){
  //Finds the horizontal distance
  float xtotal = x1 - x;
  
  //Finds the vertical distance
  float ytotal = y1 - y;
  
  //Finds the distance with the pythagoras theorem
  float distance = sqrt(pow(xtotal,2)+pow(ytotal,2));
  
  return distance;
}

int reduce(float x){
  //Divides the input value by 10 and rounds it
  int y = round(x/10);
  //Multiply that value by 10 before returning it
  int y1 = y*10;
  return y1;
}
