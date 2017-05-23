function MediaBase(id, name, type, url, duration) {
    this.id = id || Guid.NewGuid().toString();
    this.name = name || 'meida';
    this.type = type || '';
    this.url = url || null;
    this.duration = duration || '00:00:30';
}


/*Picture start*/
function Picture(id, name, type, url, duration) {
    var args = Array.prototype.slice.call(arguments, 0);
    MediaBase.apply(this, args)
    this.name = 'picture';
    this.type = 'picture';
    this.in = '0';
    this.out = '0';
}
extend(Picture, MediaBase);
/*Picture end*/

/*Video start*/
function Video(id, name, type, url, duration) {
    var args = Array.prototype.slice.call(arguments, 0);
    MediaBase.apply(this, args)
    this.name = 'video';
    this.type = 'video';
}
extend(Video, MediaBase);
/*Video end*/

/*Web start*/
function Web(id, name, type, url, duration) {
    var args = Array.prototype.slice.call(arguments, 0);
    MediaBase.apply(this, args)
    this.name = 'web';
    this.type = 'web';
}
extend(Web, MediaBase);
/*Web end*/

/*MediaStream start*/
function MediaStream(id, name, type, url, duration) {
    var args = Array.prototype.slice.call(arguments, 0);
    MediaBase.apply(this, args)
    this.name = 'mstream';
    this.type = 'mstream';
}
extend(MediaStream, MediaBase);
/*MediaStream end*/

/*MediaStream start*/
function ImageSlide(id, name, type, url, duration) {
    var args = Array.prototype.slice.call(arguments, 0);
    MediaBase.apply(this, args)
    this.name = 'imageSlide';
    this.type = 'imageSlide';
}
extend(ImageSlide, MediaBase);
/*MediaStream end*/

function PPT(id, name, type, url, duration) {
    var args = Array.prototype.slice.call(arguments, 0);
    MediaBase.apply(this, args)
    this.name = 'ppt';
    this.type = 'ppt';
}
extend(PPT, MediaBase);
/*MediaStream end*/

MediaBase.create = function(obj) {
    if(!obj || !obj.type) return new MediaBase();

    var media = getMediaByType(obj.type);

    for(var name in obj) {
        media[name] = obj[name];
    }

    if(media.children) media.children = [];
    return media;
};

MediaBase.duration = {
    format: function(time) {
        var hour = Math.floor(time/3600);
        var p = time % 3600;
        var min = Math.floor(p/60);
        var sec = p % 60;

        return String.format('{0}:{1}:{2}',
            hour > 9 ? hour : '0'+ hour,
            min > 9 ? min : '0'+ min,
            sec > 9 ? sec : '0'+ sec
        );

    },
    parse: function(duration) {
        if(duration.indexOf(':') == -1) return parseInt(duration);
        var p = duration.split(':');
        var hour = parseInt(p[0]);
        var min = parseInt(p[1]);
        var sec = parseInt(p[2]);

        return hour * 3600 + min * 60 + sec;
    }
};




function getMediaByType(type) {
    switch (type) {
        case 'picture': return new Picture(); break;
        case 'video': return new Video(); break;
        case 'web': return new Web(); break;
        case 'mstream': return new MediaStream(); break;
        case 'imageSlide' : return new ImageSlide(); break;
        case 'ppt': return new PPT(); break
        default: return null;
    }
}
