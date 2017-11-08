import java.util.*;

//Window params
int[] screen = { 1080, 1080 };
float screenX, screenY;
int sensitivity = 50;

Ring ring;

//initial screen settings
void settings() {
    size(screen[0], screen[1]);
}

//setup the game
void setup() {
    screenX = screen[0]/2;
    screenY = screen[1]/2;
    frameRate(30);

    ring = new Ring(42, 111, 1);
}

void draw() {
    ring.update();
    //delay(100);
    background(255);

    drawRing(ring);
}

void drawRing(Ring r) {
    pushMatrix();
    translate(screenX, screenY);
    r.draw();
    popMatrix();
}

void keyPressed() {
    if (key == CODED) {
        if (keyCode == UP) {
            screenY += sensitivity;
        } else if (keyCode == DOWN) {
            screenY -= sensitivity;
        } else if (keyCode == RIGHT) {
            screenX -= sensitivity;
        } else if (keyCode == LEFT) {
            screenX += sensitivity;
        }
    }
}