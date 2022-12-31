int pinHall[] = {3, 4, 8}; // {Hall_U, Hall_V, Hall_W}
int pinHS[] = {9, 10, 11}; // {H1, H2, H3} 
int pinLS[] = {5, 6, 7}; // {L1, L2, L3}

const int ind_0 = 10;
const int ind_1 = 11;
const int ind_2 = 12;

byte dataHall[3] = {0};

#define high 111
#define low  112

const int pedal = A0;
unsigned int dataPedal = 0; 
byte kecepatan = 0;
const int temp = A1;
const int current = A2;
const int voltage = A3;
const int batt = A4;
unsigned long tOut = 0, battOut = 0;
float tempOut, currentOut, voltageOut;
unsigned long currentMillis = 0, prevMillis = 0;
unsigned int hallStep = 0;
 
int stateButton1 = low;
int stateButton2 = low;
bool stateSistem = true;

void setup() {
  Serial.begin(9600);
  pinMode(pedal, INPUT);
  attachInterrupt(0, count, CHANGE);

  for(int i=0; i<3; i++){
      pinMode(pinHall[i], INPUT);
    }
  for(int i=0; i<3; i++){
      pinMode(pinLS[i], OUTPUT);
    }   
}


void loop() {
  // put your main code here, to run repeatedly:
  //SET TIMER DALAM MILLISECONDS
  currentMillis = millis();
  updateTimer();
  bacaHall();
  bacaPedal();
  kecepatan = map(dataPedal, 190, 865, 0, 255);
  battOut = map(analogRead(batt), 0, 1023, 0, 100);
  tempOut = analogRead(temp)*40.0/1023.0;
  currentOut = analogRead(current)*10.0/1023.0;
  voltageOut = analogRead(voltage)*48.0/1023.0;

  //Serial.println((String)dataHall[0]+"  "+(String)dataHall[1]+"  "+(String)dataHall[2]);
  Serial.println((String)stateButton1+" "+ (String)stateButton2 +" "+(String)kecepatan+" "+(String)tempOut+" "+(String)currentOut+" "+(String)voltageOut+" "+(String)battOut);
  //Serial.println((String)dataPedal+ "  " +  (String)kecepatan+ "  " + (String)tOut+ "  " + (String)hallStep);
  
  // Six Step Commutation and PWM:
  if(stateSistem == true){
    if     (dataHall[0] == 1 && dataHall[1] == 0 && dataHall[2] == 1){triggerMosfet(kecepatan, 0, 0, 0, 1, 0);} 
    else if(dataHall[0] == 1 && dataHall[1] == 0 && dataHall[2] == 0){triggerMosfet(kecepatan, 0, 0, 0, 0, 1);} 
    else if(dataHall[0] == 1 && dataHall[1] == 1 && dataHall[2] == 0){triggerMosfet(0, kecepatan, 0, 0, 0, 1);} 
    else if(dataHall[0] == 0 && dataHall[1] == 1 && dataHall[2] == 0){triggerMosfet(0, kecepatan, 0, 1, 0, 0);}
    else if(dataHall[0] == 0 && dataHall[1] == 1 && dataHall[2] == 1){triggerMosfet(0, 0, kecepatan, 1, 0, 0);}
    else if(dataHall[0] == 0 && dataHall[1] == 0 && dataHall[2] == 1){triggerMosfet(0, 0, kecepatan, 0, 1, 0);}
    }
}


void triggerMosfet(byte H1, byte H2, byte H3, bool L1, bool L2, bool L3){
  byte logicHS[] = {H1, H2, H3};
  bool logicLS[] = {L1, L2, L3};
  for(int i=0; i<3; i++){
      analogWrite(pinHS[i], logicHS[i]);
    }
  for(int i=0; i<3; i++){
      digitalWrite(pinLS[i], logicLS[i]);
    }
  }

void bacaHall(){
  for(int i=0; i<3; i++){
      dataHall[i] = digitalRead(pinHall[i]);
    }
  }

void count(){
  hallStep ++;
  }

void updateTimer(){
  if(hallStep >= 10){
    tOut = currentMillis - prevMillis;
    prevMillis = currentMillis;
    hallStep = 0;
    }

  if(currentMillis - prevMillis >= 6000){
    tOut = 0;
    prevMillis = currentMillis;
    hallStep = 0;
    }
  }

void bacaPedal(){
  dataPedal = analogRead(pedal);
  if(dataPedal <= 190){dataPedal = 190;}
  else if(dataPedal >= 865){dataPedal = 865;}
  }