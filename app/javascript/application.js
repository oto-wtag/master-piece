// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

document.addEventListener("turbo:submit-start", (event) => {
  const form = event.target;

  if (form.hasAttribute("data-confirm")) {
    const message = form.getAttribute("data-confirm");

    if (!window.confirm(message)) {
      event.preventDefault();
    }
  }
});
