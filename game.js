var myGamePiece;
var myObstacles = [];
var myScore;

function startGame() {
    myGamePiece = new component(77, 77, "IMG_0003.png", 10, 120, "image");
    myGameArea.start();
}

var myGameArea = {
    canvas : document.createElement("canvas"),
    start : function() {
        this.canvas.width = 480;
        this.canvas.height = 270;
        this.context = this.canvas.getContext("2d");
        
        document.body.insertBefore(this.canvas, document.body.childNodes[0]);
        this.frameNo = 0;
        this.interval = setInterval(updateGameArea, 20);
        },
    clear : function() {
        this.context.clearRect(0, 0, this.canvas.width, this.canvas.height);
    }
}

function component(width, height, color, x, y, type) {
    this.type = type;
    if (type == "image") {
        this.image = new Image();
        this.image.src = color;
    }
    this.width = width;
    this.height = height;
    this.speedX = 0;
    this.speedY = 0;    
    this.x = x;
    this.y = y;    
    this.update = function() {
        ctx = myGameArea.context;
        if (type == "image") {
            ctx.drawImage(this.image, 
                this.x, 
                this.y,
                this.width, this.height);
        } else {
            ctx.fillStyle = color;
            ctx.fillRect(this.x, this.y, this.width, this.height);
        }
    }
    this.newPos = function() {
        this.x += this.speedX;
        this.y += this.speedY;        
    }
}


function updateGameArea() {
    myGameArea.clear();
    myGamePiece.newPos();
    myGamePiece.update();
}

function move(dir) {
    if (dir == "up") {myGamePiece.speedY = -5; }
    if (dir == "down") {myGamePiece.speedY = 5; }
    if (dir == "left") {myGamePiece.speedX = -5; }
    if (dir == "right") {myGamePiece.speedX = 5; }
}

function clearmove() {
    myGamePiece.speedX = 0; 
    myGamePiece.speedY = 0; 
}

document.addEventListener('keydown', function(event) {
    if (event.keyCode == 37) { //left
        move("left")
    }
    if (event.keyCode == 38) { //up
        move("up")
    }
    if (event.keyCode == 39) { //right
        move("right")
    }
    if (event.keyCode == 40) { //down
        move("down")
    }
});

document.addEventListener('keyup', function(event) {
    if ((event.keyCode == 37)||(event.keyCode == 38)||
    (event.keyCode == 39)||(event.keyCode == 40)) {
        clearmove();
    }
});

