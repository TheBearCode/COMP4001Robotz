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

//setup the game
void setup() {
    screenX = screen[0]/2;
    screenY = screen[1]/2;
    frameRate(30);

    delay = 100;
    robots = 3;
    nodes = 15;
    speed = 1;
    ring = new Ring(robots, nodes, speed);
}

void draw() {
    ring.update();
    delay(delay);
    background(255);

    drawRing(ring);

    drawGUI();
}

void drawGUI() {
    textSize(32);
    textAlign(CENTER);
    text("Delay (F, R): " + str(delay), screen[0]/2, screen[1]/2 - 128);
    text("Robots (A, Q): " + str(robots), screen[0]/2, screen[1]/2 - 64);
    text("Nodes (S, W): " + str(nodes), screen[0]/2, screen[1]/2);
    text("Speed (D, E): " + str(speed), screen[0]/2, screen[1]/2 + 64);
    text("Enter to create", screen[0]/2, screen[1]/2 + 128);
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
    if (k == 'F' && delay > 10) delay -= 10;
    if (k == 'R') delay += 10;

    if (k == ENTER) ring = new Ring(robots, nodes, speed);
}