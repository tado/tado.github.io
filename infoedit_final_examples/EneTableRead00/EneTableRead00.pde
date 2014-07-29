// ファイルを指定して電力データを読み込む
// 関数（Function）バージョン

String date;   // 日付
int data[][];  // データの配列 data[行][列]

void setup() {
  // 画面初期化
  size(800, 1004);
  frameRate(30);
  // 文字サイズ
  textSize(8);
  // データ読み込み関数を実行
  loadData("20140318_ENE.CSV");
}

  // 結果を文字で表示
void draw() {
  // 背景
  background(0);
  // 日付
  text(date, 2, 10);
  // 全体を少し右下へ
  pushMatrix();
  translate(2, 20);
  // 行と列の数だけ繰り返し
  for (int i = 0; i < data.length - 1; i++) {
    for (int j = 0; j < 24; j++) {
      // データの数値を文字で画面に表示
      text(data[i][j], (width / 24.0) * j, 9 * i);
    }
  }
  popMatrix();
}

// ファイルを指定してデータを読み込む関数
void loadData(String filename) {
  // 行単位でデータを読み込み
  String[] rows = loadStrings(filename);
  // 最初の行はヘッダーとする
  String[] header = split(rows[0], ",");
  // ヘッダーの2番目の項目は日付
  date = header[1];
  // データ配列の準備
  data = new int[rows.length - 1][];
  // コンマ区切りで行のデータを分割
  for (int i = 1; i < rows.length - 1; i++) {
    int[] row = int(split(rows[i], ","));
    data[i - 1] = (int[]) subset(row, 1);
  }
}

