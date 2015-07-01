/*!
* Aloha Editor
* Copyright (c) 2010 Gentics Software GmbH
* aloha-sales@gentics.com
* Author Nicolas Karageuzian
* Licensed unter the terms of http://www.aloha-editor.com/license.html
# https://github.com/temistokles/Aloha-Plugin-InputControl
*/
define(["aloha/plugin","aloha"],function(t,e){"use strict";return t.create("inputcontrol",{_constructor:function(){this._super("inputcontrol")},init:function(){var t=this;t.bindEvents()},config:{enableFilter:!1,allowchars:new RegExp("."),enableMask:!1},bindEvents:function(){var t=this;e.bind("aloha-editable-created",function(n,i){var r=t.getEditableConfig(i.obj);r.enableFilter&&i.obj.keypress(function(t){var n,i=t.which,s=!0;return n=String.fromCharCode(i),r.allowchars instanceof RegExp&&(e.Log.debug(e,"Keycode : ["+i+"] char : '"+n+"'"),s=s&&r.allowchars.test(n)),s}),r.disableEnter&&(i.obj.unbind("keydown"),i.obj.keydown(function(t){return 13===t.keyCode?!1:!0})),r.enableMask&&i.obj.blur(function(){var t=$(this);return r.type===Number&&("NaN"===new Number(t.text()).toString()?t.addClass("aloha-input-invalid"):t.removeClass("aloha-input-invalid")),"number"==typeof r.maxlength&&(r.striphtml?t.text().length>=r.maxlength?t.addClass("aloha-input-invalid"):t.removeClass("aloha-input-invalid"):t.html().length>=r.maxlength?t.addClass("aloha-input-invalid"):t.removeClass("aloha-input-invalid")),!0})})}})});