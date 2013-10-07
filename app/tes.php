<?php

// Log in:
$snapchat = new Snapchat('bbtest', '278lban');

// Get your feed:
$snaps = $snapchat->getSnaps();

// Download a specific snap:
$data = $snapchat->getMedia('122FAST2FURIOUS334r');
file_put_contents('/home/dan/snap.jpg', $data);

// Mark the snap as viewed:
$snapchat->markSnapViewed('122FAST2FURIOUS334r');

// Screenshot!
$snapchat->markSnapShot('122FAST2FURIOUS334r');

// Upload a snap and send it to me for 8 seconds:
$id = $snapchat->upload(
    Snapchat::MEDIA_IMAGE,
    file_get_contents('/home/dan/whatever.jpg')
);
$snapchat->send($id, array('stelljes'), 8);

// Destroy the evidence:
$snapchat->clearFeed();

// Get a list of your friends:
$friends = $snapchat->getFriends();

// Add some people as friends:
$snapchat->addFriends(array('bill', 'bob', 'bart'));

?>