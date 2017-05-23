Array.prototype.objCount = function(c) { return c; }

String.prototype.format = function() {
    var args = arguments;
    return this.replace(/\{(\d+)\}/g, function(m, i) {
        return args[i];
    });
}

String.prototype.trim = function() {
    return this.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
}

String.prototype.trimUrlPath = function() {
    return this.replace(/http:\/\/[^\/]+(:\d{2,8})?\//, '/');
}

String.format = function() {
    if (arguments.length == 0)
        return null;

    var str = arguments[0];
    for (var i = 1; i < arguments.length; i++) {
        var re = new RegExp('\\{' + (i - 1) + '\\}', 'gm');
        str = str.replace(re, arguments[i]);
    }

    return str;
}

String.formatArgs = function() {
    if (arguments.length == 0)
        return null;

    var str = arguments[0];
    var args = arguments[1];
    for (var i = 0; i < args.length; i++) {
        var re = new RegExp('\\{' + i + '\\}', 'gm');
        str = str.replace(re, args[i]);
    }

    return str;
}

String.prototype.trim = function () {
    var str = this,
        whitespace = ' \n\r\t\f\x0b\xa0\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u200b\u2028\u2029\u3000';
    for (var i = 0, len = str.length; i < len; i++) {
        if (whitespace.indexOf(str.charAt(i)) === -1) {
            str = str.substring(i);
            break;
        }
    }
    for (i = str.length - 1; i >= 0; i--) {
        if (whitespace.indexOf(str.charAt(i)) === -1) {
            str = str.substring(0, i + 1);
            break;
        }
    }
    return whitespace.indexOf(str.charAt(0)) === -1 ? str : '';
}

String.prototype.htmlEncode = function() {
    var temp = document.createElement("div");
    (temp.textContent != null) ? (temp.textContent = this) : (temp.innerText = this);
    var output = temp.innerHTML;
    temp = null;
    return output;
}

String.prototype.htmlDecode = function() {
    var temp = document.createElement("div");
    temp.innerHTML = this;
    var output = temp.innerText || temp.textContent;
    temp = null;
    return output;
}

Array.indexOf = function() {
    var arr = arguments[0];

    for (var i = 0; i < arr.length; i++) {
        if (arr[i] == arguments[1])
            return i;
    }

    return -1;
}

Array.prototype.Clone = function() {
    var objClone;
    if (this.constructor == Object) {
        objClone = new this.constructor();
    } else {
        objClone = new this.constructor(this.valueOf());
    }
    for (var key in this) {
        if (objClone[key] != this[key]) {
            if (typeof (this[key]) == 'object') {
                objClone[key] = this[key].Clone();
            } else {
                objClone[key] = this[key];
            }
        }
    }
    objClone.toString = this.toString;
    objClone.valueOf = this.valueOf;
    return objClone;
}



function getType(o) {
    var _t;
    return ((_t = typeof(o)) == "object" ? o == null && "null" ||
        Object.prototype.toString.call(o).slice(8,-1):_t).toLowerCase();
}


Array.prototype.indexOf = function(v) {
    for (var i = 0; i < this.length; i++) {
        if (this[i] == v)
            return i;
    }

    return -1;
}

Array.prototype.removeAt = function(index) {
    return this.splice(index, 1); //part1.concat(part2);
}

Array.prototype.remove = function(item) {
    //return this.removeAt(this.indexOf(item));
    var regString = ("," + this.join(",") + ",").replace("," + arguments[0] + ",", ",");

    if (regString != ",")
        return regString.substr(1, regString.length - 2).split(",");
    else
        return [];
}

Function.prototype.method = function(name, fn) {
    if(arguments.length < 2) throw  new Error('参数长度不正确');
    if(typeof (name) !== 'string') throw new Error('参数类型不正确');
    if(typeof (fn) !== 'function') throw new Error('参数类型不正确');
    this.prototype[name] = fn;
}
