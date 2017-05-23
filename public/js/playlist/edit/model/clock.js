function Clock(left, top, right, bottom, tag, background, border, id, name, style) {
    var args = Array.prototype.slice.call(arguments, 0);
    ImageRect.apply(this, args)
    this.type ='clock';
    this.name = name || this.createName();
    this.tag = tag || '图片';
    this.width = 150;
    this.height = 150;
    this.style = style || '简单时钟';
}
extend(Clock, ImageRect);

Clock.prototype.showDetail = function() {
    var p = new this.constructor.superClass();

    var json = JSON.parse(JSON.stringify(this));
    json.type = p.type;
    var x = Rect.create(json);
    x.showDetail();

    //p.showDetail.call(this); //maybe better

    $('#detailarea ul li').last().hide();
    var li = '<li class="input-group" ><span class="input-group-addon span-description">样式：</span>'+$('#tmplClockStyle').html()+'</li>';
    $('#detailarea ul').append(li);

    $('#detailarea .selClockStyle').val(this.style);
}

