/*
    Author: Alexandre Skipper
    Date: November 2017
*/

import java.util.ArrayList;
import java.io.FileReader; 
import java.io.BufferedReader; 
import java.io.FileNotFoundException;
import java.io.IOException;

//Window params
int[] screen = { 1080, 1080 };
float screenX, screenY;
int sensitivity = 50;

//some global variables
Ring ring;
int robots, nodes, speed, delay; //robot and node counts, robot speed, delay between frames
boolean runGUI = false;
ArrayList< ArrayList<Integer> > testCases;

//initial screen settings
void settings() {
    size(screen[0], screen[1]);
}

//setup the simulation
void setup() {
    screenX = screen[0]/2;
    screenY = screen[1]/2;
    frameRate(30);

    delay = 250;
    robots = 3;
    nodes = 15;
    speed = 1;
    ring = new Ring(robots, nodes, speed);

    readConfig();
}

//read test cases and settings from config file
void readConfig() {
    BufferedReader br = null;
    try {
        br = new BufferedReader(new FileReader(new File(sketchPath("config.cfg"))));
        String line = br.readLine();
        runGUI = Integer.parseInt(line) == 0 ? false : true;

        testCases = new ArrayList< ArrayList<Integer> >();
        line = br.readLine();
        while (line != null) {
            ArrayList<Integer> testCase = new ArrayList<Integer>();
            for (String i : line.split(","))
                testCase.add(Integer.parseInt(i));
            testCases.add(testCase);
            
            line = br.readLine();
        }
    } catch (FileNotFoundException e) {
        super.exit();
    } catch (IOException e) {
        super.exit();
    }
}

//main program loop
void draw() {
    if (runGUI) {
        delay(delay);
        background(255);

        ring.updateRobotPositions(); //move robots

        drawRing(ring);
        drawGUI();

        textAlign(LEFT, TOP);
        ring.updateRobotList(); //check for collisions and merge robots
    } else {
        runTestCases();
    }
}

//run test cases without the GUI
void runTestCases() {
    for (int i=0; i<testCases.size(); i++) {
        Log log = new Log(testCases.get(i).get(0), testCases.get(i).get(1), testCases.get(i).get(2));

        for (int j=0; j<testCases.get(i).get(3); j++) {
            ring = new Ring(testCases.get(i).get(0), testCases.get(i).get(1), testCases.get(i).get(2));
            ring.runTest();
            log.addEntry(str(ring.getIterations()));
        }

        log.saveToFile();
    }
    super.exit();
}

//draw the UI
void drawGUI() {
    textSize(32);
    textAlign(CENTER);
    text("Delay (F-, R+): " + str(delay), screen[0]/2, screen[1]/2 - 128);
    text("Robots (A-, Q+): " + str(robots), screen[0]/2, screen[1]/2 - 64);
    text("Nodes (S-, W+): " + str(nodes), screen[0]/2, screen[1]/2);
    text("Speed (D-, E+): " + str(speed), screen[0]/2, screen[1]/2 + 64);
    text("Enter to create a new ring", screen[0]/2, screen[1]/2 + 128);
    textAlign(LEFT, TOP);
    text("Iterations: " + str(ring.getIterations()), 5, 5);
}

//draw the ring (nodes & robots)
void drawRing(Ring r) {
    pushMatrix();
    translate(screenX, screenY);
    r.draw();
    popMatrix();
}

//check for user input
void keyPressed() {
    final int k = keyCode;

    if (k == 'A' && robots > 1) robots -= 1;
    if (k == 'Q') robots += 1;
    if (k == 'S' && nodes > 1) nodes -= 1;
    if (k == 'W') nodes += 1;
    if (k == 'D' && speed > 1) speed -= 1;
    if (k == 'E') speed += 1;
    if (k == 'F' && delay >= 10) delay -= 10;
    if (k == 'R') delay += 10;

    if (k == ENTER) ring = new Ring(robots, nodes, speed);
}