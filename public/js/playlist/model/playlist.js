/*model start*/
var Playlist = Backbone.Model.extend({
    urlRoot:'/playlist',
    default:{
        id:null,
        name:'',
        type:'relativePlaylist',
        stamp: '',
        children:[]
    },
    copy: function() {
        var that = this;
        return  $.post('/playlist/copy/'+that.get('id'),{})
    }
});
/*model end*/

/*collection start*/
var Playlists = Backbone.Collection.extend({
    url:'/playlists',
    model: Playlist
});
var playlists = new Playlists;
/*collection end*/