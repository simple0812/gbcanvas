
function changeDrawFlag(obj, type) {
    renderSelectedRect();
    type = type || null;
    $('#toolbar .btn').removeClass('btn-primary');
    $(obj).addClass('btn-primary');

	drawInfo.type = type;

    drawInfo.action = null;
    $('.translateimg').attr('src', '/images/component/鼠标箭头.png');
    $('#cvsarea').css('cursor', 'default');
}

function changePictureDrawFlag(obj, type) {
    if( !$(obj).children('img').attr('src')
        || $(obj).children('img').attr('src').indexOf('/images/component/图片.png') > -1
        || $(obj).children('img').attr('src').indexOf('/images/load.gif') > -1
        ) return;
    changeDrawFlag(obj, type);
}

function checkPointIsInRects(x, y) {
    var rects = relativePlaylist.children[viewIndex].children;
	for(var i = rects.length -1 ; i >= 0 ; i--) {
		if(x >= rects[i].left && x <= rects[i].right && y >= rects[i].top && y<= rects[i].bottom && !rects[i].isSelected) {
            if(rects[i].children && rects[i].children.length >0) {
                for(var j = rects[i].children.length -1; j>=0; j--) {
                    if(x >= rects[i].children[j].left + rects[i].left
                        && x <= rects[i].children[j].left + rects[i].left + rects[i].children[j].width
                        && y >= rects[i].children[j].top + rects[i].top
                        && y<= rects[i].children[j].top + rects[i].top + rects[i].children[j].height
                        && !rects[i].children[j].isSelected) {
                        return rects[i].children[j];
                    }
                }

                return rects[i];

            } else return rects[i];
        }
	}

	return false;
}

function checkPointIsInCvs(x, y) {
    if(x>=0 && x <= WIDTH  && y >= 0 && y <= HEIGHT) return true;
    return false;
}

function checkPointIsInRect(x, y, rect) {
    var left = rect.parent? rect.parent.left + rect.left : rect.left;
    var top = rect.parent? rect.parent.top + rect.top : rect.top;
    var right = left + rect.width;
    var bottom = top + rect.height;

    if(x >= left && x <= right && y >= top && y <= bottom ) return rect;
    return false;
}


//coverMode:
// 0 所有的都不能重合，
// 1 媒体与面板不能重合  图片可以与面板或者媒体重合，
// 2 媒体与面板和图片不能重合 图片可以与面板或者图片重合， 如果图片属于面板则 图片可以与媒体重合
// 3只有图片可以重合 文字区域与图片权限一样


//被选中大矩形不参与判断
function checkRectIsCoverRects(rect, coverMode) {
    var rects = relativePlaylist.children[viewIndex].children;

    coverMode = coverMode || 0;
    for(var i = rects.length -1 ; i >= 0 ; i--) {

        if(rects[i].isSelected) continue;
        if(checkRectIsCoverRect(rect, rects[i])) {
            if(coverMode == 0) {
                return rects[i];
            } else if(coverMode == 1) {
                if(rect.coverLevel <= 2 && rects[i].coverLevel <= 2) return rects[i];
            } else if (coverMode == 2) {
                if((rect.coverLevel == 3 && rect.parent && checkRectIsCoverRect(rect, rect.parent)) ||
                    (rects[i].coverLevel == 3 && rects[i].parent && checkRectIsCoverRect(rect, rect.parent))) continue;
                if(rect.coverLevel == 1 || rects[i].coverLevel == 1 ||
                    (rect.coverLevel == 2  && rects[i].coverLevel == 2)) return rects[i];
            } else if(coverMode == 3) {
                if(rect.coverLevel <= 2 || rects[i].coverLevel <= 2 )  return rects[i];
            }
        }
    }

    return false;
}

function getRectsInGroupZone(rect) {
    var rects = relativePlaylist.children[viewIndex].children;
    var ret =  [];
    for(var i = rects.length -1 ; i >= 0 ; i--) {
        if(checkRectIsCoverRect(rect, rects[i])) {
            if(rects[i].isSelected) continue;
            ret.push(rects[i]);
        }

    }

    return ret
}


function checkRectIsCoverRect(targetRect, origRect) {
    targetRect.format();
    origRect.format();
    var tLeft = targetRect.parent? targetRect.parent.left + targetRect.left : targetRect.left;
    var tTop = targetRect.parent? targetRect.parent.top + targetRect.top : targetRect.top;
    var tBottom = tTop + targetRect.height;
    var tRight = tLeft + targetRect.width;

    var oLeft = origRect.parent? origRect.parent.left + origRect.left : origRect.left;
    var oTop = origRect.parent? origRect.parent.top + origRect.top : origRect.top;
    var oBottom = oTop + origRect.height;
    var oRight = oLeft + origRect.width;

    var minx = Math.max(tLeft, oLeft);
    var miny = Math.max(tTop, oTop);
    var maxx = Math.min(tRight, oRight);
    var maxy = Math.min(tBottom, oBottom);

    if(!(minx >= maxx || miny >= maxy)) return true;
    return false;
}

function getSelectedRect() {
    return _.find(relativePlaylist.children[viewIndex].children, function(rect) {return rect.isSelected == true});
}
function getSelectedChild(rect) {
    return _.find(rect.children, function(child) { return child.isSelected == true});
}

function getRectByRect(targetRect) {
    return _.find(relativePlaylist.children[viewIndex].children, function(rect) {
        return  rect.top == targetRect.top
            && rect.left == targetRect.left
            && rect.bottom == targetRect.bottom
            && rect.right == targetRect.right ;
    })
}

function checkPointIsOut(x, y) {
	if(x >= 0 && x <= WIDTH   && y >= 0 && y <= HEIGHT)
		return false;
	return true;
}

function checkRectIsOut(rect) {
    if(!rect || rect.parent) return false;
    if(rect.left >= WIDTH  ||
        rect.top >= HEIGHT || rect.right <= 0 || rect.bottom <= 0) return true;
	return false;
}

function fillBg(ctx, src) {

    var img = new Image();
    img.onload = function () {
        var pattern = ctx.createPattern(img, "repeat-y");
        ctx.fillStyle = pattern;
        ctx.fillRect(0, 0, img.width, img.height);
    }
    img.src = src;
}


function text(ctx, str, x, y, font, color, align, dir) {
    ctx.save();
    ctx.beginPath();
    ctx.font = font;
    ctx.textAlign = align;
    ctx.fillStyle = color;

    if (dir != undefined && dir != null) {
        ctx.translate(x, y);
        ctx.rotate(Math.PI / 2);
        ctx.fillText(str, 0, 0);
    }
    else {
        ctx.fillText(str, x, y);
    }

    ctx.restore();
    ctx.closePath();
}

function wrapText(context, words, x, y, fontStyle, color, maxWidth, maxHeight, lineHeight) {
    context.save();
    //ctx.scale(RATIO, RATIO);
    var line = '';

    context.font = fontStyle;
    context.fillStyle = color;
    context.textAlign = 'left';
    context.textBaseline = 'top';
    context.rect(x,y, maxWidth, maxHeight);
    context.clip();

    //console.log(/\n/g.test(words) + '============++=========');
    //匹配换行
    var arr = words.split(/\n/g);
    for(var i = 0, len = arr.length; i< len ; i++) {
        var temp = arr[i];
        testWidth = 0;
        for(var n = 0; n < temp.length; n++) {
            var testLine = line + temp[n];
            var metrics = context.measureText(testLine);
            var testWidth = metrics.width;
            if(testWidth > maxWidth ) {
                context.fillText(line, x, y);
                line = temp[n];
                y += lineHeight;
            }
            else line = testLine;
        }
        context.fillText(line, x, y);
        line = '';
        y += lineHeight;
    }

//不匹配换行
//    for(var n = 0; n < words.length; n++) {
//        var testLine = line + words[n];
//        var metrics = context.measureText(testLine);
//        var testWidth = metrics.width;
//        if(testWidth > maxWidth ) {
//            context.fillText(line, x, y); //若换行 则先渲染上一行
//            line = words[n];
//            y += lineHeight;
//        }
//        else {
//            line = testLine;
//        }
//    }
//    context.fillText(line, x, y);

    context.restore();
}


function drawLine(ctx, left, top, right, bottom, width, style) {

    ctx.save();
    ctx.beginPath();
    ctx.moveTo(left, top);
    ctx.lineTo(right, bottom);
    ctx.lineWidth = width;
    ctx.strokeStyle = style;
    ctx.stroke();
    ctx.restore();
    ctx.closePath();
}

function drawArc(ctx, left, top, sradius, startAngle, endAngle,  fillstyle, anticlockwise) {
    ctx.save();
    ctx.beginPath();
    
    ctx.arc(left, top, sradius, startAngle, endAngle, anticlockwise)
    ctx.fillStyle = fillstyle;

    ctx.fill();
    ctx.restore();
    ctx.closePath();
}

function updateRects(rect) {
    if(!drawInfo.operRect) return;
    if(drawInfo.operRect.isSelected) {
        drawInfo.operRect.isSelected = false;
        drawInfo.operRect = drawInfo.operRect.changePlace(rect.format());
    }
    else relativePlaylist.children[viewIndex].children.push(rect.format())
}

function getRectDots(rect) {
    if(rect.parent)
        return [
            [rect.left + rect.parent.left, rect.top + rect.parent.top],
            [rect.left + rect.parent.left + rect.width/2, rect.top + rect.parent.top],
            [rect.right + rect.parent.left , rect.top + rect.parent.top],
            [rect.left + rect.parent.left, rect.top + rect.parent.top + rect.height/2],
            [rect.right+ rect.parent.left, rect.top + rect.parent.top + rect.height/2],
            [rect.left + rect.parent.left, rect.bottom+ rect.parent.top],
            [rect.left + rect.parent.left + rect.width/2, rect.bottom+ rect.parent.top],
            [rect.right+ rect.parent.left, rect.bottom + rect.parent.top]
        ];
    else
        return [
            [rect.left, rect.top], [rect.left + rect.width/2, rect.top], [rect.right, rect.top],
            [rect.left, rect.top + rect.height/2], [rect.right, rect.top + rect.height/2],
            [rect.left, rect.bottom], [rect.left + rect.width/2, rect.bottom], [rect.right, rect.bottom]
        ];
}

function getRectCoords(rect, x, y) {
    var points = getRectDots(rect);
    var w = rect.width;
    var h = rect.height;
    var left, top, right, bottom;

    switch (resizeInfo.index) {

        case 0:
            //left = x;
            top = y;
            right = points[7][0];
            bottom = points[7][1];
            left = right - (bottom - top) * w /h; //等比
            break;

        case 1:

            top = y;
            right = points[7][0];
            bottom = points[7][1];
            left = points[0][0];
            break;

        case 2:
//            left = x;
            top = y;
            right = points[5][0];
            bottom = points[5][1];
            left = right + (bottom - top) * w /h; //等比
            break;

        case 3:
            left = x;
            right = points[7][0];
            bottom = points[7][1];
            top = points[0][1];
            break;

        case 4:
            top = points[0][1];
            left = points[0][0];
            right = x;
            bottom = points[5][1];
            break;

        case 5:
//            left = x;
            top = y;
            right = points[2][0];
            bottom = points[2][1];
            left = right + (bottom - top) * w / h; //等比
            break;

        case 6:
            left = points[0][0];
            top = points[0][1];
            bottom = y;
            right = points[7][0];

            break;

        case 7:
            left = points[0][0];
            top = points[0][1];
            bottom = y;
            right = left + (bottom - top) * w /h; //等比
            break;

        default : break;
    }

    return [ Math.min(left, right), Math.min(top, bottom), Math.max(left, right),Math.max(top, bottom) ];
}

function windowToCanvas(canvas,x,y) {	//鼠标坐标点切换
    var bbox = canvas.getBoundingClientRect();

    return {
        x :( x - bbox.left) * (canvas.width/bbox.width) / RATIO ,
        y : (y - bbox.top )* (canvas.height/bbox.height) /RATIO
    };
}

function getOrCreateCanvas(index, scene) {
    var xCvs;

    if($('#leftside canvas').length <= index) {
        xCvs = document.createElement('canvas');
        xCvs.addEventListener('click', function() { switchView(xCvs)})
        $('#leftside').append($('#tmplPreview').html().format(index, scene.id, scene.duration));
    }

    xCvs = $('#leftside canvas').get(index);
    xCvs.width = WIDTH * RATIO;
    xCvs.height = HEIGHT * RATIO;
    $(xCvs).css('height', HEIGHT * $(xCvs).width() / WIDTH);

    return xCvs;
}

function createScene(scene) {
    var xCvs = document.createElement('canvas');

    xCvs.addEventListener('click', function() { switchView(xCvs)})
    $('#leftside').append($('#tmplPreview').html().format($('#leftside canvas').length, scene.id, scene.duration));
    xCvs.width = WIDTH;
    xCvs.height = HEIGHT;
    $(xCvs).css('height', HEIGHT * $(xCvs).width() / WIDTH);

    return xCvs;
}



/*
function saveImg() {
    //将图像输出为base64压缩的字符串  默认为image/png
    var data = cvs.toDataURL();
    //删除字符串前的提示信息 "data:image/png;base64,"
    var b64 = data.substring(22);
    //POST到服务器上，生成图片
    $.post( "save.aspx" , { data : b64, name : 'xx' }, function(){
        //ok
    });
}


CanvasRenderingContext2D.prototype.roundRect = function (x, y, w, h, r) {
    if (w &lt; 2 * r) r = w / 2;
    if (h &lt; 2 * r) r = h / 2;
    this.beginPath();
    this.moveTo(x+r, y);
    this.arcTo(x+w, y, x+w, y+h, r);
    this.arcTo(x+w, y+h, x, y+h, r);
    this.arcTo(x, y+h, x, y, r);
    this.arcTo(x, y, x+w, y, r);
// this.arcTo(x+r, y);
    this.closePath();
    return this;
}*/

