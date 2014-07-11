EneTable ene;
String[] filelist;
int dataNum = 0;
int hour = 0;

ParticleGen[] particle = new ParticleGen[110];

void setup() {
  // 画面初期化
  size(800, 600);
  noStroke();
  frameRate(30);
  textSize(14);

  for (int i = 0; i < particle.length; i++) {
    particle[i] = new ParticleGen();
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
    int value = int(map(ene.data[i][hour], 0, 1200, 0, 1000));
    float diameter = map(ene.data[i][hour], 0, 1200, 5, 100);
    particle[i].maxParticle = value;
    particle[i].centerDiameter = diameter;
    particle[i].draw();
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

class ParticleGen {
  PVector center;
  PVector centerVel;
  float centerDiameter;
  ArrayList <PVector> pos;
  ArrayList <PVector> vel;
  int maxParticle;

  ParticleGen() {
    center = new PVector(random(width), random(height)); 
    centerVel = new PVector(random(-0.1, 0.1), random(-0.1, 0.1));
    pos = new ArrayList<PVector>();
    vel = new ArrayList<PVector>();
    maxParticle = 10;
    centerDiameter = 0;
  }

  void draw() {
    fill(200, 100);
    ellipse(center.x, center.y, centerDiameter, centerDiameter);

    PVector v = new PVector(random(-0.5, 0.5), random(-0.5, 0.5));
    PVector p = new PVector(center.x, center.y);
    if (random(100) < maxParticle) {
      vel.add(v);
      pos.add(p);
      if (pos.size() > maxParticle) {
        pos.remove(0);
        vel.remove(0);
      }
    }
    for (int i = 0; i < pos.size (); i++) {
      fill(31, 127, 255, 200);
      ellipse(pos.get(i).x, pos.get(i).y, 2, 2);
      pos.get(i).add(vel.get(i));
    }
    center.add(centerVel);
    if (center.x < 0 || center.x > width) {
      centerVel.x *= -1;
    }
    if (center.y < 0 || center.y > height) {
      centerVel.y *= -1;
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

  float getRowsMin(int row) {
    float m = Float.MAX_VALUE;
    for (int col = 0; col < data[row].length; col++) {
      if (data[row][col] < m) {
        m = data[row][col];
      }
    }
    return m;
  }
  
  float getRowsMax(int row) {
    float m = -Float.MAX_VALUE;
    for (int col = 0; col < data[row].length; col++) {
      if (data[row][col] > m) {
        m = data[row][col];
      }
    }
    return m;
  }
}


