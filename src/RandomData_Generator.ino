float randNumberTDS, randNumberTemp, randNumberCond, randNumberSalt, randNumberDepth, randNumberTurb, randNumberSecchi, randNumberSC, randNumberDC, randNumberPH;
float TDSRef = 500, TempRef = 25., CondRef = 53., SaltRef = 36., DepthRef = 100., TurbRef = 4., SecchiRef = 30., SCRef = 0.57, DCRef = 180., pHRef = 7.;
float TDS, Temp, Cond, Salt, Depth, Turb, Secchi, SC, DC, pH;

String DATA = "";

void setup() {
  Serial.begin(9600);
  unsigned long time = millis();
  randomSeed(time);
}

void loop() {

  randNumberTDS = random(-50, 50);
  randNumberTemp = random(-20, 20) / 10;
  randNumberCond = random(-3, 7);
  randNumberSalt = random(-3, 3);
  randNumberDepth = random(-50, 150);
  randNumberTurb = random(-2, 2);
  randNumberSecchi = random(-7, 4);
  randNumberSC = random(-2, 2) / 10;
  randNumberDC = random(-90, 90);
  randNumberPH = random(-1, 1);
  
  TDS = TDSRef + randNumberTDS;
  Temp = TempRef + randNumberTemp;
  Cond = CondRef + randNumberCond;
  Salt = SaltRef + randNumberSalt;
  Depth = DepthRef + randNumberDepth;
  Turb = TurbRef + randNumberTurb;
  Secchi = SecchiRef + randNumberSecchi;
  SC = SCRef + randNumberSC;
  DC = DCRef + randNumberDC;
  pH = pHRef + randNumberPH;

  DATA = String(TDS, 0)+";"+String(Temp, 1)+";"+String(Cond, 2)+";"+String(Salt, 1)+";"+String(Depth, 1)+";"+String(Turb, 1)+";"+String(Secchi, 1)+";"+String(SC, 1)+";"+String(DC, 1)+";"+String(pH, 1);

  Serial.println(DATA);
  delay(1000);
}
