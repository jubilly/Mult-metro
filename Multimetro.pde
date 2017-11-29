import processing.serial.*;// Importar biblioteca comunicacao serial

Serial Porta;    // Criar objeto do tipo Serial chamado Porta

PImage background,on,off;
boolean ligado = false;
String entrada_String;  // String  de entrada da serial
float tensao=0;
float x=139,y=0;

void setup(){
  size (800,600);
  background = loadImage("fundo.png");
  on = loadImage("on.png");
  off = loadImage("off.png");
  Porta = new Serial(this, "COM3", 9600); // configura a porta que será usada e a velocidade
  Porta.bufferUntil(10); // tamanho do buffer de entrada da serial
  entrada_String = "00000000"; // força a string de entrada como zero, para não ter erro 
  background(background);
}
void serialEvent(Serial port) { // interrupção da porta serial
  entrada_String = port.readString(); // variavel de entrada recebe o buffer da seral
  entrada_String = entrada_String.substring(0, 8); // trunca a variavel de entrada de 10 caracteres para 8
}    

void draw(){
  if (((mouseX > 50-off.width) && (mouseX < 50+off.width)) && ((mouseY > 50-off.height) && (mouseY < 50+off.height))) {
     if(mousePressed){
     ligado = !ligado; // muda estado da variavel as leituras 
     delay(500);
     }  
   }
   if(ligado == true){
     on();
   }else{
     off();
   }
  println(mouseX+" , "+mouseY);
}
void on(){ 
if(x<665){
    image(on,50,50);
    // tranforma o valor da string de entrada em decimal e faz uma multiplicação com (5/(256-1))
    tensao=0.019607843*(unbinary(entrada_String)); 
    fill(185);
    noStroke();
    rect(355, 425, 140, 37);
    fill(255,0,0);
    textSize(40); 
    text(tensao, 355, 455); // escreve na tela a tensão lida
    fill(255, 102, 153);//preenchimento
    y = map(tensao, 5, 0, 80, 233); // determina a escala onde os pontos serão desenhados
    fill(255,0,0);
    stroke(255,0,0);
    strokeWeight(5);// espessura do contorno de 5 pixels    
    point(x,y);//começa a desenha a função no grafico conforme varia o potenciometro
    x++;
    delay(100);
  }else
  {
    background(background);
    image(on,50,50);
    x=185;
  }
}
void off(){
image(off,50,50);
}