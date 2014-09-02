$(document).ready(
	function() {
		var curItem = $('.active');
		var toCheck = curItem.parents('li.dropdown');

		if (toCheck.children('.dropdown-toggle')) {
	 		toCheck.children('.dropdown-toggle').addClass('active');
		}
	}
)
