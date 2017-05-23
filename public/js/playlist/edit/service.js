function saveRelativePlaylist() {
    if(confirm('确认保存吗？')) {
        var name = $('#txtRelativePlaylistName').val().trim();
        if(name.length == 0) return popBy('#txtRelativePlaylistName', false, '播放列表名称不能为空')
        else if(name.getRealLength() > 40) return popBy('#txtRelativePlaylistName', false, '播放列表名称长度不能超过40')
        var validateName = validatePublicName(name);
        if(!validateName.status) return popBy('#txtRelativePlaylistName', false, '播放列表名称'+validateName.message)

        renderSelectedRect();
        //scaleAllRectByRatio(1);
        relativePlaylist.name = name;
        relativePlaylist.children = mediaSourceList.concat(relativePlaylist.children);
        var playlist = new Playlist().set(relativePlaylist);

        playlist.id = playlist.get('id');
        playlist.save().done(function(json){
            if(json.status == 'fail') return popBy('#txtRelativePlaylistName', false, json.result);
            isSave = true;
            window.location.href = '/playlist?'+ Math.random();
        });
    }
}

function initReplaylistData() {
    if(!playlistId) return;

    $.getJSON('/playlist/'+playlistId, function(json) {
        if(!json) return;
        $('#txtRelativePlaylistName').val(json.name);
        relativePlaylist = new RelativePlaylist(json.id, json.name, json.type, json.stamp, []);
        for(var i = 0, len = json.children.length; i < len ; i++) {
            var p = json.children[i]; //scene or relativeplaylist
            var ele = createEleByObj(p);
            ele.init(p);
        }

        async.series(imageTasks, function() {
            for(var i = 0, len = relativePlaylist.children.length; i < len ; i++) {

                (function(i){
                    viewIndex = i;
                    render();
                })(i)
            }
            switchView($('#leftside .panel').first());
            initSceneIndex();
        });
        console.log(relativePlaylist);
    })
}

function initImg(rect) {
    imageTasks.push(function(cb) {
        var img = new Image();
        img.onload = function() {
            IMAGES.push({src:rect.source.src, image:img});
            cb();
        };
        img.src = rect.source.src;
    });

}
