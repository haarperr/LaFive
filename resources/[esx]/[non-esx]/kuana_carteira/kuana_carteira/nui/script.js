
var departments = document.getElementsByClassName('department');
var cards = document.getElementsByClassName('card');
var bottomValues = ['40px', '83px', '126px'];

var oldBottom = 0;
var newBottom = 0;

for (var i = 0; i < cards.length; i++) {
  cards[i].addEventListener('click', function() {
    animation(this.id);
  })
}

function animation(id) {

  for (var i = 0; i < cards.length; i++) {
    var card = document.getElementById(cards[i].id);
    card.style.bottom = bottomValues[i];
    if (card.id != id) {
      card.name = '';
    }
  }

  var selected = document.getElementById(id);
  selected.style.transition = '0.3s';

  if (selected.name != 'moved') {

    oldBottom = parseInt(selected.style.bottom, 10);
    newBottom = '350px';
    selected.style.bottom = newBottom;
    selected.name = 'moved';

  } else if (selected.name == 'moved') {

    selected.style.bottom = oldBottom + 'px';
    selected.name = '';

  }
}