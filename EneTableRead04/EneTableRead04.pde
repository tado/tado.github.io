// ファイルを指定して電力データを読み込む
// クラス（Class）バージョン
// 

EneTable ene;
String[] filelist;
int dataNum = 0;
int hour = 0;

void setup() {
  // 画面初期化
  size(800, 1004);
  noStroke();
  frameRate(30);
  textSize(8);

  filelist = loadStrings("filelist.txt"); 
  // データ読み込み用クラスEneTableをインスタンス化（初期化）
  ene = new EneTable(filelist[dataNum]);
}

// 結果を文字で表示
void draw() {
  // 背景
  background(0);
  // 日付
  fill(255);
  text(ene.date + " : "  + hour, 2, 10);
  pushMatrix();
  // 全体を少し右下へ
  translate(2, 20);
  // 行と列の数だけ繰り返し  
  for (int i = 0; i < ene.data.length-1; i++) {
    // データの数値を文字で画面に表示
    float graphWidth = map(ene.data[i][hour], 0, 1000, 0, width);
    if (graphWidth > width) {
      graphWidth = width;
    }
    float value = map(ene.data[i][hour], 0, 100, 0, 255);
    if (value > 255) {
      value = 255;
    }
    fill(value, 0, 255-value);
    rect(0, 9 * i - 6, graphWidth, 8);
  }

  popMatrix();
  // 一つ先のファイルを再読み込み
  // データ番号を更新
  hour++;
  if (hour > 23) {
    hour = 0;
    dataNum++;
  }
  // もしファイル数よりも多ければリセット
  if (dataNum > filelist.length - 1) {
    dataNum = 0;
  }
  // クラスを再度初期化する
  ene = new EneTable(filelist[dataNum]);
}

// EneTable
// 電力データ読み込み用クラス

class EneTable {
  String date;  // 日付
  int data[][]; // データ

  // コンストラクタ（初期化関数）
  // ファイルを指定して、データをパース
  EneTable(String filename) {
    String[] rows = loadStrings(filename);
    String[] header = split(rows[0], ",");
    date = header[1];    
    data = new int[rows.length - 1][];

    for (int i = 1; i < rows.length - 1; i++) {
      int[] row = int(split(rows[i], ","));
      data[i - 1] = (int[]) subset(row, 1);
    }
  }
}


