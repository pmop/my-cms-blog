import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notification"
export default class extends Controller {
  static targets = [ "notice" ]
  connect() {
  }

  close() {
    this.noticeTarget.remove();
  }
}
