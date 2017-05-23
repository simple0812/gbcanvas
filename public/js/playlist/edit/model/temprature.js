function Temperature(left, top, right, bottom, tag, border, id, name,  text) {
    var args = Array.prototype.slice.call(arguments, 0);
    TextRect.apply(this,args);
    this.type = 'temperature';
    this.name = name || this.createName();
    this.width = 50;
    this.height = 30;
    this.city = '上海市';
    this.province = '上海市';
    this.text = '30℃';
    this.style = 'max';
    this.point = '';
    this.whichDay = "1";
    this.editEnable = false;
}

extend(Temperature, TextRect);

Temperature.prototype.showDetail = function() {
    var p = new this.constructor.superClass();
    var json = JSON.parse(JSON.stringify(this));
    json.type = p.type;
    var x = Rect.create(json);
    x.showDetail();
    $('#detailarea ul li').last().children('input').attr('disabled', 'disabled');

    var li = '<li class="input-group"><span class="input-group-addon span-description">哪天：</span>'+$('#tmplWhichDay').html()+'</li>';
    $('#detailarea ul').append(li);
    $('#detailarea .selWhichDay').val(this.whichDay);

    var li = '<li class="input-group" ><span class="input-group-addon span-description">温度：</span>'+$('#tmplTempStyle').html()+'</li>';
    $('#detailarea ul').append(li);
    $('#detailarea .selTempStyle').val(this.style);
//    initPoint(this);
    initAddr(this);
}