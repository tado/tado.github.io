// ファイルを指定して電力データを読み込む
// クラス（Class）バージョン

EneTable ene;

void setup() {
  // 画面初期化
  size(800, 1004);
  frameRate(30);
  textSize(8);

  // データ読み込み用クラスEneTableをインスタンス化（初期化）
  ene = new EneTable("20140318_ENE.CSV");
}

// 結果を文字で表示
void draw() {
  // 背景
  background(0);
  // 日付
  text(ene.date, 2, 10);
  // 全体を少し右下へ
  translate(2, 20);
  // 行と列の数だけ繰り返し  
  for (int i = 0; i < ene.data.length-1; i++) {
    for (int j = 0; j < 24; j++) {
      // データの数値を文字で画面に表示
      text(ene.data[i][j], (width / 24.0) * j, 9 * i);
    }
  }
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


