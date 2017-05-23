function Rect(left, top, right, bottom, tag, background, border, id, name) {
    this.left =  Math.min(left, right);
    this.top = Math.min(top, bottom);
    this.right = Math.max(left, right);
    this.bottom = Math.max(top, bottom);

    this.id = id || Guid.NewGuid().toString();
    this.type = 'rect';
    this.name = name || this.createName();
    this.width = (this.right - this.left);
    this.height = (this.bottom - this.top);
    this.tag = tag || '矩形';
    this.isSelected = false;
    this.background = background || '';
    this.border = border || 'yellow';
    this.opacity = 1;
    this.coverLevel = 1;//1 mediazone mediarect, 2 groupzone normalrect 3 image text ...
}

Rect.prototype.changePlace = function(targetRect) {
    this.left = targetRect.left;
    this.top = targetRect.top;
    this.right = targetRect.right;
    this.bottom = targetRect.bottom;
    this.width = targetRect.width;
    this.height = targetRect.height;

    return this;
}

Rect.prototype.clone = function(){
    return deepClone(this);
}


Rect.prototype.movesTo = function(left, top) {
    this.left = left;
    this.top = top;
    this.right = this.left + this.width;
    this.bottom = this.top + this.height;
    return this;
}

Rect.prototype.format = function() {
    var left = this.left;
    var top = this.top;
    var right = this.right;
    var bottom = this.bottom;

    this.left =  Math.min(left, right);
    this.top = Math.min(top, bottom);
    this.right = Math.max(left, right);
    this.bottom = Math.max(top, bottom);

    this.width = this.right - this.left;
    this.height = this.bottom - this.top;
    return this;
}

Rect.prototype.moveEndPointTo = function(right, bottom) {
    this.right = right;
    this.bottom = bottom;
    this.width = this.right - this.left;
    this.height = this.bottom - this.top;
    return this;
}

Rect.prototype.switchRatio = function(ratio, origRatio) {
    this.left *= (ratio / origRatio);
    this.top *= (ratio / origRatio);
    this.right *= (ratio / origRatio);
    this.bottom *= (ratio / origRatio);
    this.width *= (ratio / origRatio);
    this.height *= (ratio / origRatio);
    if(this.source) {
        this.source.width *= (ratio / origRatio);
        this.source.height *= (ratio / origRatio);
    }

    return this;
}

Rect.prototype.cloneAttrTo = function(target) {
    var tempRect = clone(this);
    return tempRect.changePlace(target);
}

Rect.prototype.showDetail = function() {
    showSelectedRect(this);

    var temp = $('#detail').html().format(this.tag, this.background.color ? this.background.color : this.background,
        this.border, this.width.toFixed(2) , this.height.toFixed(2) ,
        this.left.toFixed(2) , this.top.toFixed(2), this.elements || this.source || 'none')
    $('#detailarea').html(temp);
}

Rect.showDetail = function(rect) {
    var temp = $('#detail').html().format('', rect.background.color ? rect.background.color : rect.background,
        rect.border, (rect.width).toFixed(2) , (rect.height ).toFixed(2) ,
        (rect.left).toFixed(2) , (rect.top).toFixed(2), rect.elements || rect.source || 'none')

    $('#detailarea').html(temp);
    $('#detailarea .componenttag').val(rect.tag);
}

Rect.create = function(obj) {
    if(!obj || !obj.type) return new Rect();

    var rect = getRectByType(obj.type);

    for(var name in obj) {
        rect[name] = obj[name];
    }

     if(rect.children) rect.children = [];

    return rect;
};

Rect.prototype.copy = function() {
    var obj = this.clone();

    var rect = getRectByType(obj.type);

    for(var name in obj) {
        rect[name] = obj[name];
    }

    return rect;
};


Rect.prototype.getAllSameComponent = function() {
    var temp = [];
    var currScene = relativePlaylist.children[viewIndex];

    for(var i = 0, len = currScene.children.length; i< len ; i++) {
        if(currScene.children[i].type == this.type) temp.push(currScene.children[i]);
        else if(currScene.children[i].constructor == GroupZone) {
            for(var j = 0, jlen = currScene.children[i].children.length; j< jlen; j++) {
                if(currScene.children[i].children[j].type == this.type) temp.push(currScene.children[i].children[j]);
            }
        }
    }

    return temp;
}

Rect.prototype.createName = function () {
    var i = 0;
    var x = this.getAllSameComponent();
    var that = this;
    while(true) {
        var temp = _.find(x, function(rect) {
            return rect.name == that.type + i;
        });
        if(!temp) return this.type + i;

        i++;
    }
}


Rect.getAllSameComponentByType = function(type) {
    var temp = [];
    var currScene = relativePlaylist.children[viewIndex];

    for(var i = 0, len = currScene.children.length; i< len ; i++) {
        if(currScene.children[i].type == type) temp.push(currScene.children[i]);
        else if(currScene.children[i].constructor == GroupZone) {
            for(var j = 0, jlen = currScene.children[i].children.length; j< jlen; j++) {
                if(currScene.children[i].children[j].type == type) temp.push(currScene.children[i].children[j]);
            }
        }
    }

    return temp;
}


function getRectByType(type) {
    switch (type) {
        case 'groupZone': return new GroupZone(); break;
        case 'mediaZone': return new MediaZone(); break;
        case 'dateTime': return new DateTimeText(); break;
        case 'weatherText': return new WeatherText(); break;
        case 'weatherImage': return new WeatherImage(); break;
        case 'temperature': return new Temperature(); break;
        case 'airQualityLevel': return new AirQualityLevel(); break;
        case 'airQualityPm25': return new AirQualityPm(); break;
        case 'image': return new ImageRect(); break;
        case 'text': return new TextRect(); break;
        case 'marquee': return new Marquee(); break;
        case 'clock': return new Clock(); break;
        default: return new ImageRect();
    }
}

function getMediaSourceById(id) {
    return _.find(mediaSourceList, function(each) {
        return each.id == id;
    });
}

function delMediaSourceById(id) {
    mediaSourceList = _.without(mediaSourceList, getMediaSourceById(id));
}