function closeFunction0() {
        document.getElementById("info_close0").addEventListener("click", function() {
            document.getElementById("info0").style.display = "none";
            document.getElementById("info_open0").style.display = "block";
            $("#wrap0")[0].parentElement.style.zIndex = "-1";
            $("#wrap0").css("width", "0");
        });
};

function openFunction0() {
        document.getElementById("info_open0").addEventListener("click", function() {
            document.getElementById("info0").style.display = "block";
            document.getElementById("info_open0").style.display = "none";
            $("#wrap0")[0].parentElement.style.zIndex = "0";
            $("#wrap0").css("width", "");
        });
}

function closeFunction1() {
    document.getElementById("info_close1").addEventListener("click", function() {
        document.getElementById("info1").style.display = "none";
        document.getElementById("info_open1").style.display = "block";
        $("#wrap1")[0].parentElement.style.zIndex = "-1";
        $("#wrap1").css("width", "0");
    });
};

function openFunction1() {
    document.getElementById("info_open1").addEventListener("click", function() {
        document.getElementById("info1").style.display = "block";
        document.getElementById("info_open1").style.display = "none";
        $("#wrap1")[0].parentElement.style.zIndex = "0";
        $("#wrap1").css("width", "");
    });
}

function closeFunction2() {
    document.getElementById("info_close2").addEventListener("click", function() {
        document.getElementById("info2").style.display = "none";
        document.getElementById("info_open2").style.display = "block";
        $("#wrap2")[0].parentElement.style.zIndex = "-1";
        $("#wrap2").css("width", "0");
    });
};

function openFunction2() {
    document.getElementById("info_open2").addEventListener("click", function() {
        document.getElementById("info2").style.display = "block";
        document.getElementById("info_open2").style.display = "none";
        $("#wrap2")[0].parentElement.style.zIndex = "0";
        $("#wrap2").css("width", "");
    });
}

function closeFunction3() {
    document.getElementById("info_close3").addEventListener("click", function() {
        document.getElementById("info3").style.display = "none";
        document.getElementById("info_open3").style.display = "block";
        $("#wrap3")[0].parentElement.style.zIndex = "-1";
        $("#wrap3").css("width", "0");
    });
};

function openFunction3() {
    document.getElementById("info_open3").addEventListener("click", function() {
        document.getElementById("info3").style.display = "block";
        document.getElementById("info_open3").style.display = "none";
        $("#wrap3")[0].parentElement.style.zIndex = "0";
        $("#wrap3").css("width", "");
    });
}