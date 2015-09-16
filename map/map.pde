PImage mapImage;
PFont font;
Table locationTable;
Table dataTable;
Table nameTable;
int rowCount;
float dataMin = MAX_FLOAT;
float dataMax = MIN_FLOAT;
float value = 0;
String name = "";
float radius = 0;

void setup() {
  size(640, 400);
  mapImage = loadImage("map.png");
  locationTable = loadTable("locations.tsv");
  nameTable = loadTable("names.tsv");
  font = loadFont("Vani-Bold-20.vlw");

  rowCount = locationTable.getRowCount();
  textFont(font);

  //read data table
  dataTable = loadTable("random.tsv");
  for (int row=0; row < rowCount; row++) {
    float value = dataTable.getFloat(row, 1);
    if ( value < dataMin) {
      dataMin = value;
    }
    if (value > dataMax) {
      dataMax = value;
    }
  }
}

void draw() {
  background(255);
  image(mapImage, 0, 0);
  //attr for ellipse
  smooth();
  fill(192, 0, 0);
  noStroke();

  for (int row=0; row < rowCount; row++) {
    String abbrev = dataTable.getString(row, 0);
    float x = locationTable.getFloat(row, 1);
    float y = locationTable.getFloat(row, 2);
    drawData(x, y, abbrev);
    textHover(x,y);
  }
}

void drawData(float x, float y, String abbrev) {
  //get data val for state
  for (int row=0; row < rowCount; row++) {
    if (dataTable.getString(row, 0).equals(abbrev)) {
      value = dataTable.getFloat(row, 1);
    }
  }
  for (int row=0; row < rowCount; row++) {
       name = nameTable.getString(row, 1);
  }
  if (value >= 0) {
    radius = map(value, 0, dataMax, 1.5, 15);
    fill(#4422CC);
  } else {
    radius = map(value, 0, dataMin, 1.5, 15);
    fill(#FF4422);
  }
  //float mapped = map(value,dataMin,dataMax,2,40);
  ellipseMode(RADIUS);
  ellipse(x, y, radius, radius);
}

void textHover(float x, float y){
    if (dist(x, y, mouseX, mouseY) < radius+2) {
    fill(0);
    textAlign(CENTER);
    text(name +"("+ value +")", x, y-radius-4);
  }
}