import {
  Controller
} from "@hotwired/stimulus";
import {
  Chess
} from "chess.js";
import Chessboard from "chessboardjs";

// Connects to data-controller="chess"
export default class extends Controller {
  connect() { }
}

var data = document.getElementById("board").dataset;
var pgn = data.pgn;
var type = data.type;
var game, gameHistory, currentPly;
var player_color = data.player_color;
var whiteSquareGrey = "#a9a9a9";
var blackSquareGrey = "#696969";

function writeGameText(g) {

  //remove the header to get the moves
  var h = g.header();
  var gameHeaderText = '<h4>' + h.White + ' - ' + h.Black + '</h4>';
  gameHeaderText += '<h5>' + h.Event + ', ' + h.Site + ' ' + h.EventDate + '</h5>';
  var pgn = g.pgn();
  var gameMoves = pgn.replace(/\[(.*?)\]/gm, '').replace(h.Result, '').trim();

  //format the moves so each one is individually identified, so it can be highlighted
  var moveArray = gameMoves.split(/([0-9]+\.\s)/).filter(function(n) {
    return n;
  });
  for (var i = 0, l = moveArray.length; i < l; ++i) {
    var s = $.trim(moveArray[i]);
    if (!/^[0-9]+\.$/.test(s)) { //move numbers
      var m = s.split(/\s+/);
      for (var j = 0, ll = m.length; j < ll; ++j) {
        m[j] = '<span class="gameMove' + (i + j - 1) + '"><a id="myLink" href="#" onclick="goToMove(' + (i + j - 1) + ');return false;">' + m[j] + '</a></span>';
      }
      var s = m.join(' ');
    }
    moveArray[i] = s;
  }

  var gameData = gameHeaderText + '<div class="gameMoves">' + moveArray.join(' ');
  if (h.Result)
    gameData += ' <span class="gameResult">' + h.Result + '</span></div>';
  $("#game-data").html(gameData);

}

//buttons
$('#btnStart').on('click', function() {
  goToStart();
});
$('#btnPrevious').on('click', function() {
  if (currentPly >= 0) {
    game.undo();
    currentPly--;
    board.position(game.fen());
  }
});
$('#btnNext').on('click', function() {
  if (currentPly < gameHistory.length - 1) {
    nextMove()
  }
});
$('#btnEnd').on('click', function() {
  while (currentPly < gameHistory.length - 1) {
    currentPly++;
    game.move(gameHistory[currentPly].san);
  }
  board.position(game.fen());
});

function goToStart() {
  game.reset();
  currentPly = -1;
  board.position(game.fen());
}

function nextMove() {
  var plyIncrement = type == 'study' ? 1 : 2;
  currentPly += plyIncrement;
  game.move(gameHistory[currentPly].san);
  board.position(game.fen());
}
//key bindings
$(document).ready(function() {

  $(document).keydown(function(e) {
    if (e.keyCode == 39) { //right arrow
      if (e.ctrlKey) {
        $('#btnEnd').click();
      } else {
        $('#btnNext').click();
      }
      return false;
    } else if (e.keyCode == 37) { //left arrow
      if (e.ctrlKey) {
        $('#btnStart').click();
      } else {
        $('#btnPrevious').click();
      }
      return false;
    }
  });
});

//used for clickable moves in gametext
//not used for buttons for efficiency
function goToMove(ply) {
  if (ply > gameHistory.length - 1) ply = gameHistory.length - 1;
  game.reset();
  for (var i = 0; i <= ply; i++) {
    game.move(gameHistory[i].san);
  }
  currentPly = i - 1;
  board.position(game.fen());
}

var onChange = function onChange() { //fires when the board position changes
  //highlight the current move
  $("[class^='gameMove']").removeClass('highlight');
  $('.gameMove' + currentPly).addClass('highlight');
}

function startDrill() {
  do {
    if (player_color === game.turn()) {

    }
  } while (!gameOver)
}

function removeGreySquares() {
  $("#board .square-55d63").css("background", "");
}

function greySquare(square) {
  var $square = $("#board .square-" + square);

  var background = whiteSquareGrey;
  if ($square.hasClass("black-3c85d")) {
    background = blackSquareGrey;
  }

  $square.css("background", background);
}

function onDragStart(source, piece) {
  // do not pick up pieces if the game is over
  if (gameOver()) {
    return false;
  }

  // or if it's not that side's turn
  if (
    (game.turn() === "w" && piece.search(/^b/) !== -1) ||
    (game.turn() === "b" && piece.search(/^w/) !== -1)
  ) {
    return false;
  }
}

function gameOver() {
  if (game.isCheckmate() || game.isDraw()) {
    return true;
  }

  return false;
}

function onDrop(source, target) {
  removeGreySquares();

  // see if the move is legal
  var move = game.move({
    from: source,
    to: target,
    // promotion: "q", // NOTE: always promote to a queen for example simplicity
  });

  // illegal move
  if (move === null) return "snapback";

  isCorrectMove(move) ? window.setTimeout(nextMove(), 250) : game.undo();
}

function isCorrectMove(move) {
  return move.san === gameHistory[currentPly + 1].san;
}

function onMouseoverSquare(square, piece) {
  // get list of possible moves for this square
  var moves = game.moves({
    square: square,
    verbose: true,
  });

  // exit if there are no moves available for this square
  if (moves.length === 0) return;

  // highlight the square they moused over
  greySquare(square);

  // highlight the possible squares for this piece
  for (var i = 0; i < moves.length; i++) {
    greySquare(moves[i].to);
  }
}

function onMouseoutSquare(square, piece) {
  removeGreySquares();
}

function onSnapEnd() {
  board.position(game.fen());
}

function loadGame() {
  game = new Chess();
  game.loadPgn(pgn);
  writeGameText(game);
  gameHistory = game.history({
    verbose: true
  });
}

var config = {
  position: "start",
  pieceTheme: "/assets/pieces/{piece}.png",
};

const drill_config = {
  draggable: true,
  onDragStart: onDragStart,
  onDrop: onDrop,
  onMouseoutSquare: onMouseoutSquare,
  onMouseoverSquare: onMouseoverSquare,
  onSnapEnd: onSnapEnd,
}

if (type === 'drill') config = Object.assign(config, drill_config);

const board = Chessboard("board", config);
loadGame();
if (type == 'drill') startDrill();
goToStart();
