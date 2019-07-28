
#define RED_PIN     3
#define BLUE_PIN    5
#define GREEN_PIN   6

#define NUM_BYTES   3

char led_color[NUM_BYTES] = {0, };
unsigned char R, G, B;

void RGB(unsigned char r, unsigned char g, unsigned char b) {
  analogWrite(RED_PIN, r); 
  analogWrite(BLUE_PIN, b); 
  analogWrite(GREEN_PIN, g);
}

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly: 
    
    while(Serial.available() == 0);
    Serial.readBytes(led_color, NUM_BYTES);

    R = (unsigned char)(led_color[0]);
    G = (unsigned char)(led_color[1]);
    B = (unsigned char)(led_color[2]);
    
    RGB(R, G, B);

  
}