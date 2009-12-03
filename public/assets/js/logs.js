function getsitename(url, IP, id) {
    xmlhttpPost(url, IP, id);
}

function xmlhttpPost(strURL, IP, id) {
    var xmlHttpReq = false;
    var self = this;
    // Mozilla/Safari
    if (window.XMLHttpRequest) {
        self.xmlHttpReq = new XMLHttpRequest();
    }
    // IE
    else if (window.ActiveXObject) {
        self.xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
    }
    self.xmlHttpReq.open('GET', strURL, true);
    self.xmlHttpReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    self.xmlHttpReq.onreadystatechange = function() {
        if (self.xmlHttpReq.readyState == 4) {
            updatepage(self.xmlHttpReq.responseText, IP, id);
        }
    }
    self.xmlHttpReq.send();
}

function updatepage(str, IP, id){
    document.getElementById(id+IP).innerHTML = str+" ("+IP+")";
}

