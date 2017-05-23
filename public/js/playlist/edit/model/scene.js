function Scene(id, name, width, height, duration, children) {
    this.id = id;
    this.name = name || '';
    this.background = {color:"#ffffffff", image:'' };
    this.type = 'scene';
    this.duration = duration || '00:00:00';
    this.width = width || 0;
    this.height = height || 0;
    this.ratio = 1;
    this.children = children || [];
}
var imageTasks = [];
Scene.prototype.init = function(p) {
    relativePlaylist.children.push(this);

    for(var j = 0, jlen = p.children.length; j< jlen; j++) {
        var x = p.children[j]; //zone
        var zone = Rect.create(x);
        if(zone.source) {
            zone.source = new ImageInfo(zone.source.src, zone.source.width, zone.source.height);
            (function(zone){
                return initImg(zone);
            })(zone);
        }
        this.children.push(zone);

        if(zone.constructor == GroupZone) {
            for (var k = 0, klen = x.children.length; k < klen; k++) {
                var t = x.children[k];
                var rect = Rect.create(t);

                if(rect.source) {
                    rect.source = new ImageInfo(rect.source.src, rect.source.width, rect.source.height);
                    (function(rect){
                        return initImg(rect);
                    })(rect);
                }
                zone.children.push(rect);
            }
        }
    }
}

function createSceneId () {
    var i = 0;
    while(true) {
        var tempScene = _.find(relativePlaylist.children, function(scene) {
            return scene.name == 'scene'+i;
        });
        if(!tempScene) return i + '';

        i++;
    }
}

function RelativePlaylist(id, name , type, stamp, children) {
    this.id = id;
    this.stamp =stamp || new Date().getTime();
    this.name = name || 'relativePlaylist';
    this.type = type || 'relativePlaylist';
    this.children = children || [];
}

RelativePlaylist.prototype.init = function(p) {
    mediaSourceList.push(this);

    for(var j = 0, jlen = p.children.length; j< jlen; j++) {
        var x = p.children[j]; //media
        var media = MediaBase.create(x);
        this.children.push(media);
    }
}


RelativePlaylist.getAllElesByType = function(type) {
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



function createEleByObj(obj) {
    var ele = null;

    if(obj.type == 'scene') ele = new Scene();
    else ele = new RelativePlaylist();

    for(var name in obj) {
        ele[name] = obj[name];
    }

    ele.children = [];
    return ele;
}
