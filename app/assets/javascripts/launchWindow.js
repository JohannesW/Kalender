function launchWindow(id) {


    //Get the screen height and width
    var maskHeight = $(document).height();
    var maskWidth = $(window).width();

    //Set height and width to mask to fill up the whole screen
    $('#mask').css({'width':maskWidth,'height':maskHeight});

    //transition effect     
    $('#mask').fadeIn(1000);    
    $('#mask').fadeTo("slow",0.8);  

    //Get the window height and width
    var winH = $(window).height();
    var winW = $(window).width();

    //Set the popup window to center
    $(id).css('top',  winH/2-$(id).height()/2);
    $(id).css('left', winW/2-$(id).width()/2);

    //transition effect
    $(id).fadeIn(2000); 
}