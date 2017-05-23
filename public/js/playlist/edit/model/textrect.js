function TextRect(left, top, right, bottom, tag, border, id, name,  text) {
    var args = Array.prototype.slice.call(arguments, 0);
    Rect.apply(this,args);
    this.type ='text';
    this.name = name || this.createName();
    this.coverLevel = 3;
    this.background = '#ffffffff';
    this.text = text || '请输入文字';
    this.border = border || '#ffffffff';
    this.tag = text || '文字区';
    this.foreground = '#ff333333';
    this.fontSize = 14;
    this.fontFamily = '宋体';
    this.parent = null;
    this.width = 200;
    this.height = 200;
    this.editEnable = true;
}
extend(TextRect, Rect);

TextRect.prototype.render = function() {
    $('#compnentindex').append($('#tmplOther').html().format(this.tag));
    $('#compnentindex li').last().children('div').children('b').html('字');

    if(this.isSelected) return $('#compnentindex li').last().children('div').addClass('selected');

    ctx.save();
    ctx.scale(RATIO, RATIO);
    ctx.globalAlpha = this.opacity;

    if(this.background) {
        ctx.fillStyle = hexToRgb(this.background);
        ctx.fillRect(this.left, this.top, this.right - this.left,this.bottom - this.top);
    }


    wrapText(ctx,this.text, this.left, this.top,  this.fontSize+'px '+ this.fontFamily,
       hexToRgb(this.foreground), this.width, this.height, parseInt(this.fontSize));
    ctx.restore();
};


TextRect.prototype.renderAsChild = function() {
    if($('#compnentindex').children('li').last().children('ol').length == 0)
        $('#compnentindex').children('li').last().append('<ol draggable="false"></ol>');

    $('#compnentindex ol').last().append($('#tmplOther').html().format(this.tag));
    $('#compnentindex li').last().children('div').children('b').html('字');

    if(this.isSelected) return $('#compnentindex li').last().children('div').addClass('selected');

    ctx.save();
    ctx.scale(RATIO, RATIO);
    var cutLeft = Math.max(this.parent.left, this.left + this.parent.left) + 1;
    var cutTop = Math.max(this.parent.top, this.top + this.parent.top) + 1;
    var cutRight = Math.min(this.parent.right, this.left + this.parent.left + this.width) -1;
    var cutBottom = Math.min(this.parent.bottom, this.top + this.parent.top + this.height) -1;
    cutRight = cutRight < 0 ? 0 : cutRight;
    cutBottom = cutBottom < 0 ? 0 : cutBottom;

    ctx.rect(cutLeft ,cutTop, cutRight-cutLeft, cutBottom-cutTop);
    ctx.clip();
    if(this.background) {
        ctx.fillStyle = hexToRgb(this.background);
        ctx.fillRect(cutLeft,cutTop, cutRight-cutLeft, cutBottom-cutTop);
    }

    wrapText(ctx,this.text, this.left + this.parent.left, this.parent.top + this.top ,
        this.fontSize+'px '+ this.fontFamily, hexToRgb(this.foreground),  this.width, this.height, parseInt(this.fontSize));
    ctx.restore();

};

TextRect.prototype.stroke = function() {
    var that = this;
    var tempRect;// normalrect

    if( tempRect = checkRectIsCoverRects(this, 3)) {
        //如果图片没有移出他的面板则不判断
        if((this.parent && checkRectIsCoverRect(this.parent, this))) {
            updateRects(this);
        } else {
            removeRect(drawInfo.operRect);
            tempRect.setChildrenRect(this);
        }
    } else if(this.parent) { //图片从面板移到画板中
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



TextRect.prototype.showDetail = function() {

    var text = document.createElement('textarea');
    text.type = 'text';
    text.innerHTML = this.text;
    text.className = 'movediv';
    text.placeholder="请输入文字";
    var _this = this;

    var top = (this.parent? (this.parent.top + this.top) * RATIO : this.top * RATIO) + TRANSLATE.y;
    var left = (this.parent? (this.parent.left + this.left) * RATIO : this.left * RATIO) + TRANSLATE.x;

    $(text).css({'top': top, color:hexToRgb(this.foreground),'left':  left , 'width':this.width * RATIO, 'height':this.height * RATIO,
        fontSize:parseInt(this.fontSize) * RATIO, fontFamily: this.fontFamily, cursor:'move'}).attr('readonly','readonly');

    $('#cvsarea').append(text);

    $(text).on('input', function() {
        drawInfo.operRect.text = $(this).val();
    });

    $(text).on('dblclick', function(e) {
        console.log(_this.editEnable);
        if(!_this.editEnable) return;
        $(text).removeAttr('readonly').css('cursor','text');
        var length = $(text).val().length;
        setSelectRange(text, length, length)
    });

    Rect.showDetail(this);

    $('#detailarea ul').append($('#tmplText').html().format(this.foreground, this.fontSize, this.fontFamily, ""));
    $('.txtValue').val(this.text);
    $('.movediv').css('background', hexToRgb(this.background));
    $('#detailarea .selFontFamily').val(this.fontFamily);
    showSelectedRect(this);
    initColorPicker();
};





