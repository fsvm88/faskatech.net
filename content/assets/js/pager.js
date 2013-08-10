$(document).ready(function() {
	var buttons = new Array('previous', 'next');
	alert('prova');
	console.log(buttons);
	$.each(buttons, function(index, value) {
		console.log(index);
		console.log(value);
	});
});
