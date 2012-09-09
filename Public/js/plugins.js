
// Javascript plugins
// ==============================

// Make it safe to use console.log always
window.log = function f(){ log.history = log.history || []; log.history.push(arguments); if(this.console) { var args = arguments, newarr; args.callee = args.callee.caller; newarr = [].slice.call(args); if (typeof console.log === 'object') log.apply.call(console.log, console, newarr); else console.log.apply(console, newarr);}};
(function(a){function b(){}for(var c="assert,count,debug,dir,dirxml,error,exception,group,groupCollapsed,groupEnd,info,log,markTimeline,profile,profileEnd,time,timeEnd,trace,warn".split(","),d;!!(d=c.pop());){a[d]=a[d]||b;}})
(function(){try{console.log();return window.console;}catch(a){return (window.console={});}}());

// jQuery.styles.js
(function(f){var a=document.defaultView&&document.defaultView.getComputedStyle,i=/([A-Z])/g,b=/-([a-z])/ig,d=function(j,k){return k.toUpperCase()},g=function(j){if(a){return a(j,null)}else{if(j.currentStyle){return j.currentStyle}}},c=/float/i,e=/^-?\d+(?:px)?$/i,h=/^-?\d/;f.styles=function(m,u){if(!m){return null}var q=g(m),l,n,k=m.style,r={},s=0,p,t,o,j;for(;s<u.length;s++){j=u[s];l=j.replace(b,d);if(c.test(j)){j=jQuery.support.cssFloat?"float":"styleFloat";l="cssFloat"}if(a){j=j.replace(i,"-$1").toLowerCase();n=q.getPropertyValue(j);if(j==="opacity"&&n===""){n="1"}r[l]=n}else{o=j.replace(b,d);r[l]=q[j]||q[o];if(!e.test(r[l])&&h.test(r[l])){p=k.left;t=m.runtimeStyle.left;m.runtimeStyle.left=m.currentStyle.left;k.left=o==="fontSize"?"1em":(r[l]||0);r[l]=k.pixelLeft+"px";k.left=p;m.runtimeStyle.left=t}}}return r};f.fn.styles=function(){return f.styles(this[0],f.makeArray(arguments))}})(jQuery);

// jQuery.animate.js
(function(g){var e=0,k=function(){var q=document.styleSheets,o=q.length-1,n=null,p;while(o>=0&&!n){if(q[o].cssRules||q[o].rules){n=q[o]}o-=1}if(!n){p=document.createElement("style");document.getElementsByTagName("head")[0].appendChild(p);if(!window.createPopup){p.appendChild(document.createTextNode(""))}n=q[q.length-1]}return n},d=function(p,o){for(var n=p.cssRules.length-1;n>=0;n--){var q=p.cssRules[n];if(q.type===7&&q.name==o){p.deleteRule(n);return}}},f=function(q,p){var r=!(this[0]&&this[0].nodeType),o=!r&&g(this).css("display")==="inline"&&g(this).css("float")==="none";for(var n in q){if(q[n]=="show"||q[n]=="hide"||jQuery.isArray(q[n])||q[n]<0||n=="zIndex"||n=="z-index"){return true}}return q.jquery===true||i===null||jQuery.isEmptyObject(q)||jQuery.isPlainObject(p)||typeof p=="string"||o||r},b=function(n,o){if(typeof o==="number"&&!jQuery.cssNumber[n]){return o+="px"}return o},j=function(){var n,o=document.createElement("fakeelement"),p={transition:{transitionEnd:"transitionEnd",prefix:""},MozTransition:{transitionEnd:"animationend",prefix:"-moz-"},WebkitTransition:{transitionEnd:"webkitAnimationEnd",prefix:"-webkit-"}};for(n in p){if(o.style[n]!==undefined){return p[n]}}return null},c={top:function(n){return n.position().top},left:function(n){return n.position().left},width:function(n){return n.width()},height:function(n){return n.height()},fontSize:function(n){return"1em"}},i=j(),l=function(o){var n={};jQuery.each(o,function(p,q){n[i.prefix+p]=q});return n},a=[],m=function(p){var n,o,q;g.each(a,function(r,s){if(p===s.style){o=s.name}else{s.age+=1}});if(!o){n=k();o="animate"+(e++);n.insertRule("@"+i.prefix+"keyframes "+o+" "+p,n.cssRules.length);a.push({name:o,style:p,age:0});a.sort(function(s,r){return s.age-r.age});if(a.length>20){q=a.pop();d(n,q.name)}}return o},h=jQuery.fn.animate;jQuery.fn.animate=function(n,o,p){if(f.apply(this,arguments)){return h.apply(this,arguments)}if(jQuery.isFunction(o)){p=o}this.queue("fx",function(u){var x,y=[],z="",r,A=g(this),t=jQuery.fx.speeds[o]||o||jQuery.fx.speeds._default,w,v=w+".run",q="{ from {",s=function(C,B){A.css(C);A.css(l({"animation-duration":"","animation-name":"","animation-fill-mode":""}));if(p&&B){p.call(A[0],true)}jQuery.removeData(A,v,true)};for(r in n){y.push(r)}if(i.prefix==="-moz-"){g.each(y,function(B,D){var C=c[jQuery.camelCase(D)];if(C&&A.css(D)=="auto"){A.css(D,C(A))}})}x=A.styles.apply(A,y);jQuery.each(y,function(C,D){var B=D.replace(/([A-Z]|^ms)/g,"-$1").toLowerCase();q+=B+" : "+b(D,x[D])+"; ";z+=B+" : "+b(D,n[D])+"; "});q+="} to {"+z+" }}";w=m(q);jQuery._data(this,v,{stop:function(B){A.css(l({"animation-play-state":"paused"}));A.off(i.transitionEnd,s);if(!B){s(A.styles.apply(A,y),false)}else{s(n,true)}}});A.css(l({"animation-duration":t+"ms","animation-name":w,"animation-fill-mode":"forwards"}));A.one(i.transitionEnd,function(){s(n,true);u()})});return this}})(jQuery);

// OKZoom by OKFocus v1.1
$(function(c){c.fn.okzoom=function(a){a=c.extend({},c.fn.okzoom.defaults,a);return this.each(function(){var b={};b.options=a;b.$el=c(this);b.el=this;b.listener=document.createElement("div");b.$listener=c(b.listener).addClass("ok-listener").css({position:"absolute",zIndex:1E4});c("body").append(b.$listener);var d=document.createElement("div");d.id="ok-loupe";d.style.position="absolute";d.style.backgroundRepeat="no-repeat";d.style.pointerEvents="none";d.style.display="none";d.style.zIndex=7879;c("body").append(d);
b.loupe=d;b.$el.data("okzoom",b);b.options=a;c(b.el).bind("mouseover",function(a){return function(b){c.fn.okzoom.build(a,b)}}(b));b.$listener.bind("mousemove",function(a){return function(b){c.fn.okzoom.mousemove(a,b)}}(b));b.$listener.bind("mouseout",function(a){return function(b){c.fn.okzoom.mouseout(a,b)}}(b));b.options.height=b.options.height||b.options.width;d=b.$el.data("okimage");b.has_data_image="undefined"!==typeof d;b.has_data_image&&(b.img=new Image,b.img.src=d)})};c.fn.okzoom.defaults=
{width:150,height:null,scaleWidth:null,round:!0,background:"#fff",backgroundRepeat:"no-repeat",shadow:"0 0 5px #000",border:0};c.fn.okzoom.build=function(a,b){a.has_data_image||(a.img=a.el);if(c.browser.msie&&9>c.browser.version&&!a.img.naturalized)if(a.img.complete)(function(a){var a=a||this,b=new Image;b.el=a;b.src=a.src;a.naturalWidth=b.width;a.naturalHeight=b.height;a.naturalized=true})(a.img);else return;a.offset=a.$el.offset();a.width=a.$el.width();a.height=a.$el.height();a.$listener.css({display:"block",
width:a.$el.outerWidth(),height:a.$el.outerHeight(),top:a.$el.offset().top,left:a.$el.offset().left});a.options.scaleWidth?(a.naturalWidth=a.options.scaleWidth,a.naturalHeight=Math.round(a.img.naturalHeight*a.options.scaleWidth/a.img.naturalWidth)):(a.naturalWidth=a.img.naturalWidth,a.naturalHeight=a.img.naturalHeight);a.widthRatio=a.naturalWidth/a.width;a.heightRatio=a.naturalHeight/a.height;a.loupe.style.width=a.options.width+"px";a.loupe.style.height=a.options.height+"px";a.loupe.style.border=
a.options.border;a.loupe.style.background=a.options.background+" url("+a.img.src+")";a.loupe.style.backgroundRepeat=a.options.backgroundRepeat;a.loupe.style.backgroundSize=a.options.scaleWidth?a.naturalWidth+"px "+a.naturalHeight+"px":"auto";a.loupe.style.borderRadius=a.loupe.style.OBorderRadius=a.loupe.style.MozBorderRadius=a.loupe.style.WebkitBorderRadius=a.options.round?a.options.width+"px":0;a.loupe.style.boxShadow=a.options.shadow;a.initialized=!0;c.fn.okzoom.mousemove(a,b)};c.fn.okzoom.mousemove=
function(a,b){if(a.initialized){var c=a.options.width/2,e=a.options.height/2,f="undefined"!==typeof b.pageX?b.pageX:b.clientX+document.documentElement.scrollLeft,g="undefined"!==typeof b.pageY?b.pageY:b.clientY+document.documentElement.scrollTop,h=-1*Math.floor((f-a.offset.left)*a.widthRatio-c),i=-1*Math.floor((g-a.offset.top)*a.heightRatio-e);document.body.style.cursor="none";a.loupe.style.display="block";a.loupe.style.left=f-c+"px";a.loupe.style.top=g-e+"px";a.loupe.style.backgroundPosition=h+"px "+
i+"px"}};c.fn.okzoom.mouseout=function(a){a.loupe.style.display="none";a.loupe.style.background="none";a.listener.style.display="none";document.body.style.cursor="auto"}});

// hoverIntent r6 // 2011.02.26 // jQuery 1.5.1+
(function($){$.fn.hoverIntent=function(f,g){var cfg={sensitivity:7,interval:100,timeout:0};cfg=$.extend(cfg,g?{over:f,out:g}:f);var cX,cY,pX,pY;var track=function(ev){cX=ev.pageX;cY=ev.pageY};var compare=function(ev,ob){ob.hoverIntent_t=clearTimeout(ob.hoverIntent_t);if((Math.abs(pX-cX)+Math.abs(pY-cY))<cfg.sensitivity){$(ob).unbind("mousemove",track);ob.hoverIntent_s=1;return cfg.over.apply(ob,[ev])}else{pX=cX;pY=cY;ob.hoverIntent_t=setTimeout(function(){compare(ev,ob)},cfg.interval)}};var delay=function(ev,ob){ob.hoverIntent_t=clearTimeout(ob.hoverIntent_t);ob.hoverIntent_s=0;return cfg.out.apply(ob,[ev])};var handleHover=function(e){var ev=jQuery.extend({},e);var ob=this;if(ob.hoverIntent_t){ob.hoverIntent_t=clearTimeout(ob.hoverIntent_t)}if(e.type=="mouseenter"){pX=ev.pageX;pY=ev.pageY;$(ob).bind("mousemove",track);if(ob.hoverIntent_s!=1){ob.hoverIntent_t=setTimeout(function(){compare(ev,ob)},cfg.interval)}}else{$(ob).unbind("mousemove",track);if(ob.hoverIntent_s==1){ob.hoverIntent_t=setTimeout(function(){delay(ev,ob)},cfg.timeout)}}};return this.bind('mouseenter',handleHover).bind('mouseleave',handleHover)}})(jQuery);



/**
 * MBP - Mobile boilerplate helper functions
 */

(function(document) {

    window.MBP = window.MBP || {};

    /**
     * Fix for iPhone viewport scale bug
     * http://www.blog.highub.com/mobile-2/a-fix-for-iphone-viewport-scale-bug/
     */

    MBP.viewportmeta = document.querySelector && document.querySelector('meta[name="viewport"]');
    MBP.ua = navigator.userAgent;

    MBP.scaleFix = function() {
        if (MBP.viewportmeta && /iPhone|iPad|iPod/.test(MBP.ua) && !/Opera Mini/.test(MBP.ua)) {
            MBP.viewportmeta.content = 'width=device-width, minimum-scale=1.0, maximum-scale=1.0';
            document.addEventListener('gesturestart', MBP.gestureStart, false);
        }
    };

    MBP.gestureStart = function() {
        MBP.viewportmeta.content = 'width=device-width, minimum-scale=0.25, maximum-scale=1.6';
    };

    /**
     * Normalized hide address bar for iOS & Android
     * (c) Scott Jehl, scottjehl.com
     * MIT License
     */

    // If we split this up into two functions we can reuse
    // this function if we aren't doing full page reloads.

    // If we cache this we don't need to re-calibrate everytime we call
    // the hide url bar
    MBP.BODY_SCROLL_TOP = false;

    // So we don't redefine this function everytime we
    // we call hideUrlBar
    MBP.getScrollTop = function() {
        var win = window;
        var doc = document;

        return win.pageYOffset || doc.compatMode === 'CSS1Compat' && doc.documentElement.scrollTop || doc.body.scrollTop || 0;
    };

    // It should be up to the mobile
    MBP.hideUrlBar = function() {
        var win = window;

        // if there is a hash, or MBP.BODY_SCROLL_TOP hasn't been set yet, wait till that happens
        if (!location.hash && MBP.BODY_SCROLL_TOP !== false) {
            win.scrollTo( 0, MBP.BODY_SCROLL_TOP === 1 ? 0 : 1 );
        }
    };

    MBP.hideUrlBarOnLoad = function() {
        var win = window;
        var doc = win.document;
        var bodycheck;

        // If there's a hash, or addEventListener is undefined, stop here
        if ( !location.hash && win.addEventListener ) {

            // scroll to 1
            window.scrollTo( 0, 1 );
            MBP.BODY_SCROLL_TOP = 1;

            // reset to 0 on bodyready, if needed
            bodycheck = setInterval(function() {
                if ( doc.body ) {
                    clearInterval( bodycheck );
                    MBP.BODY_SCROLL_TOP = MBP.getScrollTop();
                    MBP.hideUrlBar();
                }
            }, 15 );

            win.addEventListener('load', function() {
                setTimeout(function() {
                    // at load, if user hasn't scrolled more than 20 or so...
                    if (MBP.getScrollTop() < 20) {
                        // reset to hide addr bar at onload
                        MBP.hideUrlBar();
                    }
                }, 0);
            });
        }
    };

    /**
     * Enable CSS active pseudo styles in Mobile Safari
     * http://alxgbsn.co.uk/2011/10/17/enable-css-active-pseudo-styles-in-mobile-safari/
     */

    MBP.enableActive = function() {
        document.addEventListener('touchstart', function() {}, false);
    };

    /**
     * Prevent default scrolling on document window
     */

    MBP.preventScrolling = function() {
        document.addEventListener('touchmove', function(e) {
            e.preventDefault();
        }, false);
    };

    /**
     * Prevent iOS from zooming onfocus
     * https://github.com/h5bp/mobile-boilerplate/pull/108
     * Adapted from original jQuery code here: http://nerd.vasilis.nl/prevent-ios-from-zooming-onfocus/
     */

    MBP.preventZoom = function() {
        var formFields = document.querySelectorAll('input, select, textarea');
        var contentString = 'width=device-width,initial-scale=1,maximum-scale=';
        var i = 0;

        for (i = 0; i < formFields.length; i++) {
            formFields[i].onfocus = function() {
                MBP.viewportmeta.content = contentString + '1';
            };
            formFields[i].onblur = function() {
                MBP.viewportmeta.content = contentString + '10';
            };
        }
    };

})(document);
