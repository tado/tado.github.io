// ファイルを指定して電力データを読み込む
// クラス（Class）バージョン
// 

EneTable ene;
String[] filelist;
int dataNum = 0;

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
  text(ene.date, 2, 10);
  pushMatrix();
  // 全体を少し右下へ
  translate(2, 20);
  // 行と列の数だけ繰り返し  
  for (int i = 0; i < ene.data.length-1; i++) {
    for (int j = 0; j < 24; j++) {
      // データの数値を文字で画面に表示
      float value = map(ene.data[i][j], 0, 100, 0, 255);
      if(value > 255){
        value = 255;
      }
      fill(value, 0, 255-value);
      rect((width / 24.0) * j, 9 * i - 6, (width / 24.0)-1, 8);
      fill(255,127);
      text(ene.data[i][j], (width / 24.0) * j, 9 * i);
    }
  }
  popMatrix();
  // 一つ先のファイルを再読み込み
  // データ番号を更新
  dataNum++;
  // もしファイル数よりも多ければリセット
  if (dataNum > filelist.length - 1) {
    dataNum = 0;
  }
  // クラスを再度初期化する
  ene = new EneTable(filelist[dataNum]);
}

