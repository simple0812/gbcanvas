function MediaZone( left, top, right, bottom, tag, background, border, id, name, playlist, duration) {
    var args = Array.prototype.slice.call(arguments, 0);
    Rect.apply(this,args);
    this.type = 'mediaZone';
    this.name = name || this.createName();
    this.coverLevel = 1;
    this.border = border || 'blue';
    this.background = {color:'#ff000000', image:''} //'#ff000000';
    this.duration = duration || '00:00:00';
    this.tag = tag || '媒体区';
    this.playlist = playlist || null;
    this.width = 200;
    this.height = 200;
}
extend(MediaZone, Rect);

function MediaElements(src, tag, transform, interval) {
    this.src = src;
    this.tag = tag;
    this.transform = transform;
    this.interval = interval;
}

MediaZone.prototype.render = function() {
    $('#compnentindex').append($('#tmplOther').html().format(this.tag));
    $('#compnentindex li').last().children('div').children('b').css('background','#000');

    if(this.isSelected) return $('#compnentindex li').last().children('div').addClass('selected');

    ctx.save();
    ctx.scale(RATIO, RATIO);
    ctx.globalAlpha = this.opacity;
    ctx.fillStyle = this.background.color;
    //ctx.lineWidth = 2;
    //ctx.strokeStyle = this.border;
    ctx.fillRect(this.left, this.top, this.right - this.left,this.bottom - this.top);
    //ctx.strokeRect(this.left, this.top, this.right - this.left,this.bottom - this.top);
    ctx.restore();

};

MediaZone.prototype.copy = function() {
    var obj = this.clone();

    var rect = getRectByType(obj.type);

    for(var name in obj) {
        rect[name] = obj[name];
    }

    var tmp = new RelativePlaylist(Guid.NewGuid().toString(), 'relativePlaylist',
        'relativePlaylist', new Date().getTime().toString());

    var x = getMediaSourceById(rect.playlist);
    tmp.children = deepClone(x.children);
    mediaSourceList.push(tmp);
    rect.playlist = tmp.id;

    return rect;
};

MediaZone.prototype.stroke = function() {
    this.addPlaylist();
    updateRects(this);
};

MediaZone.prototype.addPlaylist = function() {
    if(!this.playlist) {
        var tmp = new RelativePlaylist(Guid.NewGuid().toString(), 'relativePlaylist', 'relativePlaylist', new Date().getTime().toString());
        if(!getMediaSourceById(tmp.id)) mediaSourceList.push(tmp);
        this.playlist = tmp.id
    }
};

MediaZone.prototype.delElements = function(index) {
    var rpl = getMediaSourceById(this.playlist);
    rpl.children.removeAt(index);
};

//flag: 0: right , 1: left
MediaZone.prototype.switchElePlace = function(index, flag) {

    var rpl = getMediaSourceById(this.playlist);
    if(!rpl || rpl.children.length == 0) return false;

    if(flag <= 0) {
        if(index == 0) return false;

    } else {
        if(index == rpl.children.length -1) return false;
        index += 1
    }

    var origEle = rpl.children[index];
    var targetEle = rpl.children[index - 1];
    rpl.children[index -1] = origEle;
    rpl.children[index] = targetEle;
    return true;
};

MediaZone.prototype.addElements = function(mediaEle) {
    this.elements.push(mediaEle);
};

MediaZone.prototype.showDetail = function() {
    var div = document.createElement('div');
    $(div).addClass('movediv');
    var top = this.top * RATIO + TRANSLATE.y;
    var left = this.left*RATIO + TRANSLATE.x;

    $(div).css({top:top, left:left, cursor:'move', width:this.width * RATIO, height:this.height * RATIO, background:'#000'});
    $("#cvsarea").append(div);
    $('#detailarea .libg').children().attr('disabled', 'disabled');
    $('#detailarea .lielements ul').empty();

    var mediaList = getMediaSourceById(this.playlist);

    Rect.showDetail(this);

    $('#detailarea .libg').hide();
    $('#detailarea ul').append($('#tmplPlaylistsLink').html().format(this.duration, mediaList.children.length));
    //$('#detailarea ul').append($('#tmplMeidaPlaylist').html());
    showMediaPlaylist(mediaList);
    showSelectedRect(this);
};

