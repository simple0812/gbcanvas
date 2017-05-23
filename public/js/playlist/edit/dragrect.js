var dragInfo = {
	ele: null,
	percentX:0,
	percentY:0,
	image:null,
    init: function() {
        this.ele = null;
        this.percentX = 0;
        this.percentY = 0;
        this.image = null;
    }
}

$('#toolbar img').each(function(i, o) {
    o.ondragstart = imgDragStart;
    o.ondragend = imgDragEnd;
});

$('.dragText').each(function(i, o) {
    o.ondragstart = aDragStart;
    o.ondragend = imgDragEnd;
});

function aDragStart(e) {
    e = e || window.event;
    var target = e.target || e.srcElement;
    if(!target) return;
    e.dataTransfer.setData('TEXT', $(target).attr('title') || '图片');
    if(drawInfo.operRect && drawInfo.operRect.isSelected) {
        drawInfo.operRect.isSelected = false;
        render();
        clearTempCvs();
        drawInfo.init();
    }

    dragInfo.ele = target;
    dragInfo.percentX = 0.5;
    dragInfo.percentY = 0.5;
    //e.preventDefault();
    //return true;
}


function imgDragStart(e) {
    e = e || window.event;
    var target = e.target || e.srcElement;
    var type = $(target).attr('type');
    if(!target) return;
    var p = target.parentNode.id == "btnImageRect" ? $('#btnImageRect').attr('title') : ($(target).attr('title') || '图片')

    e.dataTransfer.setData('TEXT',  p);
    if(drawInfo.operRect && drawInfo.operRect.isSelected) {
        drawInfo.operRect.isSelected = false;
        render();
        clearTempCvs();
        drawInfo.init();
    }

    dragInfo.ele = target;
    var ox = e.pageX - $(target).offset().left;
    var oy = e.pageY - $(target).offset().top;
    var w = $(target).width();
    var h = $(target).height();

    dragInfo.percentX = ox/w;
    dragInfo.percentY = oy/h;
    if(!dragInfo.image) {
        dragInfo.image = new Image();
        dragInfo.image.onload = function() {
            if(!_.find(IMAGES, function(each) { return each.src.trimUrlPath() == dragInfo.image.src.replace(/http:\/\/[^\/]+(:\d{2,8})?\//, '/')}))
                IMAGES.push({src:dragInfo.image.src.replace(/http:\/\/[^\/]+(:\d{2,8})?\//, '/'), image:dragInfo.image});
        }
        dragInfo.image.src = $(target).attr('url') || dragInfo.ele.src
    }
}

function imgDragEnd() {
    tempCvs.width += 0;
}

cvsarea.ondragenter = function(ev) {
	return true;
};

cvsarea.ondragover = function(e) {
	e = e || window.event;
    var loc = windowToCanvas(cvs, e.clientX, e.clientY);
    var offsetX = loc.x;
    var offsetY = loc.y;
    var type = $(dragInfo.ele).attr('type') || 'rect';
    var component = getRectByType(type);

	if(dragInfo.image && dragInfo.image.width) {
        var w = component.width || dragInfo.image.width ;
        var h = component.height || dragInfo.image.height;


		tempCvs.width += 0;
        tempCtx.save();
		offsetX -= w * dragInfo.percentX ;
		offsetY -= h * dragInfo.percentY ;
		tempCtx.lineWidth = 0.5;
        tempCtx.scale(RATIO, RATIO);
		tempCtx.strokeStyle = "blue";
		tempCtx.strokeRect(offsetX, offsetY, w , h );
        tempCtx.restore();
	} else {
        tempCvs.width += 0;
        tempCtx.save();
        offsetX -= component.width * dragInfo.percentX;
        offsetY -= component.height * dragInfo.percentY;
        tempCtx.lineWidth = 0.5;
        tempCtx.scale(RATIO, RATIO);
        tempCtx.strokeStyle = "blue";
        tempCtx.strokeRect(offsetX, offsetY, component.width, component.height);
        tempCtx.restore();
    }

	e.preventDefault();
	return true;
};

cvsarea.ondrop = function(e) {
	e = e || window.event;
    var loc = windowToCanvas(cvs, e.clientX, e.clientY);
    var offsetX = loc.x;
    var offsetY = loc.y;

	if(!dragInfo.ele) return;
	tempCvs.width += 0;

    var type = $(dragInfo.ele).attr('type') || 'rect';
    var tag = e.dataTransfer.getData('TEXT') || '图片';
	if(dragInfo.image && dragInfo.image.width) {
		renderImage(dragInfo.image, tag, offsetX, offsetY, type );
	} else {
        renderText(tag, offsetX, offsetY, type);
	}

	return cancelDefaultEvent(e);
};

function renderText( tag, offsetX, offsetY,type ) {
    var rect =getRectByType(type);

    offsetX -= rect.width * dragInfo.percentX ;
    offsetY -= rect.height * dragInfo.percentY ;

    rect = rect. changePlace(new Rect(offsetX, offsetY, offsetX + rect.width, offsetY + rect.height ));
    rect.tag = tag || '图片';
    var tempRect = null;

    if(!checkRectIsCoverRects(rect, 2)) {
        //面板与文字重合 将文字作为面板的子内容
        if( tempRect = checkRectIsCoverRects(rect, 3)) tempRect.setChildrenRect(rect);
        else relativePlaylist.children[viewIndex].children.push(rect);

        if (rect.constructor == MediaZone) rect.addPlaylist();

        render();
    }


    dragInfo.init();
}

function renderImage(img, tag, offsetX, offsetY,type ) {

    var type = $(dragInfo.ele).attr('type') || 'rect';
    var component = getRectByType(type);

    var w = component.width || img.width ;
    var h = component.height || img.height;

	offsetX -= w * dragInfo.percentX ;
	offsetY -= h * dragInfo.percentY ;

	var rect =getRectByType(type).changePlace(new Rect(offsetX, offsetY, offsetX + w, offsetY + h ));
	rect.source = new ImageInfo(img.src.replace(/http:\/\/[^\/]+(:\d{2,8})?\//, '/'), img.width, img.height);
    rect.url = img.src.replace(/http:\/\/[^\/]+(:\d{2,8})?\//, '/');
    rect.tag = tag || '图片';

    if(rect.type =='mediaZone') rect.addPlaylist();

    var tempRect = null;

	if(!checkRectIsCoverRects(rect, 2)) {

        if(rect.type == 'groupZone') {
            var rects = getRectsInGroupZone(rect);

            for(var i = rects.length -1; i >= 0 ; i--) {
                tempRect = rects[i]; //为图片或者文字等组件
                if(!(tempRect.parent)) { //组件不是当前面板的子元素则添加
                    rect.setChildrenRect(tempRect);
                    relativePlaylist.children[viewIndex].children = _.without(relativePlaylist.children[viewIndex].children,  tempRect);
                }
            }
            relativePlaylist.children[viewIndex].children.push(rect);
        }

        //面板与图片重合 将图片作为面板的子内容
        
        else if( tempRect = checkRectIsCoverRects(rect, 3)) tempRect.setChildrenRect(rect);
        else relativePlaylist.children[viewIndex].children.push(rect);

        render();
	}

    dragInfo.init();
}





