// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "core-js/stable";
import "regenerator-runtime/runtime";
import "@hotwired/turbo-rails";

import { createApp } from "vue";
import App from "./app.vue";

document.addEventListener("DOMContentLoaded", () => {
  createApp(App).mount("#app");
});
