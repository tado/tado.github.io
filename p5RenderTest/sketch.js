var easycam;
var phongshader;

function setup() {
  pixelDensity(1);
  createCanvas(windowWidth, windowHeight, WEBGL);
  setAttributes('antialias', true);

  var state = {
    distance : 200,
    center   : [0, 0, 0],
    //rotation : [-0.01, 0.01, 0.01, 1.0]
  };
  
  //console.log(Dw.EasyCam.INFO);
  easycam = new Dw.EasyCam(this._renderer, state);
  var phong_vert = document.getElementById("phong.vert").textContent;
  var phong_frag = document.getElementById("phong.frag").textContent;
  phongshader = new p5.Shader(this._renderer, phong_vert, phong_frag);
}

function draw() {
  backupCameraMatrix();

	var matWhite = {
    diff     : [1,1,1],
    spec     : [1,1,1],
    spec_exp : 80.0,
  };
	var materials = [matWhite];

  var ambientlight = {
    col : [0.4, 0.4, 0.4]
  };
  
  var directlights = [
    {
      dir : [-1, -1, -2],
      col : [0.0, 0.0, 0.0],
    },
  ];
  
  var angle = frameCount * 0.02;
  var rad = 100;
  var px = cos(angle) * rad;
  var py = sin(angle) * rad;
  var pz = cos(angle) * rad;
  
  var r = 1;
  var g = 1;
  var b = 1;
  var pointStlength = 250;
  var pointlights = [
    {
      pos : [-px, py, pz, 1],
      col : [0.9, 1, 1],
      att : pointStlength,
    },
    {
      pos : [px, py, -pz, 1],
      col : [1.0, 0.9, 1],
      att : pointStlength,
    },
    {
      pos : [-px, -py, -pz, 1],
      col : [1, 1, 0.9],
      att : pointStlength,
    },
  ];
  
  setShader(phongshader);
  setAmbientlight(phongshader, ambientlight);
  setDirectlight(phongshader, directlights);
  setPointlight(phongshader, pointlights);

  background(255);
  noStroke();
 
  setShader(phongshader);  
  setMaterial(phongshader, matWhite);
  rotateX(frameCount / 100.0);
  rotateY(frameCount / 120.0);
  box(50);
  sphere(30, 32, 32);
}

function setShader(shader){
  shader.uniforms.uUseLighting = true; // required for p5js
  this.shader(shader);
}

function setMaterial(shader, material){
  shader.setUniform('material.diff', material.diff);
  shader.setUniform('material.spec', material.spec);
  shader.setUniform('material.spec_exp', material.spec_exp);
}

function setAmbientlight(shader, ambientlight){
  shader.setUniform('ambientlight.col', ambientlight.col);
}

var m4_camera = new p5.Matrix();
var m3_camera = new p5.Matrix('mat3');

function backupCameraMatrix(){
    m4_camera.set(easycam.renderer.uMVMatrix);
    m3_camera.inverseTranspose(m4_camera);
}

function setDirectlight(shader, directlights){
  for(var i = 0; i < directlights.length; i++){
    var light = directlights[i];
    // normalize
    var x = light.dir[0];
    var y = light.dir[1];
    var z = light.dir[2];
    var mag = Math.sqrt(x*x + y*y + z*z); // should not be zero length
    var light_dir = [x/mag, y/mag, z/mag];
    
    // transform to camera-space
    light_dir = m3_camera.multVec(light_dir);
    
    // set shader uniforms
    shader.setUniform('directlights['+i+'].dir', light_dir);
    shader.setUniform('directlights['+i+'].col', light.col);
  }
}

function setPointlight(shader, pointlights){
  for(var i = 0; i < pointlights.length; i++){
    var light = pointlights[i];
    // transform to camera-space
    var light_pos = m4_camera.multVec(light.pos);
    // set shader uniforms
    shader.setUniform('pointlights['+i+'].pos', light_pos);
    shader.setUniform('pointlights['+i+'].col', light.col);
    shader.setUniform('pointlights['+i+'].att', light.att);
  }
}

p5.Matrix.prototype.multVec = function(vsrc, vdst){
  vdst = (vdst instanceof Array) ? vdst : [];
  var x=0, y=0, z=0, w=1;
  if(vsrc instanceof p5.Vector){
    x = vsrc.x;
    y = vsrc.y;
    z = vsrc.z;
  } else if(vsrc instanceof Array){
    x = vsrc[0];
    y = vsrc[1];
    z = vsrc[2];
    w = vsrc[3]; w = (w === undefined) ? 1 : w;
  } 
  var mat = this.mat4 || this.mat3;
  if(mat.length === 16){
    vdst[0] = mat[0]*x + mat[4]*y + mat[ 8]*z + mat[12]*w;
    vdst[1] = mat[1]*x + mat[5]*y + mat[ 9]*z + mat[13]*w;
    vdst[2] = mat[2]*x + mat[6]*y + mat[10]*z + mat[14]*w;
    vdst[3] = mat[3]*x + mat[7]*y + mat[11]*z + mat[15]*w; 
  } else {
    vdst[0] = mat[0]*x + mat[3]*y + mat[6]*z;
    vdst[1] = mat[1]*x + mat[4]*y + mat[7]*z;
    vdst[2] = mat[2]*x + mat[5]*y + mat[8]*z;
  }
  return vdst;
}
