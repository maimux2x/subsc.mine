import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["modal"];
  connect() {}

  open() {
    this.modalTargets.classList.remove("hidden");
  }

  close() {
    this.modalTargets.classList.add("hidden");
  }
}
