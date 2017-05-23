function Marquee(left, top, right, bottom, tag, border, id, name,  text) {
    var args = Array.prototype.slice.call(arguments, 0);
    TextRect.apply(this,args);
    this.type = 'marquee';
    this.name = name || this.createName();
    this.width = 500;
    this.height = 40;
    this.text = '字幕';
    this.direction = 'rightToLeft'; //'leftToRight';
    this.speed = '1';
    this.editEnable = true;
}

extend(Marquee, TextRect);

Marquee.prototype.showDetail = function() {
    var p = new this.constructor.superClass();
    var json = JSON.parse(JSON.stringify(this));
    json.type = p.type;
    var x = Rect.create(json);
    x.showDetail();

    var dir = '<li class="input-group"><span class="input-group-addon span-description">方向：</span>'+$('#tmplDirection').html()+'</li>';
    var speed = '<li class="input-group"><span class="input-group-addon span-description">速度：</span>'+$('#tmplSpeed').html()+'</li>';
    $('#detailarea ul').append(dir);
    $('#detailarea ul').append(speed);

    $('.selDirection').val(this.direction);
    $('.selSpeed').val(this.speed);

    $('#detailarea .selDateTime').val(this.style);
};
