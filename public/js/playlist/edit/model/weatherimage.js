function WeatherImage(left, top, right, bottom, tag, background, border, id, name, text, city, whichDay) {
    var args = Array.prototype.slice.call(arguments, 0);
    ImageRect.apply(this, args)
    this.type ='weatherImage';
    this.name = name || this.createName();
    this.tag = tag || '天气图片';
    this.url = '';
    this.city = '上海市';
    this.province = '上海市';
    this.text = text || '晴';
    this.whichDay = whichDay || "1";
    this.point = '';
}
extend(WeatherImage, ImageRect);

WeatherImage.prototype.showDetail = function() {
    var p = new this.constructor.superClass();
    var json = JSON.parse(JSON.stringify(this));
    json.type = p.type;
    var x = Rect.create(json);
    x.showDetail();

    var li = '<li class="input-group" ><span class="input-group-addon span-description">哪天：</span>'+$('#tmplWhichDay').html()+'</li>';
    $('#detailarea ul').append(li);
    $('#detailarea .selWhichDay').val(this.whichDay);

    //initPoint(this);
    initAddr(this);
}