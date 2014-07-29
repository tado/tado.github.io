/*
 * 情報編集(web)2014
 * 最終課題制作テンプレート
 * 2014.07.11
 *
 */

EneTable ene; //ファイル読込のためのクラス
String[] filelist; //データファイル名リスト
int dataNum = 0; //データ番号
int hour = 0; //現在の時間（0〜23）

//初期化
void setup() {
  // 画面初期化
  size(800, 600);
  noStroke();
  frameRate(30);
  textSize(14);
  // ファイルリストの読み込み
  filelist = loadStrings("filelist.txt"); 
  // データ読み込み用クラスEneTableをインスタンス化（初期化）
  ene = new EneTable(filelist[dataNum]);
}

// 結果を表示
void draw() {
  // 背景
  background(0);

  // ================================================
  // !!!!! このループ内でデータを表現する !!!!!
  for (int i = 0; i < ene.data.length-1; i++) {
    // データの数値を表示
    // ene.data[i][hour] で値を取得する
  }
  // ================================================

  // 日付を画面に出力
  fill(255);
  text(ene.date + " "  + hour + ":00", 5, 20);

  // データ番号を更新
  hour++;
  if (hour > 23) {
    hour = 0;
    dataNum++;
    // もしファイル数よりも多ければ最初に戻る
    if (dataNum > filelist.length - 1) {
      dataNum = 0;
    }
    // クラスを再度初期化して次のデータファイルを読み込む
    ene = new EneTable(filelist[dataNum]);
  }
}