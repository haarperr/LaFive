
$(document).ready(function(){

 window.addEventListener( 'message', function( event ) {
        var item = event.data;
        if ( item.showPlayerMenu == true ) {
            $('#nome').text(item.nome1);
            $('#nome2').text(item.nome2);
            $('#nome3').text(item.nomeh);
            $('#data').text(item.datadh);
            $('#altura').text(item.altura);
            $('#sexo').text(item.sexo);
            $('#nid').text(item.nidcard);
            $('#nidt').text(item.nidcard);

            if (item.mota == "sim") {
                $('#motat').text("✔️");
            } else {
                $('#motat').text("❌");
            }

            if (item.carro == "sim") {
                $('#carrot').text("✔️");
            } else {
                $('#carrot').text("❌");
            }

            if (item.camiao == "sim") {
                $('#camiaot').text("✔️");
            } else {
                $('#camiaot').text("❌");
            }


            if (item.armas == "sim") {
                $('#card2').css('display','block');
            } else {
                $('#card2').css('display','none');
            }

            $('body').css('display','block');
        } else if ( item.showPlayerMenu == false ) { // Hide the menu
            
            $('body').css('display','none');
            location.reload();
        }
 } );

        $("#card1").click(function(){
            $.post('http://kuana_carteira/slide', JSON.stringify({}));2
        });

        $("#card2").click(function(){
            $.post('http://kuana_carteira/slidea', JSON.stringify({}));2
        });

        $("#card3").click(function(){
            $.post('http://kuana_carteira/slidea', JSON.stringify({}));2
        });
	
        $(document).keyup(function(e) {
            if ( e.keyCode == 8 ) {
             $.post('http://kuana_carteira/closeButton', JSON.stringify({}));2
           }
        });

})
