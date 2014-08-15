$(document).ready(function() {
	// Assign progressive ID to each post
	numberPosts();
	// Hide all posts after the third
	$('.post').each(function() {
		if ($(this).attr('id') > 2) {
			$(this).hide();
		}
	});
	// Add listeners to buttons
	$('.nextPagerButton').click(goForth);
	$('.previousPagerButton').click(goBack);
	// Deactivate "newer posts" button
	$('.nextPagerButton').addClass('disabled');
});

function numberPosts() {
	var count = 0;
	$('.post').each(function() {
		$(this).attr('id', count);
		count++;
	});
}

function determineFirstVisible(posts) {
	var min = Number.MAX_VALUE;
	posts.each(function() {
		var item = $(this);
		if (item.css('display') != 'none') {
			var itemId = parseInt(item.attr('id'));
			if (itemId<min) { min = itemId; }
		}
	});
	return min;
}

function activateButton(button) { if (!isActivatedButton(button)) { $(button).removeClass('disabled'); } }
function deactivateButton(button) { if (isActivatedButton(button)) { $(button).addClass('disabled'); } }
function isActivatedButton(button) { return !$(button).hasClass('disabled'); }

function changeButtonState(btnclass, state) {
	var buttons = $(btnclass);
	buttons.each(function() {
		var item = $(this);
		switch (state) {
			case 'on':
				activateButton(item);
				break;
			case 'off':
				deactivateButton(item);
				break;
			default:
				break;
		}
	});
}

function goBack() {
	if (!isActivatedButton('.previousPagerButton')) { return; }
	var posts = $('.post');
	var first = determineFirstVisible(posts);
	var count = posts.length;
	var newfirst = sum(first, 3);
	// If first+3 is more than the count of posts we're already on the last page
	if (sum(newfirst,1)>count) { newfirst = first; }
	setPostsVisibility(posts, newfirst);
	toggleButtons(count, newfirst);
}

function goForth() {
	if (!isActivatedButton('.nextPagerButton')) { return; }
	var posts = $('.post');
	var first = determineFirstVisible(posts);
	var count = posts.length;
	var newfirst = sum(first,-3);
	// If first-3 is less than 0
	if (sum(newfirst,1)<=0) { newfirst = 0; }
	setPostsVisibility(posts, newfirst);
	toggleButtons(count, newfirst);
}

function toggleButtons(count, first) {
	var last = getShifted(first);
	if (first>0) { changeButtonState('.nextPagerButton', 'on'); }
	else { changeButtonState('.nextPagerButton', 'off'); }
	if ( (last>=(count-1)) ||
		((last-first)<2)) { changeButtonState('.previousPagerButton', 'off'); }
	else { changeButtonState('.previousPagerButton', 'on'); }
}

function setPostsVisibility(posts, first) {
	var last = getShifted(first);
	posts.each(function() {
		var item = $(this);
		var itemId = item.attr('id');
		if (itemId < first) { item.hide(); }
		else if (itemId > last) { item.hide(); }
		else { item.show(); }
	});
}

function getShifted(first) { return parseInt(sum(first, 2)); }
function sum(a, b) { return (parseInt(a) + parseInt(b)); }