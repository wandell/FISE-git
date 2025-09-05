document.addEventListener("DOMContentLoaded", function () {
  // Select all <details> elements in the sidebar (i.e., collapsible parts)
  const detailsList = document.querySelectorAll("nav.sidebar nav.details");

  detailsList.forEach((details, idx) => {
    const summary = details.querySelector("summary");
    const key = "sidebar-part-" + idx;

    // Restore previous state
    const saved = localStorage.getItem(key);
    if (saved === "closed") {
      details.removeAttribute("open");
    } else if (saved === "open") {
      details.setAttribute("open", "");
    }

    // Listen for changes
    summary?.addEventListener("click", () => {
      const isOpen = details.hasAttribute("open");
      localStorage.setItem(key, isOpen ? "open" : "closed");
    });
  });
});

// This code manages the persistence of sidebar states across page loads
// It uses localStorage to save the state of each part's visibility
// When a part is collapsed, it saves "collapsed" to localStorage
// When expanded, it saves "expanded"
// On page load, it checks localStorage and applies the saved state
// This allows users to maintain their sidebar preferences across sessions
// Note: This code assumes the HTML structure has elements with class "book-part" and "book-part-title"
// Ensure that the HTML structure matches this expectation for the code to work correctly
// The code is designed to be included in a script tag at the end of the HTML body
// or in a separate JavaScript file linked at the end of the body