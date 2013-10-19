$(document).ready(
	function() {
		var curItem = $('#currently_active_item');
		var toCheck = curItem.parent().parent().parent();

		if (toCheck.children('.dropdown-toggle')) {
	 		toCheck.children('.dropdown-toggle').addClass('active');
			toCheck.children('.dropdown-toggle').attr('id', 'currently_active_item_father');
		}
	}
)
