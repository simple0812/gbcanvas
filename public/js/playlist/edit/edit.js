function  updateTag(obj) {
    if(!drawInfo.operRect) return;

    var tag =  $(obj).prev().val().trim();

    if(tag == '') return;

    drawInfo.operRect.tag =tag;
    render();
    renderUpdate();
}

function  updateBg(obj) {
    if(!drawInfo.operRect) return;

    var bg =  rgbToHex($("#detailarea .txtBgColor").spectrum("get"));
    if(bg == 'no' || bg == 'none') bg = ''
    //if(bg == '') return;
    if(drawInfo.operRect.background.color) drawInfo.operRect.background.color = bg;
    else drawInfo.operRect.background = bg;
    render();
    renderUpdate();
}

function updateFontColor(obj) {
    if(!drawInfo.operRect) return;

    var color =  rgbToHex($("#detailarea .txtForeColor").spectrum("get"));
    if(color == '') return;
    drawInfo.operRect.foreground = color;
    render();
    renderUpdate();
}

function updateFontSize(obj) {
    if(!drawInfo.operRect) return;

    var size = $(obj).prev().val().trim();
    if(size == '') return;

    if(!size.match(/^\d+(\.\d+)?$/ig)) return popBy($(obj).prev(), false, '格式不正确') //alert('格式不正确');

    drawInfo.operRect.fontSize = size;
    render();
    renderUpdate();
}

function updateText(obj) {
    if(!drawInfo.operRect) return;

    var txt = $(obj).prev().val().trim();
    if(txt == '') return;

    drawInfo.operRect.text = txt;
    render();
    renderUpdate();
}

function updateFontFamily(obj) {
    if(!drawInfo.operRect) return;

    var family = $(obj).val().trim();
    if(family == '') return;
    drawInfo.operRect.fontFamily = family;
    render();
    renderUpdate();
}

function  updateBorder(obj) {
    if(!drawInfo.operRect) return;

    var border = $(obj).prev().val().trim();
    if(border == '') return;

    drawInfo.operRect.border = border;
    render();
}

function  updateWidth(obj) {
    if(!drawInfo.operRect) return;

    var width = $(obj).prev().val().trim();
    if(width == '') return;

    if(!width.match(/^\d+(\.\d+)?$/ig)) return  popBy($(obj).prev(), false, '格式不正确')//alert('格式不正确');

    width = parseFloat(width);
    render();

    drawInfo.operRect.right = drawInfo.operRect.left + width;
    drawInfo.operRect.width = width;

    renderUpdate();
}

function  updateHeight(obj) {
    if(!drawInfo.operRect) return;

    var height = $(obj).prev().val().trim();
    if(height == '') return;
    if(!height.match(/^\d+(\.\d+)?$/ig)) return  popBy($(obj).prev(), false, '格式不正确')//alert('格式不正确');

    height = parseFloat(height);
    render();

    drawInfo.operRect.bottom = drawInfo.operRect.top + height;
    drawInfo.operRect.height = height;

    renderUpdate();
}

function  updateSx(obj) {
    if(!drawInfo.operRect) return;

    var left = $(obj).prev().val().trim();
    if(left == '') return;
    if(!left.match(/^-?\d+(\.\d+)?$/ig)) return  popBy($(obj).prev(), false, '格式不正确') //alert('格式不正确');
    left = parseFloat(left);

    drawInfo.operRect.left =  left;
    drawInfo.operRect.right =left+ drawInfo.operRect.width;

    renderUpdate();
}

function  updateSy(obj) {
    if(!drawInfo.operRect) return;

    var top = $(obj).prev().val().trim();
    if(top == '') return;
    if(!top.match(/^-?\d+(\.\d+)?$/ig)) return  popBy($(obj).prev(), false, '格式不正确') //alert('格式不正确');
    top = parseFloat(top);

    drawInfo.operRect.top =  top;
    drawInfo.operRect.bottom =  top + drawInfo.operRect.height;

    renderUpdate();
}

function switchElePlace(obj, flag) {
    if(!drawInfo.operRect ) return;
    if( $('.lielements .selectedele').length == 0) return;
    var index = $('#mediaElements').children().index($('.selectedele').parent());
    var ret = drawInfo.operRect.switchElePlace(index, flag);
    if(!ret) return;
    if(flag > 0) {
        $('.lielements .selectedele').parent().next().after($('.lielements .selectedele').parent());
        index ++;
    } else  {
        $('.lielements .selectedele').parent().prev().before($('.lielements .selectedele').parent());
        index --;
    }
    scrollMeidaElements(index, flag);
}


function scrollMeidaElements(index, flag) {
    var itemWidth = $('#mediaElements').children().width() + 5;
    var clientWidth = $('#mediaElements').parent().get(0).clientWidth;
    var scrollLeft = $('#mediaElements').parent().get(0).scrollLeft;
    var scrollWidth = $('#mediaElements').parent().get(0).scrollWidth;
    var width = $('#mediaElements').width();

    index = flag > 0 ? index + 1 : index;
    var distance = index * itemWidth;

    if(distance > scrollLeft + clientWidth ) {
        $('#mediaElements').parent().get(0).scrollLeft = distance - clientWidth;
    }

    else if (distance < scrollLeft) {
        $('#mediaElements').parent().get(0).scrollLeft = distance;
    }
}

function downloadElement() {
    var id = $('#mediaElements .selectedele').data('id');
    var name = $('#mediaElements .selectedele').data('name');

    var ext = name.split('.').pop();
    console.log(id);
    if(!id) return;
    isSave = true;
    window.location.href = '/downloadfile/'+id + '.' + ext +'?filename='+ name;
    isSave = false;
}

function showEditMediaEleModal() {
    if(!drawInfo.operRect || !drawInfo.operRect.playlist) return;
    if($('.selectedele').length == 0) return alert('请选择需要编辑的元素');
    var rpl = getMediaSourceById(drawInfo.operRect.playlist);

    if($('.selectedele').length == 1) {
        var index = $('#mediaElements').children().index($('.selectedele').parent());
        var media = rpl.children[index];
        if(!media.duration) media.duration = "00:00:00";

        var p = media.duration.split(':');

        $('#txtItemDurationHour').val(p[0]);
        $('#txtItemDurationMin').val(p[1]);
        $('#txtItemDurationSec').val(p[2]);

        if(media.type == 'picture') {
            //$('#picFadeTime').show();
            $('#txtItemFadeIn').val(media.in);
            $('#txtItemFadeOut').val(media.out);
        }
//        else $('#picFadeTime').hide();
    }
//    else if($(".selectedele[mediaType = 'picture']").length) $('#picFadeTime').show();
//     else $('#picFadeTime').hide();

    $('#mediaItemModal').modal('show');
}

function editMediaItem() {
    if(!drawInfo.operRect || !drawInfo.operRect.playlist) return;
    if($('.selectedele').length == 0) return alert('请选择需要编辑的元素');
    var hour = $('#txtItemDurationHour').val().trim() || "0";
    var min = $('#txtItemDurationMin').val().trim() || "0";
    var sec = $('#txtItemDurationSec').val().trim() || "0";

    var reg = /^\d*$/;
    if(!reg.test(hour) || parseInt(hour)  > 24 || parseInt(hour) < 0) return alert('小时格式不正确');
    if(!reg.test(min) || parseInt(min) > 59 || parseInt(min) < 0) return alert('分钟格式不正确');
    if(!reg.test(sec) || parseInt(sec) > 59 || parseInt(sec) < 0) return alert('秒格式不正确');

    var duration = String.format('{0}:{1}:{2}', parseInt(hour) < 10 ? '0'+parseInt(hour) : parseInt(hour) ,
        parseInt(min) < 10 ? '0'+parseInt(min) : parseInt(min),
        parseInt(sec) < 10 ? '0'+parseInt(sec) : parseInt(sec));

    var rpl = getMediaSourceById(drawInfo.operRect.playlist);

    $('.selectedele').each(function(i, o) {
        var index = $('#mediaElements').children().index($(o).parent());
        var media = rpl.children[index];



        var currScene = relativePlaylist.children[viewIndex];
        var p = MediaBase.duration.parse(media.duration) ;
        var t = MediaBase.duration.parse(drawInfo.operRect.duration);
        var x = MediaBase.duration.parse(currScene.duration);
        if(t == x) currScene.duration = '00:00:00';

        if(media.type == 'picture') {
            var fadeIn = $('#txtItemFadeIn').val() || '0';
            var fadeOut = $('#txtItemFadeOut').val() || '0';

            if(!reg.test(fadeIn) || parseInt(fadeIn) < 0) return alert('渐入格式不正确');
            if(!reg.test(fadeOut) || parseInt(fadeOut) < 0) return alert('渐出格式不正确');
            if( parseInt(fadeIn)  + parseInt(fadeOut) > p) return alert('渐入渐出时间不能大于持续时间');

            media.in = parseInt(fadeIn);
            media.out = parseInt(fadeOut);
        }

        t += MediaBase.duration.parse(duration) -  p;
        media.duration = duration;

        drawInfo.operRect.duration = MediaBase.duration.format(t > 0 ? t : 0);
        $(o).find('.panel-title').html(duration);

        $('#mediaItemModal').modal('hide');
        $('#txtItemDurationHour').val('');
        $('#txtItemDurationMin').val('');
        $('#txtItemDurationSec').val('');
        $('#txtItemFadeIn').val('');
        $('#txtItemFadeOut').val('');
    });


    updateCurrSceneDuration();
}

function updateCurrSceneDuration() {
    var currScene= relativePlaylist.children[viewIndex];
    var p = MediaBase.duration.parse(currScene.duration);

    p = Math.max(p, getCurrSceneMediaMaxDuration());
    currScene.duration = MediaBase.duration.format(p);
    $('.span-duration').eq(viewIndex).html(currScene.duration);
}

function selectMediaEle(event, obj) {
    var e = event || window.event ;
    if(!e.shiftKey) $('.selectedele').removeClass('selectedele');

    if($(obj).hasClass('selectedele')) $(obj).removeClass('selectedele');
    else $(obj).addClass('selectedele');

    if($('.selectedele').length > 0) $('.btnMultOperate').removeAttr('disabled');
    else $('.btnMultOperate').attr('disabled', 'disabled');

    if($('.selectedele').length == 1) $('.btnSingleOperate').removeAttr('disabled');
    else $('.btnSingleOperate').attr('disabled', 'disabled');

    if($('.selectedele').length == 0) $('.btnMixOperate').attr('disabled', 'disabled');
    else if ($(".selectedele[mediaType='picture']").length == 0) $('.btnMixOperate').removeAttr('disabled');
    else if ($(".selectedele[mediaType='picture']").length == $(".selectedele").length)
        $('.btnMixOperate').removeAttr('disabled');
    else $('.btnMixOperate').attr('disabled', 'disabled');

}

function renderUpdate() {
    if( Math.abs( drawInfo.operRect.width) < 5 || Math.abs( drawInfo.operRect.height) < 5) {
        drawInfo.operRect.changePlace(drawInfo.origRect);
        return alert('矩形宽度或者高度太小');
    }

    if(checkRectIsOut(drawInfo.operRect)) {
        drawInfo.operRect.changePlace(drawInfo.origRect);
        return alert('矩形不在画板内');
    }
    var tempRect = null;
    if(checkRectIsCoverRects(drawInfo.operRect, 2)) {
        drawInfo.operRect.changePlace(drawInfo.origRect);
        return alert('矩形和其他矩形重合');
    }

    drawInfo.origRect = drawInfo.operRect.clone();
    drawInfo.origRect.isSelected = false;
    showDetail(drawInfo.operRect);
}

function showMediaList(event, editType) {
    event = event || window.event
    $('#mediaModal').modal('show');
    $('#btnEditScene').attr('editType', editType);
    cancelDefaultEvent(event);
}

function delElement(obj) {
    if(!drawInfo.operRect ) return;
    var currScene= relativePlaylist.children[viewIndex];
    var p = MediaBase.duration.parse(currScene.duration);
    var t = MediaBase.duration.parse(drawInfo.operRect.duration);
    var rpl = getMediaSourceById(drawInfo.operRect.playlist);

    if($('.selectedele').length == 0) return alert('请选择需要编辑的元素');
    if( $('.lielements .selectedele').length == 0) return;
    $('.lielements .selectedele').each(function(i, o) {
        var index = $('#mediaElements').children().index($(o).parent());
        var x = MediaBase.duration.parse(rpl.children[index].duration);
        drawInfo.operRect.delElements(index);
        $(o).parent().remove();

        if(p == t) currScene.duration = "00:00:00"; //如果场景duration为当前zone的duration 则重置场景duration
        t -= x;
        drawInfo.operRect.duration = MediaBase.duration.format(t);
    })

    updateCurrSceneDuration();

    //render();
    //renderUpdate();
}

function getCurrSceneMediaMaxDuration() {
    var currScene= relativePlaylist.children[viewIndex];
    var p = 0;
    for(var i = 0, len = currScene.children.length; i < len; i++) {
        var ele = currScene.children[i];
        if(ele.constructor == MediaZone) {
            var d = MediaBase.duration.parse(ele.duration);
            p = Math.max(p, d);
        }
    }

    return p;
}

function addMedia(obj) {
    if($('.mediaItemChk:checked').length == 0) return popBy('#btnEditSceneAdd', false, '请选择一个或者多个媒体元素');

    var editType = $('#btnEditScene').attr('editType');

    editMediaByType(editType);
    $(':checkbox').prop('checked', false);
}

function editMediaByType(flag) {
    if(flag == 'mediaZone') return updateMediaZonePlaylist();

    var currScene = relativePlaylist.children[viewIndex];
    var ret = 0;
    $('.mediaItemChk:checked').each(function(i, o) {
        var id = $(o).val();
        var type = $(o).attr('mediaType');
        var name = $(o).attr('mediaName');
        var url = $(o).attr('mediaUrl');
        var duration = $(o).attr('mediaDuration');

        if(type && type == 'picture') {
            if(flag == 'scene') $('#txtSceneBgPic').val(url);
            else if(flag == 'groupZone') {
                drawInfo.operRect.background.image = url;
                render();
                renderUpdate();
            } else if(flag == 'image') {
                $('#btnImageRect img').attr({'src': '/images/load.gif', 'title': name, 'draggable':'true'});

                var img = new Image();
                img.onload = function() {
                    IMAGES.push({src:url, image:img});
                    $('#btnImageRect img').attr('src', url);
                    changeDrawFlag($('#btnImageRect'), 'image');
                };
                img.src = url;
//                $('#btnImageRect img').attr({'src': url, 'title': name, 'draggable':'true'});
//                changeDrawFlag($('#btnImageRect'), 'image')
            }
            ret ++;
            return;
        }
    })

    if(ret == 0) return popBy('#btnEditSceneAdd', false, '请选择一个背景图');
    $('#mediaModal').modal('hide');
}



function delGroupZoneBgImage() {
    if(!drawInfo.operRect) return;
    drawInfo.operRect.background.image = '';
    $('#txtGroupzoneBgImage').val('');

    render();
    renderUpdate();
}

function updateMediaZonePlaylist() {
    var rpl = getMediaSourceById(drawInfo.operRect.playlist);
    var currScene= relativePlaylist.children[viewIndex];
    var p = MediaBase.duration.parse(currScene.duration);
    var t = MediaBase.duration.parse(drawInfo.operRect.duration);
    $('.mediaItemChk:checked').each(function(i, o) {
        var id = $(o).val();
        var type = $(o).attr('mediaType');
        var name = $(o).attr('mediaName');
        var url = $(o).attr('mediaUrl');
        var duration = $(o).attr('mediaDuration');
        if(type && type != 'folder') {
            var media = getMediaByType(type);
            media.id = id;
            media.name = name;
            media.url = url;
            media.duration = duration;

            var x = MediaBase.duration.parse(duration);
            if(p == t ) currScene.duration = "00:00:00";
            t += x;
            drawInfo.operRect.duration = MediaBase.duration.format(t);
            updateCurrSceneDuration();

            rpl.children.push(media);
            var src = media.url;
            switch (type) {
                case 'picture': src = media.url; break;
                case 'web': src = '/images/web300.png'; break;
                case 'video': src = '/Screenshots/'+media.id + '.jpg'; break;
                case 'mstream': src = '/images/mstream300.png'; break;
                case 'imageSlide': src = '/images/slide300.png'; break;
                default : src = media.url; break;
            }

            $('#mediaElements').append($('#tmplMediaEles').html().format(media.duration, src, type));
        }
    })
    $('#mediaModal').modal('hide');
    updateMediaElementsWidth();

    render();
    renderUpdate();
}

function updateMediaElementsWidth() {
    var w = $('#mediaElements').children().length * ($('#mediaElements').children().width() + 5);
    var p = $('#mediaElements').width();
    $('#mediaElements').width(Math.max(w, p));
}


function updateDateTimeStyle(obj) {
    if(!drawInfo.operRect) return;
    drawInfo.operRect.style = $(obj).val();
    drawInfo.operRect.formatByStyle();

    render();
    renderUpdate();
}

function updateWhichDay(obj) {
    if(!drawInfo.operRect) return;
    drawInfo.operRect.whichDay =  $(obj).val();
}

function updateAddr() {
    if(!drawInfo.operRect) return;
    drawInfo.operRect.province =  $('select[name = "province"] option:selected').html();
    drawInfo.operRect.city =  $('select[name = "city"]  option:selected').html();
}

function initAddr(rect) {
    var city = '<li class="input-group chinaArea"><select class="form-control input-sm" style="width: 40%;"  name="province" /><select name="city" style="width: 40%;" class="selCity  input-sm form-control" />'+
        '<input type="button" class="selProvince btn btn-default btn-sm" style="width: 20%; padding-left:0px; padding-right: 0px; text-align: center;" value="保存" onclick="updateAddr(this)" /> </li>';
    $('#detailarea ul').append(city);

    $(".chinaArea").jChinaArea({
        aspnet:false,
        s1: rect.province,//默认选中的省名
        s2: rect.city,//默认选中的市名
        s3:""//默认选中的县区名
    });

}

function updatePoint(obj) {
    if(!drawInfo.operRect) return;
    drawInfo.operRect.point =   $(obj).prev().val();
}

function initPoint(rect) {
    $('#detailarea ul').append('<li class="input-group"><span class="input-group-addon span-description">监测点：</span><input class="form-control watchpoint" type="text" value="" onblur="updatePoint($(this).next().get(0))" />'+
        '<span  class="input-group-addon" style="cursor:pointer; display: none" onclick="updatePoint(this)" >保存</span></li>');
    $('#detailarea .watchpoint').val(rect.point);
}

function updateDirection(obj) {
    if(!drawInfo.operRect) return;
    drawInfo.operRect.direction = $(obj).val();
}

function updateSpeed(obj) {
    if(!drawInfo.operRect) return;
    drawInfo.operRect.speed = $(obj).val();
}

function updateClockStyle(obj) {
    if(!drawInfo.operRect) return;

    var hostName = window.location.hostname;
    var port = window.location.port || '10001';

    drawInfo.operRect.style = $(obj).val();
    var src = '/images/clock/'+ $(obj).val() +'.png';
    drawInfo.operRect.url = src;
    drawInfo.operRect.source.src = src;

    var img = new Image();
    img.onload = function() {
        IMAGES.push({src:src, image:img});
        render();
        renderUpdate();
    }

    img.src = src;

}

function updateTempStyle(obj) {
    if(!drawInfo.operRect) return;
    drawInfo.operRect.style =  $(obj).val();

    render();
    renderUpdate();
}

function showMediaPlaylists() {
    $('#playlistModal').modal('show');

}



