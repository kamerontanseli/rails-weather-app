import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["select", "latitude", "longitude"];
  connect() {
    this.updateLatLong()
  }
  updateLatLong() {
    const city = this.selectTarget.value;
    const option = this.selectTarget.querySelector(`option[value="${city}"]`);
    const data = {
      latitude: Number(option.getAttribute("data-latitude")),
      longitude: Number(option.getAttribute("data-longitude")),
    };
    this.latitudeTarget.value = data.latitude
    this.longitudeTarget.value = data.longitude
  }
}
