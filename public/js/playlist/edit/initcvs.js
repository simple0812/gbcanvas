//function initBgCvs(ctx) {
//    for(var i = 1, len = WIDTH*RATIO/GRIDEWIDTH; i < len ; i++) {
//        drawLine(ctx, i * GRIDEWIDTH -0.5 , 0, i * GRIDEWIDTH-0.5, HEIGHT*RATIO , 0.5, '#ccc');
//    }
//
//    for(var i = 1, len = HEIGHT*RATIO/GRIDEWIDTH; i < len ; i++) {
//        drawLine(ctx,  0, i * GRIDEWIDTH +.5 , WIDTH*RATIO, i * GRIDEWIDTH+.5 ,  0.5, '#ddd');
//    }

//}

function initCoord() {
    var normalScaleLength = 5;
    var specialScaleLength = 10;

    $('#xCoord').attr({ width: WIDTH*RATIO , height: 30});
    $('#yCoord').attr({ width: 30, height: HEIGHT*RATIO });

    var xCvs = document.getElementById('xCoord');
    var yCvs = document.getElementById('yCoord');

    var xCtx = xCvs.getContext('2d');
    var yCtx = yCvs.getContext('2d');

    //GRIDEWIDTH =10 * RATIO;
//    for(var i = 0, len = WIDTH*RATIO/GRIDEWIDTH; i < len ; i++) {
//        var p = i % 5 == 0? 30 - specialScaleLength : 30- normalScaleLength;
//        drawLine(xCtx, i * GRIDEWIDTH + 0.5 , p, i * GRIDEWIDTH + 0.5, 30, 1, 'blue');
//        if (i == 0) text(xCtx , i*GRIDEWIDTH + '', i* GRIDEWIDTH, 15, '10px', 'black', 'left');
//        else if (i%5 == 0) text(xCtx , i*GRIDEWIDTH + '', i* GRIDEWIDTH, 15, '10px', 'black', 'center');
//    }
//
//    for(var i = 0, len = HEIGHT*RATIO/GRIDEWIDTH; i < len ; i++) {
//        var p = i % 5 == 0? 30 - specialScaleLength : 30- normalScaleLength;
//        drawLine(yCtx,  p, i * GRIDEWIDTH + 0.5  , 30, i * GRIDEWIDTH + 0.5 ,  1, 'blue');
//        if(i == 0) text(yCtx , i*GRIDEWIDTH + '', 5, i* GRIDEWIDTH, '10px', 'black', 'left', 0 );
//        else if (i%5 == 0)  text(yCtx , i*GRIDEWIDTH + '', 5, i* GRIDEWIDTH, '10px', 'black', 'center', 0 );
//    }
    var gw = GRIDEWIDTH * RATIO;
    for(var i = 0, len = WIDTH*RATIO/gw; i < len ; i++) {
        var p = i % 5 == 0? 30 - specialScaleLength : 30- normalScaleLength;
        drawLine(xCtx, i * gw + 0.5 , p, i * gw + 0.5, 30, 1, 'blue');
        if (i == 0) text(xCtx ,  parseInt(i*gw / RATIO) + '', i* gw, 15, '10px', 'black', 'left');
        else if (i%5 == 0) text(xCtx , parseInt(i*gw / RATIO)  + '', i* gw, 15, '10px', 'black', 'center');
    }

    for(var i = 0, len = HEIGHT*RATIO/gw; i < len ; i++) {
        var p = i % 5 == 0? 30 - specialScaleLength : 30- normalScaleLength;
        drawLine(yCtx,  p , i * gw + 0.5  , 30, i * gw + 0.5 ,  1, 'blue');
        if(i == 0) text(yCtx , parseInt(i*gw / RATIO)  + '', 5, i* gw, '10px', 'black', 'left', 0 );
        else if (i%5 == 0)  text(yCtx , parseInt(i*gw / RATIO)  + '', 5, i* gw, '10px', 'black', 'center', 0 );
    }
}

function drawCoordLine(x, y) {
	coordCvs.width += 0;
    x *= RATIO;
    y *= RATIO;
    drawLine(coordCtx, x +0.5, 0, x+0.5, HEIGHT*RATIO, 1, 'blue');
    drawLine(coordCtx, 0, y+0.5, WIDTH*RATIO, y+0.5,1, 'blue');
}

