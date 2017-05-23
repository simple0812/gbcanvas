function $get() { return document.getElementById(arguments[0]); }

function pagerDelegate(obj, method, mode) {
    var delegate = function() {
        var args = [];
        args.push(mode);
        method.apply(obj, args);
    }

    return delegate;
}

function UrlDecode(str) {
    alert(str);
    var ret = "";
    for (var i = 0; i < str.length; i++) {
        var chr = str.charAt(i);
        if (chr == "+") {
            ret += " ";
        }
        else if (chr == "%") {
            var asc = str.substring(i + 1, i + 3);
            if (parseInt("0x" + asc) > 0x7f) {
                ret += asc2str(parseInt("0x" + asc + str.substring(i + 4, i + 6)));
                i += 5;
            }
            else {
                ret += asc2str(parseInt("0x" + asc));
                i += 2;
            }
        }
        else {
            ret += chr;
        }
    }
    return ret;
}

function getQueryString(key) {
    var value = "";
    var sURL = window.document.URL;

    if (sURL.indexOf("?") > 0) {
        var arrayParams = sURL.split("?");
        var arrayURLParams = arrayParams[1].split("&");

        for (var i = 0; i < arrayURLParams.length; i++) {
            var sParam = arrayURLParams[i].split("=");

            if ((sParam[0] == key) && (sParam[1] != "")) {
                value = sParam[1];
                break;
            }
        }
    }

    return value;
}




function parseArgs() {
    var arr = [];
    var args = (arguments.length == 1) ? arguments[0] : null;

    if (args == null)
        return arr;

    for (var i = 0; i < args.length; i++) {
        arr.push(args[i]);
    }

    return arr;
}

function methodDelegate(obj, method, data) {
    var delegate = function() {
        var args = [];
        args.push(data);
        method.apply(obj, args);
    }

    return delegate;
}

function leftPage() {
    return arguments[0].length > 0;
}


function getScriptParams() {
    var jsFileName = arguments[0];

    var rName = new RegExp(jsFileName + "(\\?(.*))?$")
    var jss = document.getElementsByTagName('script');

    for (var i = 0; i < jss.length; i++) {
        var j = jss[i];
        if (j.src && j.src.match(rName)) {
            var oo = j.src.match(rName)[2];
            if (oo && (t = oo.match(/([^&=]+)=([^=&]+)/g))) {
                for (var l = 0; l < t.length; l++) {
                    r = t[l];
                    var tt = r.match(/([^&=]+)=([^=&]+)/);

                    if (tt && tt[1] == arguments[1]) {
                        //                        document.write('参数：' + tt[1] + '，参数值：' + tt[2] + '<br />');
                        return tt[2];
                    }
                }
            }
        }
    }

    return "";
}


function getScrollTop() {

    if(arguments.length > 0 && document.getElementById(arguments[0]))
        return document.getElementById(arguments[0]).scrollTop;

    var scrollTop = 0;
    if (document.documentElement && document.documentElement.scrollTop) {
        scrollTop = document.documentElement.scrollTop;
    }
    else if (document.body) {
        scrollTop = document.body.scrollTop;
    }
    return scrollTop;
}

function getScrollTopBy(name) {
    var tag = document.getElementById(name);
    return tag.scrollTop;
}



function getClientHeight() {
    if(arguments.length > 0 && document.getElementById(arguments[0]))
        return document.getElementById(arguments[0]).clientHeight;

    var clientHeight = 0;
    if (document.body.clientHeight && document.documentElement.clientHeight) {
        var clientHeight = (document.body.clientHeight < document.documentElement.clientHeight) ? document.body.clientHeight : document.documentElement.clientHeight;
    }
    else {
        var clientHeight = (document.body.clientHeight > document.documentElement.clientHeight) ? document.body.clientHeight : document.documentElement.clientHeight;
    }
    return clientHeight;
}


function getClientHeightBy(name) {

    var tag = document.getElementById(name);
    return tag.clientHeight;
}

function getScrollHeight() {

    if(arguments.length > 0 && document.getElementById(arguments[0]))
        return document.getElementById(arguments[0]).scrollHeight;
    return Math.max(document.body.scrollHeight, document.documentElement.scrollHeight);
}

function getScorllHeightBy(name) {
    var tag = document.getElementById(name);
    return tag.scrollHeight;
}


function reachBottom() {
    if ((getScrollTop() + getClientHeight()) / getScrollHeight() >= 1 && getScrollTop()>0) {
        return true;
    } else {
        return false;
    }

}

function HTMLEncode(html) {
    var temp = document.createElement("div");
    (temp.textContent != null) ? (temp.textContent = html) : (temp.innerText = html);
    var output = temp.innerHTML;
    temp = null;
    return output;
}

function HTMLDecode(text) {
    var temp = document.createElement("div");
    temp.innerHTML = text;
    var output = temp.innerText || temp.textContent;
    temp = null;
    return output;
}


function cancelDefaultEvent(e) {
    if(e && e.preventDefault) {
        e.preventDefault();
        e.stopPropagation();
    } else {
        e.returnValue = false;
        e.cancelBubble = false;
    }

    return false;
}


/* textarea start*/
function setSelectRange(textarea, start, end) {
    if(typeof (textarea.createTextRange) != 'undefined') {
        var range = textarea.createTextRange();
        // 先把相对起点移动到0处
        range.moveStart( "character", 0)
        range.moveEnd( "character", 0);
        range.collapse( true); // 移动插入光标到start处
        range.moveEnd( "character", end);
        range.moveStart( "character", start);
        range.select();
    } else if(typeof (textarea.setSelectionRange) != 'undefined') {
        textarea.setSelectionRange(start, end);
        textarea.focus();
    }
}

function getStartPosition(textarea) {
    var start = 0;
    if(typeof (textarea.selectionStart) != 'undefined') {
        start = textarea.selectionStart;
    } else {
        var range = document.selection.createRange();
        var range_textarea = document.body.createTextRange();
        range_textarea .moveToElementText(textarea);
        //比较start point
        for ( var sel_start = 0; range_textarea .compareEndPoints('StartToStart' , range) < 0; sel_start++)
            range_textarea .moveStart( 'character', 1);
        start = sel_start;
    }

    return start;
}

/* textarea end*/