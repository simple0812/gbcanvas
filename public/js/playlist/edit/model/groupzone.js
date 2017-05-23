function GroupZone( left, top, right, bottom, tag, background, border,  id, name, children) {
    var args = Array.prototype.slice.call(arguments, 0);
    Rect.apply(this, args)
    this.type = 'groupZone';
    this.name = name || this.createName();
    this.coverLevel = 2;
    this.border = border || 'green';
    this.tag = tag || '面板区';
    this.children = children ||  [];
    this.background = {color:'#ffffffff', image: ''};
    this.width = 200;
    this.height = 200;
}
extend(GroupZone, Rect);

GroupZone.prototype.getSelectedChild = function() {
    return _.find(this.children, function(child) { return child.isSelected == true});
}

GroupZone.prototype.setChildrenRect = function(childRect) {
    var selChild = this.getSelectedChild();

    childRect.left = childRect.left - this.left;
    childRect.top = childRect.top - this.top;
    childRect.right = childRect.left + childRect.width;
    childRect.bottom = childRect.top + childRect.height;

    childRect.isSelected = false;
    childRect.parent = new Rect().changePlace(this);

    if(selChild) {
        selChild = selChild.changePlace(childRect);
        selChild.isSelected = false;
    }
    else this.children.push(childRect);

    return this;
}

GroupZone.prototype.renderChildren = function() {
    for(var i = 0, len = this.children.length; i < len ; i++) {
        var childRect = this.children[i];
        childRect.parent = new Rect().changePlace(this);

        childRect = this.children[i] = childRect.changePlace(new Rect(childRect.left, childRect.top,
            childRect.left + childRect.width, childRect.top + childRect.height
        ));

        if(childRect.coverLevel == 3 && checkRectIsCoverRect(this, childRect)) {
            childRect.renderAsChild();
        }

    }
}

GroupZone.prototype.render = function() {
    $('#compnentindex').append($('#tmplOther').html().format(this.tag));

    if(this.isSelected) {
        $('#compnentindex li').last().children('div').addClass('selected');
    } else {
        ctx.save();
        ctx.scale(RATIO, RATIO);
        ctx.globalAlpha = this.opacity;

        ctx.lineWidth = 2;
        ctx.strokeStyle = this.border;
        // ctx.fillRect(this.left, this.top, this.right - this.left,this.bottom - this.top);
        if(this.background.image) {
            var that = this;
            var img = new Image();
            img.onload = function() {
                ctx.save();
                ctx.scale(RATIO, RATIO);
                ctx.globalCompositeOperation="destination-over";
                ctx.drawImage(img, that.left, that.top, that.width, that.height);
                ctx.restore();
            }
            img.src = this.background.image;
        } else {
            ctx.fillStyle = hexToRgb(this.background.color);
            ctx.fillRect(this.left, this.top, this.right - this.left,this.bottom - this.top);
        }
        ctx.strokeRect(this.left, this.top, this.right - this.left,this.bottom - this.top);
        ctx.restore();

    }

    this.renderChildren();
}

GroupZone.prototype.stroke = function() {

    var rects = getRectsInGroupZone(this);
    var _this = this;

    //将以前不是子元素而当前移入到分组区域内的元素添加到当前分组区域
    for(var i = rects.length -1; i >= 0 ; i--) {
        var tempRect = rects[i]; //为图片或者文字等组件
        if(!(tempRect.parent)) { //组件不是当前面板的子元素则添加
            this.setChildrenRect(tempRect);
            removeRect(tempRect); //将组件移动到面板后 要将画板中的组件删除
        }
    }

    updateRects(this);
};

GroupZone.prototype.copy = function() {
    var obj = this.clone();

    var rect = getRectByType(obj.type);

    for(var name in obj) {
        if(name == 'children') {
            rect[name] = [];
            for(var i = 0, len = obj[name].length; i< len; i++) {
                rect[name].push(Rect.create(obj[name][i]))
            }
        }
        else rect[name] = obj[name];
    }

    return rect;
};

GroupZone.prototype.showDetail = function() {
    var div = document.createElement('div');
    $(div).addClass('movediv');
    var top = this.top * RATIO + TRANSLATE.y;
    var left = this.left*RATIO + TRANSLATE.x;

    $(div).css({top:top + 1 , left:left + 1, cursor:'move', width:this.width*RATIO - 2,
        height:this.height*RATIO - 2, background:drawInfo.operRect.background.color});
    $("#cvsarea").append(div);

    if(this.background.image) $('.movediv').css({'background':'url("'+this.background.image+'") ','backgroundSize': '100% 100%'})
    else if(this.background.color) $('.movediv').css('background', hexToRgb(this.background.color));

    Rect.showDetail(this);

    $('#detailarea ul').append('<li class="input-group" ><span class="input-group-addon span-description">背景图片：</span><input type="text" class="form-control" id="txtGroupzoneBgImage" onclick="showMediaList(this, \'groupZone\')" '+
        ' onfocus="$(this).blur()"  value="'+ this.background.image +'" />' +
        '<span  class="input-group-addon" style="cursor:pointer" onclick="delGroupZoneBgImage(this)" >清空</span></li>')

    showSelectedRect(this);
    initColorPicker();
}