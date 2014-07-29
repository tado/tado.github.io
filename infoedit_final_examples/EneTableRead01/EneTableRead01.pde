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

