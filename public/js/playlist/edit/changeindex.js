var origEle = null;
function infoDragStart(e) {
    e = e || window.event;
    var target = e.target || e.srcElement;
	e.effectAllowed = 'move';
    var origIndex = -1;
    var childIndex = -1;

    //拖拽子元素
    if($(target).parent().parent('ol').length > 0) {
        origIndex = $('#compnentindex').children('li').index($(target).parent().parent().parent());
        childIndex = $(target).parent().parent().children('li').index($(target).parent());
    } else {
        origIndex = $(target).parent().parent().children('li').index($(target).parent());
    }

    e.dataTransfer.setData('TEXT', origIndex+',' + childIndex);
    origEle = target;
}
function infoDrag() {
}
function infoDragEnd(e) {
    e = e || window.event;
    origEle = null;
}

function infoDragEnter() {
    return true;
}

function infoDragOver(e) {
    e.preventDefault();
    return true;
}

function infoDrop(e) {
    e = e || window.event;
    var target = e.target || e.srcElement;

    if(target.nodeName.toLowerCase() == 'img' || target.nodeName.toLowerCase() == 'b' || target.nodeName.toLowerCase() == 'span')
        target = target.parentNode;

    var index = e.dataTransfer.getData('TEXT');
    if(!index || index.indexOf(',') == -1) return cancelDefaultEvent(e);
    var origIndex = index.split(',')[0];
    var childIndex = index.split(',')[1];
    var currParentIndex = -1;
    var currIndex = $(target).parent().parent().children('li').index($(target).parent());
    var tempRect = null;

    //子元素拖放到子元素
    if($(target).parent().parent('ol').length > 0) {

        //如果拖放的元素不在同一个父元素中则返回
        currParentIndex = $('#compnentindex').children('li').index($(target).parent().parent().parent());
        if(currParentIndex != origIndex) return cancelDefaultEvent(e);

        tempRect = relativePlaylist.children[viewIndex].children[origIndex].children[childIndex];
        if(!tempRect.parent) return cancelDefaultEvent(e);
        relativePlaylist.children[viewIndex].children[origIndex].children.splice(childIndex, 1)
        if(origIndex > currIndex) currIndex ++;
        relativePlaylist.children[viewIndex].children[origIndex].children.splice(currIndex, 0, tempRect);
        render();
    } else { //父元素拖放到父元素
        tempRect = relativePlaylist.children[viewIndex].children[origIndex];
        relativePlaylist.children[viewIndex].children.splice(origIndex, 1)
        if(origIndex > currIndex) currIndex ++;
        relativePlaylist.children[viewIndex].children.splice(currIndex, 0, tempRect);
        render();
    }

    return cancelDefaultEvent(e);
}
