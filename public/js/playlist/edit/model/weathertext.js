function WeatherText(left, top, right, bottom, tag, border, id, name,  text) {
    var args = Array.prototype.slice.call(arguments, 0);
    TextRect.apply(this,args);
    this.type = 'weatherText';
    this.name = name || this.createName();
    this.width = 200;
    this.height = 30;
    this.city = '上海市';
    this.province = '上海市';
    this.whichDay = '1';
    this.text = '晴转多云';
    this.point = '';
    this.editEnable = false;
}

extend(WeatherText, TextRect);

WeatherText.prototype.showDetail = function() {
    var p = new this.constructor.superClass();
    var json = JSON.parse(JSON.stringify(this));
    json.type = p.type;
    var x = Rect.create(json);
    x.showDetail();
    $('#detailarea ul li').last().children('input').attr('disabled', 'disabled');
    var li = '<li class="input-group"><span class="input-group-addon span-description">哪天：</span>'+$('#tmplWhichDay').html()+'</li>';
    $('#detailarea ul').append(li);
    $('#detailarea .selWhichDay').val(this.whichDay);

    //initPoint(this);
    initAddr(this);
}

