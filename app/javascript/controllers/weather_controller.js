import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["temp", "icon"];
  static values = {
    api: String,
  };
  async connect() {
    try {
      const response = await fetch(this.apiValue, {
        method: "GET",
        headers: new Headers({
          "Content-Type": "application/json",
        }),
      });
      const json = await response.json();
      const temp = json.current.temperature_2m;
      this.tempTarget.textContent = `${temp}℃`;
      if (temp > 20) {
        this.iconTarget.textContent = "☀️";
      } else if (temp > 16) {
        this.iconTarget.textContent = "🌤";
      } else if (temp > 2) {
        this.iconTarget.textContent = "☁️";
      } else {
        this.iconTarget.textContent = "🌨";
      }
    } catch (error) {
      console.error(error);
      this.tempTarget.textContent = `--℃`;
    }
  }
}
