// Find the video element by its ID
var videoElement = document.querySelector("#Basics_of_Virtual_Memory_12_19_ video");

// Add an event listener to the document to listen for keydown events
document.addEventListener("keydown", function(event) {
    // Check if the pressed key is the spacebar
    if (event.code === "Space") {
        // Prevent the default action to avoid scrolling the page
        event.preventDefault();
        // Toggle the play and pause state of the video
        if (videoElement.paused) {
            videoElement.play();
        } else {
            videoElement.pause();
        }
    }
});
