/*
 * 情報編集(Web)2014
 * 最終課題制作テンプレート
 * 2014.07.11
 */

EneTable ene;      //データ読み込み用クラス
String[] filelist;
int dataNum = 0;
int hour = 0;

void setup() {
  // 画面初期化
  size(800, 600);
  noStroke();
  frameRate(30);
  textSize(14);

  filelist = loadStrings("filelist.txt");
  // データ読み込み用クラスEneTableをインスタンス化（初期化）
  ene = new EneTable(filelist[dataNum]);
}

// 結果を表示
void draw() {
  // 背景
  background(0);
  // 日付
  fill(255);
  text(ene.date + " "  + hour + ":00", 5, 20);
  pushMatrix();

  translate(width/2, height/2);
  // 行と列の数だけ繰り返し
  for (int i = 0; i < ene.data.length-1; i++) {
    // データの数値を表示
    float graphWidth = map(ene.data[i][hour], 0, 1000, 0, width/2);
    if (graphWidth > width) {
      graphWidth = width;
    }
    float value = map(ene.data[i][hour], 0, 100, 0, 255);
    if (value > 255) {
      value = 255;
    }
    fill(value, value, 0, value);
    rect(0, -1, graphWidth, 2);
    rotate(PI * 2.0 / 109.0);
  }
  popMatrix();
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
