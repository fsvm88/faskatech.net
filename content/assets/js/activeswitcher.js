$(document).ready(
	function() {
		var curItem = $('.active');
		var toCheck = curItem.parent().parent().parent();

		if (toCheck.children('.dropdown-toggle')) {
	 		toCheck.children('.dropdown-toggle').addClass('active');
		}
	}
)
