var Interface =  function (name, methods) {
    if(arguments.length < 2) {
        throw new Error('interface constructor called with ' + arguments.length + 'arguments, but expected exactly 2.');
    }

    this.name = name;
    this.methods = [];
    for(var i = 0, len = methods.length; i< len ; i++) {
        if(typeof (methods[i]) !== 'string') {
            throw  new Error('Interface constructor expects method to be passed in a string');
        }

        this.methods.push(methods[i]);
    }
}
Interface.ensureImplements = function(obj) {
    if(arguments.length < 2) {
        throw new Error('interface constructor called with ' + arguments.length + ' arguments, but expected exactly 2.');
    }

    for(var i = 1, len = arguments.length; i< len ; i++) {
        var interface = arguments[i];

        if(interface.constructor !== Interface) {
            throw  new Error('Function is not instance of Interface');
        }

        for(var j = 0, methodLen = interface.methods.length; j< methodLen; j++) {
            var method = interface.methods[j];
            if(!obj[method] || typeof (obj[method]) !== 'function') {
                throw new Error('object does not implements the ' + interface.name
                    + ' interface.method ' +  method + ' was not found');
            }
        }
    }

}

function extend(subClass, superClass) {
    var F = function() {};
    F.prototype = superClass.prototype;
    subClass.prototype = new F;
    subClass.prototype.constructor = subClass;

    subClass.superClass = superClass;
    if(superClass.prototype.constructor == Object.prototype.constructor)
        superClass.prototype.constructor = superClass;
}

function clone(obj) {
    return _.clone(obj);
}


function deepClone(obj){
    return JSON.parse(JSON.stringify(obj));
}

(function($) {

    var o = $({});

    $.subscribe = function() {
        o.on.apply(o, arguments);
    };

    $.unsubscribe = function() {
        o.off.apply(o, arguments);
    };

    $.publish = function() {
        o.trigger.apply(o, arguments);
    };

}(jQuery));