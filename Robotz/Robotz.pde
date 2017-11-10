import java.util.*;

//Window params
int[] screen = { 1080, 1080 };
float screenX, screenY;
int sensitivity = 50;

Ring ring;
int robots, nodes, speed, delay;

//initial screen settings
void settings() {
    size(screen[0], screen[1]);
}

//setup the simulation
void setup() {
    screenX = screen[0]/2;
    screenY = screen[1]/2;
    frameRate(30);

    delay = 500;
    robots = 3;
    nodes = 15;
    speed = 1;
    ring = new Ring(robots, nodes, speed);
}

void draw() {
    delay(delay);
    background(120, 120, 120);

    ring.updateRobotPositions();

    drawRing(ring);
    drawGUI();

    textAlign(LEFT, TOP);
    ring.updateRobotList();
}

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

void drawRing(Ring r) {
    pushMatrix();
    translate(screenX, screenY);
    r.draw();
    popMatrix();
}

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