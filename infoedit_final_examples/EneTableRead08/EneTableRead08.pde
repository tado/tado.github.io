EneTable ene;
String[] filelist;
int dataNum = 0;
int hour = 0;

void setup() {
  // 画面初期化
  size(800, 600);
  noStroke();
  frameRate(30);
  textSize(14);
  background(0);

  filelist = loadStrings("filelist.txt"); 
  // データ読み込み用クラスEneTableをインスタンス化（初期化）
  ene = new EneTable(filelist[dataNum]);
}

// 結果を表示
void draw() {
  // 背景
  fill(0, 14);
  rect(0, 0, width, height);

  fill(255);
  // 行と列の数だけ繰り返し  
  for (int i = 0; i < ene.data.length-1; i++) {
    // データの数値を表示
    float y = map(ene.data[i][hour], 0, 1600, height, 0);
    float x = map(hour, 0, 23, 0, width);
    float col = map(ene.data[i][hour], 0, 1200, 0, 255);
    float diameter = map(ene.data[i][hour], 0, 1500, 1, 50);
    fill(col, col, 255-col);
    ellipse(x, y, diameter, diameter);
  }

  // 日付
  fill(0);
  rect(0, 0, 200, 40);
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

