function AirQualityLevel(left, top, right, bottom, tag, border, id, name,  text) {
    var args = Array.prototype.slice.call(arguments, 0);
    TextRect.apply(this,args);
    this.type = 'airQualityLevel';
    this.name = name || this.createName();
    this.width = 160;
    this.height = 30;
    this.city = '上海市';
    this.province = '上海市';
    this.text = '轻度污染';
    this.point = '';
    this.editEnable = false;
}

extend(AirQualityLevel, TextRect);


function AirQualityPm(left, top, right, bottom, tag, border, id, name,  text) {
    var args = Array.prototype.slice.call(arguments, 0);
    TextRect.apply(this,args);
    this.type = 'airQualityPm25';
    this.name = name || this.createName();
    this.width = 100;
    this.height = 30;
    this.city = '上海市';
    this.province = '上海市';
    this.text = '200';
    this.point = '';
    this.editEnable = false;
}

extend(AirQualityPm, TextRect);

AirQualityLevel.prototype.showDetail = function() {
    var p = new this.constructor.superClass();
    var json = JSON.parse(JSON.stringify(this));
    json.type = p.type;
    var x = Rect.create(json);
    x.showDetail();
    $('#detailarea ul li').last().children('input').attr('disabled', 'disabled');
    initPoint(this);
    initAddr(this);
}


AirQualityPm.prototype.showDetail = function() {
    var p = new this.constructor.superClass();
    var json = JSON.parse(JSON.stringify(this));
    json.type = p.type;
    var x = Rect.create(json);
    x.showDetail();
    $('#detailarea ul li').last().children('input').attr('disabled', 'disabled');
    initPoint(this);
    initAddr(this);
}