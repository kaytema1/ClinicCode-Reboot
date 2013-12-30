/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */



// List of words to show in drop down
var drugsarray = new Array("Lofnac", "Diclofenac", "Paracetamol","Amoxicillin","Malaria Test",
"Artemether Lumefantrine Tablet",
"Artemether Lumefantrine Solution",
"Peripheral Smear for Malarial Parasite",
"Rapid Malaria Antigen Test", "Microscopy",
"Quantitative Buffy Coat (QBC) test",
"CT scan",
"Hepatic Function Panel",
"EGFR Mutation Detection");

var drugsarray2 = new Array("Lofnac", "CT scan",
"Hepatic Function Panel",
"EGFR Mutation Detection");



    //****************************************************************************
function actb(obj,ca){
    /* ---- Public Variables ---- */
    this.saec_timeOut = -1; // Autocomplete Timeout in ms (-1: autocomplete never time out)
    this.saec_lim = 4;    // Number of elements autocomplete can show (-1: no limit)
    this.saec_firstText = false; // should the auto complete be limited to the beginning of keyword?
    this.saec_mouse = true; // Enable Mouse Support
    this.saec_delimiter = new Array(';',' ');  // Delimiter for multiple autocomplete. Set it to empty array for single autocomplete
    this.saec_startcheck = 1; // Show widget only after this number of characters is typed in.
    /* ---- Public Variables ---- */

    //Customize style according to your requirement
    /* --- Styles --- */
    this.saec_bgColor = '#CFD9FF';
    this.saec_textColor = '#ffffff';
    this.saec_hColor = '#0000FF';
    this.saec_fFamily = 'verdana';
    this.saec_fSize = '15px';
    this.saec_hStyle = 'text-decoration:underline;font-weight:bold';
    /* --- Styles --- */

    /* ---- Private Variables ---- */
    var saec_delimwords = new Array();
    var saec_cdelimword = 0;
    var saec_delimchar = new Array();
    var saec_display = false;
    var saec_pos = 0;
    var saec_total = 0;
    var saec_curr = null;
    var saec_rangeu = 0;
    var saec_ranged = 0;
    var saec_bool = new Array();
    var saec_pre = 0;
    var saec_toid;
    var saec_tomake = false;
    var saec_getpre = "";
    var saec_mouse_on_list = 1;
    var saec_kwcount = 0;
    var saec_caretmove = false;
    this.saec_keywords = new Array();
    /* ---- Private Variables---- */

    this.saec_keywords = ca;
    var saec_self = this;

    saec_curr = obj;

    addEvent(saec_curr,"focus",saec_setup);
    function saec_setup(){
        addEvent(document,"keydown",saec_checkkey);
        addEvent(saec_curr,"blur",saec_clear);
        addEvent(document,"keypress",saec_keypress);
    }

    function saec_clear(evt){
        if (!evt) evt = event;
        removeEvent(document,"keydown",saec_checkkey);
        removeEvent(saec_curr,"blur",saec_clear);
        removeEvent(document,"keypress",saec_keypress);
        saec_removedisp();
    }
    function saec_parse(n){
        if (saec_self.saec_delimiter.length > 0){
            var t = saec_delimwords[saec_cdelimword].trim().addslashes();
            var plen = saec_delimwords[saec_cdelimword].trim().length;
        }else{
            var t = saec_curr.value.addslashes();
            var plen = saec_curr.value.length;
        }
        var tobuild = '';
        var i;

        if (saec_self.saec_firstText){
            var re = new RegExp("^" + t, "i");
        }else{
            var re = new RegExp(t, "i");
        }
        var p = n.search(re);

        for (i=0;i<p;i++){
            tobuild += n.substr(i,1);
        }
        tobuild += "<font style='"+(saec_self.saec_hStyle)+"'>"
        for (i=p;i<plen+p;i++){
            tobuild += n.substr(i,1);
        }
        tobuild += "</font>";
        for (i=plen+p;i<n.length;i++){
            tobuild += n.substr(i,1);
        }
        return tobuild;
    }
    function saec_generate(){
        if (document.getElementById('tat_table')){ saec_display = false;document.body.removeChild(document.getElementById('tat_table')); }
        if (saec_kwcount == 0){
            saec_display = false;
            return;
        }
        a = document.createElement('table');
        a.cellSpacing='1px';
        a.cellPadding='2px';
        a.style.position='absolute';
        a.style.top = eval(curTop(saec_curr) + saec_curr.offsetHeight) + "px";
        a.style.left = curLeft(saec_curr) + "px";
        a.style.backgroundColor=saec_self.saec_bgColor;
        a.id = 'tat_table';
        document.body.appendChild(a);
        var i;
        var first = true;
        var j = 1;
        if (saec_self.saec_mouse){
            a.onmouseout = saec_table_unfocus;
            a.onmouseover = saec_table_focus;
        }
        var counter = 0;
        for (i=0;i<saec_self.saec_keywords.length;i++){
            if (saec_bool[i]){
                counter++;
                r = a.insertRow(-1);
                if (first && !saec_tomake){
                    r.style.backgroundColor = saec_self.saec_hColor;
                    first = false;
                    saec_pos = counter;
                }else if(saec_pre == i){
                    r.style.backgroundColor = saec_self.saec_hColor;
                    first = false;
                    saec_pos = counter;
                }else{
                    r.style.backgroundColor = saec_self.saec_bgColor;
                }
                r.id = 'tat_tr'+(j);
                c = r.insertCell(-1);
                c.style.color = saec_self.saec_textColor;
                c.style.fontFamily = saec_self.saec_fFamily;
                c.style.fontSize = saec_self.saec_fSize;
                c.innerHTML = saec_parse(saec_self.saec_keywords[i]);
                c.id = 'tat_td'+(j);
                c.setAttribute('pos',j);
                if (saec_self.saec_mouse){
                    c.style.cursor = 'pointer';
                    c.onclick=saec_mouseclick;
                    c.onmouseover = saec_table_highlight;
                }
                j++;
            }
            if (j - 1 == saec_self.saec_lim && j < saec_total){
                r = a.insertRow(-1);
                r.style.backgroundColor = saec_self.saec_bgColor;
                c = r.insertCell(-1);
                c.style.color = saec_self.saec_textColor;
                c.style.fontFamily = 'arial narrow';
                c.style.fontSize = saec_self.saec_fSize;
                c.align='center';
                replaceHTML(c,'\\/');
                if (saec_self.saec_mouse){
                    c.style.cursor = 'pointer';
                    c.onclick = saec_mouse_down;
                }
                break;
            }
        }
        saec_rangeu = 1;
        saec_ranged = j-1;
        saec_display = true;
        if (saec_pos <= 0) saec_pos = 1;
    }
    function saec_remake(){
        document.body.removeChild(document.getElementById('tat_table'));
        a = document.createElement('table');
        a.cellSpacing='1px';
        a.cellPadding='2px';
        a.style.position='absolute';
        a.style.top = eval(curTop(saec_curr) + saec_curr.offsetHeight) + "px";
        a.style.left = curLeft(saec_curr) + "px";
        a.style.backgroundColor=saec_self.saec_bgColor;
        a.id = 'tat_table';
        if (saec_self.saec_mouse){
            a.onmouseout= saec_table_unfocus;
            a.onmouseover=saec_table_focus;
        }
        document.body.appendChild(a);
        var i;
        var first = true;
        var j = 1;
        if (saec_rangeu > 1){
            r = a.insertRow(-1);
            r.style.backgroundColor = saec_self.saec_bgColor;
            c = r.insertCell(-1);
            c.style.color = saec_self.saec_textColor;
            c.style.fontFamily = 'arial narrow';
            c.style.fontSize = saec_self.saec_fSize;
            c.align='center';
            replaceHTML(c,'/\\');
            if (saec_self.saec_mouse){
                c.style.cursor = 'pointer';
                c.onclick = saec_mouse_up;
            }
        }
        for (i=0;i<saec_self.saec_keywords.length;i++){
            if (saec_bool[i]){
                if (j >= saec_rangeu && j <= saec_ranged){
                    r = a.insertRow(-1);
                    r.style.backgroundColor = saec_self.saec_bgColor;
                    r.id = 'tat_tr'+(j);
                    c = r.insertCell(-1);
                    c.style.color = saec_self.saec_textColor;
                    c.style.fontFamily = saec_self.saec_fFamily;
                    c.style.fontSize = saec_self.saec_fSize;
                    c.innerHTML = saec_parse(saec_self.saec_keywords[i]);
                    c.id = 'tat_td'+(j);
                    c.setAttribute('pos',j);
                    if (saec_self.saec_mouse){
                        c.style.cursor = 'pointer';
                        c.onclick=saec_mouseclick;
                        c.onmouseover = saec_table_highlight;
                    }
                    j++;
                }else{
                    j++;
                }
            }
            if (j > saec_ranged) break;
        }
        if (j-1 < saec_total){
            r = a.insertRow(-1);
            r.style.backgroundColor = saec_self.saec_bgColor;
            c = r.insertCell(-1);
            c.style.color = saec_self.saec_textColor;
            c.style.fontFamily = 'arial narrow';
            c.style.fontSize = saec_self.saec_fSize;
            c.align='center';
            replaceHTML(c,'\\/');
            if (saec_self.saec_mouse){
                c.style.cursor = 'pointer';
                c.onclick = saec_mouse_down;
            }
        }
    }
    function saec_goup(){
        if (!saec_display) return;
        if (saec_pos == 1) return;
        document.getElementById('tat_tr'+saec_pos).style.backgroundColor = saec_self.saec_bgColor;
        saec_pos--;
        if (saec_pos < saec_rangeu) saec_moveup();
        document.getElementById('tat_tr'+saec_pos).style.backgroundColor = saec_self.saec_hColor;
        if (saec_toid) clearTimeout(saec_toid);
        if (saec_self.saec_timeOut > 0) saec_toid = setTimeout(function(){saec_mouse_on_list=0;saec_removedisp();},saec_self.saec_timeOut);
    }
    function saec_godown(){
        if (!saec_display) return;
        if (saec_pos == saec_total) return;
        document.getElementById('tat_tr'+saec_pos).style.backgroundColor = saec_self.saec_bgColor;
        saec_pos++;
        if (saec_pos > saec_ranged) saec_movedown();
        document.getElementById('tat_tr'+saec_pos).style.backgroundColor = saec_self.saec_hColor;
        if (saec_toid) clearTimeout(saec_toid);
        if (saec_self.saec_timeOut > 0) saec_toid = setTimeout(function(){saec_mouse_on_list=0;saec_removedisp();},saec_self.saec_timeOut);
    }
    function saec_movedown(){
        saec_rangeu++;
        saec_ranged++;
        saec_remake();
    }
    function saec_moveup(){
        saec_rangeu--;
        saec_ranged--;
        saec_remake();
    }

    /* Mouse */
    function saec_mouse_down(){
        document.getElementById('tat_tr'+saec_pos).style.backgroundColor = saec_self.saec_bgColor;
        saec_pos++;
        saec_movedown();
        document.getElementById('tat_tr'+saec_pos).style.backgroundColor = saec_self.saec_hColor;
        saec_curr.focus();
        saec_mouse_on_list = 0;
        if (saec_toid) clearTimeout(saec_toid);
        if (saec_self.saec_timeOut > 0) saec_toid = setTimeout(function(){saec_mouse_on_list=0;saec_removedisp();},saec_self.saec_timeOut);
    }
    function saec_mouse_up(evt){
        if (!evt) evt = event;
        if (evt.stopPropagation){
            evt.stopPropagation();
        }else{
            evt.cancelBubble = true;
        }
        document.getElementById('tat_tr'+saec_pos).style.backgroundColor = saec_self.saec_bgColor;
        saec_pos--;
        saec_moveup();
        document.getElementById('tat_tr'+saec_pos).style.backgroundColor = saec_self.saec_hColor;
        saec_curr.focus();
        saec_mouse_on_list = 0;
        if (saec_toid) clearTimeout(saec_toid);
        if (saec_self.saec_timeOut > 0) saec_toid = setTimeout(function(){saec_mouse_on_list=0;saec_removedisp();},saec_self.saec_timeOut);
    }
    function saec_mouseclick(evt){
        if (!evt) evt = event;
        if (!saec_display) return;
        saec_mouse_on_list = 0;
        saec_pos = this.getAttribute('pos');
        saec_penter();
    }
    function saec_table_focus(){
        saec_mouse_on_list = 1;
    }
    function saec_table_unfocus(){
        saec_mouse_on_list = 0;
        if (saec_toid) clearTimeout(saec_toid);
        if (saec_self.saec_timeOut > 0) saec_toid = setTimeout(function(){saec_mouse_on_list = 0;saec_removedisp();},saec_self.saec_timeOut);
    }
    function saec_table_highlight(){
        saec_mouse_on_list = 1;
        document.getElementById('tat_tr'+saec_pos).style.backgroundColor = saec_self.saec_bgColor;
        saec_pos = this.getAttribute('pos');
        while (saec_pos < saec_rangeu) saec_moveup();
        while (saec_pos > saec_ranged) saec_movedown();
        document.getElementById('tat_tr'+saec_pos).style.backgroundColor = saec_self.saec_hColor;
        if (saec_toid) clearTimeout(saec_toid);
        if (saec_self.saec_timeOut > 0) saec_toid = setTimeout(function(){saec_mouse_on_list = 0;saec_removedisp();},saec_self.saec_timeOut);
    }
    /* ---- */

    function saec_insertword(a){
        if (saec_self.saec_delimiter.length > 0){
            str = '';
            l=0;
            for (i=0;i<saec_delimwords.length;i++){
                if (saec_cdelimword == i){
                    prespace = postspace = '';
                    gotbreak = false;
                    for (j=0;j<saec_delimwords[i].length;++j){
                        if (saec_delimwords[i].charAt(j) != ' '){
                            gotbreak = true;
                            break;
                        }
                        prespace += ' ';
                    }
                    for (j=saec_delimwords[i].length-1;j>=0;--j){
                        if (saec_delimwords[i].charAt(j) != ' ') break;
                        postspace += ' ';
                    }
                    str += prespace;
                    str += a;
                    l = str.length;
                    if (gotbreak) str += postspace;
                }else{
                    str += saec_delimwords[i];
                }
                if (i != saec_delimwords.length - 1){
                    str += saec_delimchar[i];
                }
            }
            saec_curr.value = str;
            setCaret(saec_curr,l);
        }else{
            saec_curr.value = a;
        }
        saec_mouse_on_list = 0;
        saec_removedisp();
    }
    function saec_penter(){
        if (!saec_display) return;
        saec_display = false;
        var word = '';
        var c = 0;
        for (var i=0;i<=saec_self.saec_keywords.length;i++){
            if (saec_bool[i]) c++;
            if (c == saec_pos){
                word = saec_self.saec_keywords[i];
                break;
            }
        }
        saec_insertword(word);
        l = getCaretStart(saec_curr);
    }
    function saec_removedisp(){
        if (saec_mouse_on_list==0){
            saec_display = 0;
            if (document.getElementById('tat_table')){ document.body.removeChild(document.getElementById('tat_table')); }
            if (saec_toid) clearTimeout(saec_toid);
        }
    }
    function saec_keypress(e){
        if (saec_caretmove) stopEvent(e);
        return !saec_caretmove;
    }
    function saec_checkkey(evt){
        if (!evt) evt = event;
        a = evt.keyCode;
        caret_pos_start = getCaretStart(saec_curr);
        saec_caretmove = 0;
        switch (a){
            case 38:
                saec_goup();
                saec_caretmove = 1;
                return false;
                break;
            case 40:
                saec_godown();
                saec_caretmove = 1;
                return false;
                break;
            case 13: case 9:
                    if (saec_display){
                        saec_caretmove = 1;
                        saec_penter();
                        return false;
                    }else{
                        return true;
                    }
                    break;
                default:
                    setTimeout(function(){saec_tocomplete(a)},50);
                    break;
            }
        }

        function saec_tocomplete(kc){
            if (kc == 38 || kc == 40 || kc == 13) return;
            var i;
            if (saec_display){
                var word = 0;
                var c = 0;
                for (var i=0;i<=saec_self.saec_keywords.length;i++){
                    if (saec_bool[i]) c++;
                    if (c == saec_pos){
                        word = i;
                        break;
                    }
                }
                saec_pre = word;
            }else{ saec_pre = -1};

            if (saec_curr.value == ''){
                saec_mouse_on_list = 0;
                saec_removedisp();
                return;
            }
            if (saec_self.saec_delimiter.length > 0){
                caret_pos_start = getCaretStart(saec_curr);
                caret_pos_end = getCaretEnd(saec_curr);

                delim_split = '';
                for (i=0;i<saec_self.saec_delimiter.length;i++){
                    delim_split += saec_self.saec_delimiter[i];
                }
                delim_split = delim_split.addslashes();
                delim_split_rx = new RegExp("(["+delim_split+"])");
                c = 0;
                saec_delimwords = new Array();
                saec_delimwords[0] = '';
                for (i=0,j=saec_curr.value.length;i<saec_curr.value.length;i++,j--){
                    if (saec_curr.value.substr(i,j).search(delim_split_rx) == 0){
                        ma = saec_curr.value.substr(i,j).match(delim_split_rx);
                        saec_delimchar[c] = ma[1];
                        c++;
                        saec_delimwords[c] = '';
                    }else{
                        saec_delimwords[c] += saec_curr.value.charAt(i);
                    }
                }

                var l = 0;
                saec_cdelimword = -1;
                for (i=0;i<saec_delimwords.length;i++){
                    if (caret_pos_end >= l && caret_pos_end <= l + saec_delimwords[i].length){
                        saec_cdelimword = i;
                    }
                    l+=saec_delimwords[i].length + 1;
                }
                var ot = saec_delimwords[saec_cdelimword].trim();
                var t = saec_delimwords[saec_cdelimword].addslashes().trim();
            }else{
                var ot = saec_curr.value;
                var t = saec_curr.value.addslashes();
            }
            if (ot.length == 0){
                saec_mouse_on_list = 0;
                saec_removedisp();
            }
            if (ot.length < saec_self.saec_startcheck) return this;
            if (saec_self.saec_firstText){
                var re = new RegExp("^" + t, "i");
            }else{
                var re = new RegExp(t, "i");
            }

            saec_total = 0;
            saec_tomake = false;
            saec_kwcount = 0;
            for (i=0;i<saec_self.saec_keywords.length;i++){
                saec_bool[i] = false;
                if (re.test(saec_self.saec_keywords[i])){
                    saec_total++;
                    saec_bool[i] = true;
                    saec_kwcount++;
                    if (saec_pre == i) saec_tomake = true;
                }
            }

            if (saec_toid) clearTimeout(saec_toid);
            if (saec_self.saec_timeOut > 0) saec_toid = setTimeout(function(){saec_mouse_on_list = 0;saec_removedisp();},saec_self.saec_timeOut);
            saec_generate();
        }
        return this;
    }


    /* Event Functions */

    // Add an event to the obj given
    // event_name refers to the event trigger, without the "on", like click or mouseover
    // func_name refers to the function callback when event is triggered
    function addEvent(obj,event_name,func_name){
        if (obj.attachEvent){
            obj.attachEvent("on"+event_name, func_name);
        }else if(obj.addEventListener){
            obj.addEventListener(event_name,func_name,true);
        }else{
            obj["on"+event_name] = func_name;
        }
    }

    // Removes an event from the object
    function removeEvent(obj,event_name,func_name){
        if (obj.detachEvent){
            obj.detachEvent("on"+event_name,func_name);
        }else if(obj.removeEventListener){
            obj.removeEventListener(event_name,func_name,true);
        }else{
            obj["on"+event_name] = null;
        }
    }

    // Stop an event from bubbling up the event DOM
    function stopEvent(evt){
        evt || window.event;
        if (evt.stopPropagation){
            evt.stopPropagation();
            evt.preventDefault();
        }else if(typeof evt.cancelBubble != "undefined"){
            evt.cancelBubble = true;
            evt.returnValue = false;
        }
        return false;
    }

    // Get the obj that starts the event
    function getElement(evt){
        if (window.event){
            return window.event.srcElement;
        }else{
            return evt.currentTarget;
        }
    }
    // Get the obj that triggers off the event
    function getTargetElement(evt){
        if (window.event){
            return window.event.srcElement;
        }else{
            return evt.target;
        }
    }
    // For IE only, stops the obj from being selected
    function stopSelect(obj){
        if (typeof obj.onselectstart != 'undefined'){
            addEvent(obj,"selectstart",function(){ return false;});
        }
    }

    /*    Caret Functions     */

    // Get the end position of the caret in the object. Note that the obj needs to be in focus first
    function getCaretEnd(obj){
        if(typeof obj.selectionEnd != "undefined"){
            return obj.selectionEnd;
        }else if(document.selection&&document.selection.createRange){
            var M=document.selection.createRange();
            try{
                var Lp = M.duplicate();
                Lp.moveToElementText(obj);
            }catch(e){
                var Lp=obj.createTextRange();
            }
            Lp.setEndPoint("EndToEnd",M);
            var rb=Lp.text.length;
            if(rb>obj.value.length){
                return -1;
            }
            return rb;
        }
    }
    // Get the start position of the caret in the object
    function getCaretStart(obj){
        if(typeof obj.selectionStart != "undefined"){
            return obj.selectionStart;
        }else if(document.selection&&document.selection.createRange){
            var M=document.selection.createRange();
            try{
                var Lp = M.duplicate();
                Lp.moveToElementText(obj);
            }catch(e){
                var Lp=obj.createTextRange();
            }
            Lp.setEndPoint("EndToStart",M);
            var rb=Lp.text.length;
            if(rb>obj.value.length){
                return -1;
            }
            return rb;
        }
    }
    // sets the caret position to l in the object
    function setCaret(obj,l){
        obj.focus();
        if (obj.setSelectionRange){
            obj.setSelectionRange(l,l);
        }else if(obj.createTextRange){
            m = obj.createTextRange();
            m.moveStart('character',l);
            m.collapse();
            m.select();
        }
    }
    // sets the caret selection from s to e in the object
    function setSelection(obj,s,e){
        obj.focus();
        if (obj.setSelectionRange){
            obj.setSelectionRange(s,e);
        }else if(obj.createTextRange){
            m = obj.createTextRange();
            m.moveStart('character',s);
            m.moveEnd('character',e);
            m.select();
        }
    }

    /*    Escape function   */
    String.prototype.addslashes = function(){
        return this.replace(/(["\\\.\|\[\]\^\*\+\?\$\(\)])/g, '\\$1');
    }
    String.prototype.trim = function () {
        return this.replace(/^\s*(\S*(\s+\S+)*)\s*$/, "$1");
    };
    /* --- Escape --- */

    /* Offset position from top of the screen */
    function curTop(obj){
        toreturn = 0;
        while(obj){
            toreturn += obj.offsetTop;
            obj = obj.offsetParent;
        }
        return toreturn;
    }
    function curLeft(obj){
        toreturn = 0;
        while(obj){
            toreturn += obj.offsetLeft;
            obj = obj.offsetParent;
        }
        return toreturn;
    }
    /* ------ End of Offset function ------- */

    /* Types Function */

    // is a given input a number?
    function isNumber(a) {
        return typeof a == 'number' && isFinite(a);
    }

    /* Object Functions */

    function replaceHTML(obj,text){
        while(el = obj.childNodes[0]){
            obj.removeChild(el);
        };
        obj.appendChild(document.createTextNode(text));
    }

    //****************************************************************************