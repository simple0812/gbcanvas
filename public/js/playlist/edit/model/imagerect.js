function ImageRect(left, top, right, bottom, tag, background, border, id, name, source) {
    var args = Array.prototype.slice.call(arguments, 0);
    Rect.apply(this, args)
    this.type = 'image';
    this.name = name || this.createName();
    this.coverLevel = 3;
    this.border = border || 'green';
    this.tag = tag || '图片';
    this.source = source || new Object;
    this.parent = null;
}
extend(ImageRect, Rect);

ImageRect.prototype.render = function() {
    $('#compnentindex').append($('#tmplImg').html().format(this.source.src, this.tag));

    if(this.isSelected) return $('#compnentindex li').last().children('div').addClass('selected');

    var img = new Image();
    var that = this;
    var p = getImageBySrc(this.source.src);



    if(p) {
        ctx.save();
        ctx.scale(RATIO, RATIO);
        ctx.globalAlpha = this.opacity;
        ctx.drawImage(p, this.left, this.top, this.right - this.left,this.bottom - this.top);
        ctx.restore();
    }
    else {
        img.onload = function() {
            ctx.save();
            ctx.scale(RATIO, RATIO);
            ctx.globalAlpha = this.opacity;
            ctx.drawImage(img, that.left, that.top, that.right - that.left, that.bottom - that.top);
            ctx.restore();
            if(!_.find(IMAGES, function(each) { return each.src == that.source.src}))
                IMAGES.push({src:that.source.src, image:img});

        };
        img.src = this.source.src;
    }
};

ImageRect.prototype.stroke = function() {
    var tempRect;// normalrect

    if( tempRect = checkRectIsCoverRects(this, 3)) {
        //如果图片没有移除他的面板则不判断
        if((this.parent && checkRectIsCoverRect(this.parent, this))) {
            updateRects(this);
        } else {
            removeRect(drawInfo.operRect);
            tempRect.setChildrenRect(this);
        }
    } else if(this.parent && this.source) { //图片从面板移到画板中
        removeRect(drawInfo.operRect);
        this.top = this.top + this.parent.top;
        this.left = this.left + this.parent.left;
        this.right = this.left + this.width;
        this.bottom = this.top + this.height;
        this.parent = null;
        this.isSelected = false;
        relativePlaylist.children[viewIndex].children.push(this.format());
    } else updateRects(this);
};

ImageRect.prototype.renderAsChild = function() {
    var that = this;

    if($('#compnentindex').children('li').last().children('ol').length == 0)
        $('#compnentindex').children('li').last().append('<ol draggable="false"></ol>')

    $('#compnentindex ol').last().append($('#tmplImg').html().format(this.source.src, this.tag));

    if(this.isSelected) return $('#compnentindex li').last().children('div').addClass('selected');

    ctx.save();
    ctx.scale(RATIO, RATIO);
    ctx.globalAlpha = this.opacity;

    ctx.rect(this.parent.left,this.parent.top, this.parent.width, this.parent.height)
    ctx.clip();

    var left = this.left + this.parent.left;
    var top = this.top + this.parent.top;
    var right = left + this.width;
    var bottom = top + this.height;

    var maxLeft = Math.max(left, this.parent.left +1);
    var maxTop = Math.max(top, this.parent.top +1);
    var minRight = Math.min(this.parent.left + this.parent.width-1, right);
    var minBottom = Math.min(this.parent.top + this.parent.height-1, bottom);

    var cutLeft = (maxLeft - left)* this.source.width/this.width;
    var cutTop = (maxTop - top)* this.source.height/this.height;

    var width = minRight - maxLeft;
    var height = minBottom - maxTop;

    var xWidth = width *this.source.width/(this.width );
    var xHeight = height* this.source.height/(this.height);
    var p = getImageBySrc(this.source.src);

    if(p)  ctx.drawImage(p, cutLeft, cutTop, xWidth, xHeight, maxLeft, maxTop, width, height);

    ctx.restore();
};



ImageRect.prototype.showDetail = function() {
    var div = document.createElement('div');
    //$(div).addClass('movediv');
    div.className = 'movediv';
    var top = (this.parent? (this.parent.top + this.top) * RATIO : this.top * RATIO) + TRANSLATE.y;
    var left = (this.parent? (this.parent.left + this.left) * RATIO : this.left * RATIO) + TRANSLATE.x;

    $(div).css({top:top, left:left,
        cursor:'move', width:this.width * RATIO, height:this.height * RATIO, background:"#fff", opacity:0});
    $("#cvsarea").append(div);

    tempCtx.save();
    tempCtx.scale(RATIO, RATIO);
    //tempCtx.globalAlpha = 0.2;
    var p;
    if(p = getImageBySrc(this.source.src))
        tempCtx.drawImage(p, this.parent? this.parent.left + this.left : this.left,
            this.parent? this.parent.top + this.top : this.top,
            this.width, this.height);

    tempCtx.restore();
    drawInfo.source = this.source;

    Rect.showDetail(this);

    $('#detailarea .libg').hide();

    showSelectedRect(this);
};

