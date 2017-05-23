function ImageInfo(src, width, height) {
    this.src = src;
    this.width = width;
    this.height = height;
}

ImageInfo.prototype.clone = function() {
    var img = new ImageInfo(this.src, this.width, this.height);
    return img;
}

var IMAGES = []; //{src:'', image:object}

function getImageBySrc(src) {
    var p = _.find(IMAGES, function(each) {
        return each.src == src;
    });

    if(p) return p.image;
    return null;
}


function loadImg(rect) {
    var img = new Image();
    img.onload = function() {
        ctx.drawImage(img, rect.left, rect.top, rect.right - rect.left, rect.bottom - rect.top);
        IMAGES.push({src:rect.source.src, image:img});
    }
    img.src = rect.source.src;
}