function addView() {
    var id = createSceneId();
    var scene = new Scene(id, 'scene'+ id , WIDTH*RATIO, HEIGHT*RATIO, null, null );
    relativePlaylist.children.push(scene);
    var cvs = createScene(scene);
    switchView($('#leftside .panel').last());
    initSceneIndex();
}

function delView() {

    if(confirm('确认删除吗？')) {
        relativePlaylist.children.removeAt(viewIndex);
        $('#leftside .panel').eq(viewIndex).remove();
        if(relativePlaylist.children.length == 0) {
            addView();
            render();
        } else {
            if(viewIndex > relativePlaylist.children.length - 1)
                viewIndex = relativePlaylist.children.length - 1;
            switchView( $('#leftside .panel').eq(viewIndex))
        }

        initSceneIndex();
    }

}

function showAddViewModal(type) {
    $('#editScene').modal('show');
    $('#btnEditScene').attr('activeType', type);

    $('#txtSceneBg').val('#ffffffff');
    $("#txtColorPicker").spectrum("set", '#fff');
    $('#txtSceneBgPic').val('');
    $('#txtSceneDurationHour').val('00');
    $('#txtSceneDurationMin').val('00');
    $('#txtSceneDurationSec').val('00');
    $('#txtSceneWidth').val(1280);
    $('#txtSceneHeight').val(720);
}

function showEditViewModal(type) {
    $('#editScene').modal('show');
    $('#btnEditScene').attr('activeType', type);

    var currScene = relativePlaylist.children[viewIndex];
    $('#txtSceneBg').val(currScene.background.color).css({background:hexToRgb(currScene.background.color)});
    $("#txtColorPicker").spectrum("set", hexToRgb(currScene.background.color));
    $('#txtSceneBgPic').val(currScene.background.image ? currScene.background.image : '');

    var p = currScene.duration.split(':');

    $('#txtSceneDurationHour').val(p[0]);
    $('#txtSceneDurationMin').val(p[1]);
    $('#txtSceneDurationSec').val(p[2]);
    $('#txtSceneWidth').val(currScene.width )//.prop('disabled', true);
    $('#txtSceneHeight').val(currScene.height)//.prop('disabled', true);
}

function exportView() {
    alert('z')
}

function editScene(obj) {

    var hour = $('#txtSceneDurationHour').val().trim() || "0";
    var min = $('#txtSceneDurationMin').val().trim() || "0";
    var sec = $('#txtSceneDurationSec').val().trim() || "0";
    var width = $('#txtSceneWidth').val().trim() || "0";
    var height = $('#txtSceneHeight').val().trim() || "0";
    var activeType = $('#btnEditScene').attr('activeType');
    var reg = /^\d*$/;
    if(!reg.test(hour) || parseInt(hour)  > 24 || parseInt(hour) < 0) return alert('小时格式不正确');
    if(!reg.test(min) || parseInt(min) > 59 || parseInt(min) < 0) return alert('分钟格式不正确');
    if(!reg.test(sec) || parseInt(sec) > 59 || parseInt(sec) < 0) return alert('秒格式不正确');
    if(!reg.test(width) || parseInt(width) <= 0) return popBy('#btnEditScene', false, '分辨率输入格式错误');
    if(!reg.test(height) || parseInt(height) <= 0) return popBy('#btnEditScene', false, '分辨率输入格式错误');

    var duration = String.format('{0}:{1}:{2}', parseInt(hour) < 10 ? '0'+parseInt(hour) : parseInt(hour) ,
        parseInt(min) < 10 ? '0'+parseInt(min) : parseInt(min),
        parseInt(sec) < 10 ? '0'+parseInt(sec) : parseInt(sec));


    $('#editScene').modal('hide');
    var currScene = null;

    if(activeType == 'add') {
        var id = createSceneId();
        currScene = new Scene(id, 'scene'+ id , width, height, duration, null );
        currScene.background.color = $('#txtSceneBg').val();
        currScene.background.image = $('#txtSceneBgPic').val();
        relativePlaylist.children.push(currScene);

        var cvs = createScene(currScene);
        switchView($('#leftside .panel').last());
    } else if (activeType == 'edit') {
        var p = MediaBase.duration.parse(duration);
        var t = getCurrSceneMediaMaxDuration();
        if(p < t) return alert('场景持续时间不能小于最大的媒体持续时间:' + t +"秒");

        var currScene = relativePlaylist.children[viewIndex];
        currScene.duration = duration;
        currScene.width =  parseInt(width);
        currScene.height = parseInt(height);
        currScene.background.color = $('#txtSceneBg').val();
        currScene.background.image = $('#txtSceneBgPic').val().replace(/\\/ig, '/');

        //$('.activecvs .panel-title').html(currScene.id +" "+currScene.duration);
        //initSceneIndex();
        updateViewSize(parseInt(width)*currScene.ratio, parseInt(height)*currScene.ratio , currScene.ratio);
        $('.span-duration').eq(viewIndex).html(duration);
    }

    initSceneIndex();
}

function switchView(obj) {
    renderSelectedRect();
    viewIndex = $('#leftside .panel').index(obj);
    var currScene = relativePlaylist.children[viewIndex];
    //alert(currScene.ratio)
    RATIO = currScene.ratio;

    $(obj).addClass('activecvs').siblings().removeClass('activecvs');
    $('#sceneratio').val(currScene.ratio);

    scaleView($("#sceneratio"));
}

function renderSelectedRect () {
    if(drawInfo.operRect && drawInfo.operRect.isSelected) {
        drawInfo.operRect.isSelected = false;

        render();
        clearTempCvs();
        drawInfo.init();
        $('#detailarea').empty();
    }
}

function scaleView(obj) {

    renderSelectedRect();
    var currScene = relativePlaylist.children[viewIndex];
    var ratio = parseFloat($(obj).val());
    RATIO = ratio;

    currScene.ratio = ratio;

    updateViewSize(currScene.width*ratio, currScene.height*ratio, ratio);

}

$('#activeArea').mousewheel(function(e, delta) {
    var obj = $('#sceneratio option:selected');
    if(delta > 0 && obj.prev().length > 0) obj = $('#sceneratio option:selected').prev();
    if(delta < 0 && obj.next().length > 0) obj = $('#sceneratio option:selected').next();

    $('#sceneratio').val(obj.attr('value'));
    scaleView('#sceneratio');
});

function scaleRectByRatio(ratio, origRatio) {
    var scene = relativePlaylist.children[viewIndex];
    if(scene.constructor == RelativePlaylist || scene.children.length == 0) return;

    for(var j = 0, jLen = scene.children.length; j<jLen; j++) {
        scene.children[j].switchRatio(ratio, origRatio);
        if(scene.children[j].children) {
            for(var k = 0, kLen = scene.children[j].children.length; k<kLen; k++) {
                scene.children[j].children[k].switchRatio(ratio, origRatio);
            }
        }
    }
}

function scaleAllRectByRatio(ratio) {
    for(var i = 0, len = relativePlaylist.children.length; i< len ; i++) {
        var scene = relativePlaylist.children[i];
        if(scene == RelativePlaylist) continue;

        for(var j = 0, jLen = scene.children.length; j<jLen; j++) {
            scene.children[j].switchRatio(ratio, scene.ratio);
            if(scene.children[j].children) {
                for(var k = 0, kLen = scene.children[j].children.length; k<kLen; k++) {
                    scene.children[j].children[k].switchRatio(ratio, scene.ratio);
                }
            }
        }
        scene.ratio = ratio;
    }
}

function switchClock(obj) {
    $(obj).parent('ul').siblings('div').children('img').remove().end().prepend($(obj).html());

    $('.singlearea img').each(function(i, o) {
        o.ondragstart = imgDragStart
        o.ondragend = imgDragEnd
    });
}

function showColorPicker(obj) {
    if($('#picker:visible').length > 0)  $('#picker').hide()
    else $('#picker').show().farbtastic('#txtSceneBg');

    $(obj).blur();
}


function showMediaPicker(obj) {
    $('#mediaModal').modal('show');
}

function updateViewSize(width, height, ratio) {


    WIDTH = width / ratio;
    HEIGHT = height / ratio;

    $('#cvsarea canvas').attr({'width':width,'height': height});
    $('#cvsarea').css({'width': $('#activeArea').width() - 30 , 'height': getClientHeight() -  $('#activeArea').offset().top - 50});

    setTimeout(function() {
        initScroll();
    }, 0);

    //bgCtx.scale(ratio, ratio);
    initCoord();
    render();


}

function showComponentDetail() {
    $('#rightsidehead li').last().addClass('active').siblings().removeClass('active');
    $('#compnentindex').hide();
    $('#detailarea').show();
}

function showComponents() {
    $('#rightsidehead li').first().addClass('active').siblings().removeClass('active');
    $('#compnentindex').show();
    $('#detailarea').hide();
}

function initSceneIndex() {
    $('.span-sceneindex').each(function(i, o) {
        $(o).html(i + 1);
    })
}

var resizeEvtArg = null;
window.onresize= function() {
    clearTimeout(resizeEvtArg);
    resizeEvtArg = setTimeout(function() {
        updateViewSize(WIDTH * RATIO, HEIGHT * RATIO, RATIO );
    }, 500);
}