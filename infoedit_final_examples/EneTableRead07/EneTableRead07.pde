EneTable ene;
String[] filelist;
int dataNum = 0;
int hour = 0;
PVector[] pos = new PVector[110];
PVector[] vel = new PVector[110];

void setup() {
  // 画面初期化
  size(800, 600);
  noStroke();
  frameRate(30);
  textSize(14);

  for (int i = 0; i < pos.length; i++) {
    pos[i] = new PVector();
    pos[i].x = random(width);
    pos[i].y = random(height);
    vel[i] = new PVector();
    vel[i].x = random(-2, 2);
    vel[i].y = random(-2, 2);
  }

  filelist = loadStrings("filelist.txt"); 
  // データ読み込み用クラスEneTableをインスタンス化（初期化）
  ene = new EneTable(filelist[dataNum]);
}

// 結果を表示
void draw() {
  // 背景
  background(0);

  // 行と列の数だけ繰り返し  
  for (int i = 0; i < ene.data.length-1; i++) {
    // データの数値を表示
    float diameter = map(ene.data[i][hour], 0, 1000, 0, 1000);
    float value = map(ene.data[i][hour], 0, 400, 0, 255);
    if (value > 255) {
      value = 255;
    }
    fill(31, 127, 255, 200);
    ellipse(pos[i].x, pos[i].y, diameter, diameter);
    pos[i].add(vel[i]);
    if (pos[i].x < 0 || pos[i].x > width) {
      vel[i].x *= -1;
    }
    if (pos[i].y < 0 || pos[i].y > height) {
      vel[i].y *= -1;
    }
  }

  // 日付
  fill(255);
  text(ene.date + " "  + hour + ":00", 5, 20);

  // 一つ先のファイルを再読み込み
  // データ番号を更新
  hour++;
  if (hour > 23) {
    hour = 0;
    dataNum++;
    // もしファイル数よりも多ければリセット
    if (dataNum > filelist.length - 1) {
      dataNum = 0;
    }
    // クラスを再度初期化する
    ene = new EneTable(filelist[dataNum]);
  }
}
