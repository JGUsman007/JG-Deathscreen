let vr = 0

async function SendData(data,cb) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState == XMLHttpRequest.DONE) {
            if (cb) {
                cb(xhr.responseText)
            }
        }
    }
    xhr.open("POST", 'https://JG-Deathscreen/respawnbuttonpressed', true)
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.send(JSON.stringify(data))
}



window.addEventListener('message', (event) => {
     let data = event.data;

     if (data.type == 'UI'){
        if (data.value == true) {
            $("body").show();
            $(".bleeding").show()
            $(".bleedingtext").html("BLEEDING");
            $("#emsbutton").html("Call ems");
            $("#emsbutton").fadeIn();
        }else{
            $("body").hide();
        }
    }

    if (data.type == 'timer') {
        $(".remainingtime").html(data.value);
        if (data.bleedout == true){
            $(".bleedingtext").html("YOUDEAD");
            $("#emsbutton").html("RESPAWN");
            $("#emsbutton").fadeIn();
        }
    }

    if (data.type == 'respawnselector'){
        if (data.value == true){
            $(".bleeding").hide()
            $(".respawnselector").fadeIn()
        }
    }

    if (data.type == 'revived'){
        if (data.value == true){
            $("body").hide();
            $(".respawnselector").hide();
        }
     }

///////////////////////////////////////////////////////
if (data.respawn){
    if (vr == 0){
    for (const i in data.respawn){
        let info = data.respawn[i]
        let ui = `
        <button id="first" style ="background-image: url(${info.img})" onclick="respawn('${info.name}')" >
            ${info.name}
        </button>`
        document.getElementById('spawn').insertAdjacentHTML("beforeend", ui)
    }
}
    vr = 1
    $(".respawnselector").fadeIn()
}
 ///////////////////////////////////////////////////////

});


function respawn(name) {
    SendData({msg : 'respawn',name : name})
}

document.addEventListener('DOMContentLoaded', () => {

    document.getElementById("emsbutton").addEventListener('click', () => {
        $.post(`http://${GetParentResourceName()}/emsbuttonpressed`),{}
        $("#emsbutton").hide();
    })

})

