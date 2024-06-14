import { Controller } from "@hotwired/stimulus";

function debounce(func, wait, immediate) {
  var timeout;
  return function () {
    var context = this,
      args = arguments;
    clearTimeout(timeout);
    timeout = setTimeout(function () {
      timeout = null;
      if (!immediate) func.apply(context, args);
    }, wait);
    if (immediate && !timeout) func.apply(context, args);
  };
}

const searchForCities = debounce(
  async (url, success, failure) => {
    try {
      const response = await fetch(url, {
        method: "GET",
        headers: new Headers({
          "Content-Type": "application/json",
        }),
      });
      success(await response.json());
    } catch (error) {
      console.error(error);
      failure(error);
    }
  },
  1500,
  false
);

export default class extends Controller {
  static targets = ["latitude", "search", "longitude", "city", "list"];
  static values = {
    api: String,
  };
  async connect() {
    try {
    } catch (error) {
      console.error(error);
    }
  }
  search(event) {
    const query = event.currentTarget.value;
    searchForCities(
      `${this.apiValue}?search=${query}`,
      (cities) => {
        this.listTarget.innerHTML = cities
          .sort((a, b) => b.pop - a.pop)
          .map(
            (c) => `
        <li data-lat="${c.lat}" data-lon="${c.lon}" data-city="${c.name}" data-action="click->new-city#selectedCity"><span>${c.name}, ${c.admin1}</span></li>
      `
          )
          .join("")
          .trim();
      },
      () => {}
    );
  }
  selectedCity(event) {
    const target = event.currentTarget;
    this.searchTarget.value = target.querySelector('span').textContent
    this.cityTarget.value = target.getAttribute('data-city')
    this.listTarget.innerHTML = ''
    const data = {
      latitude: Number(target.getAttribute("data-lat")),
      longitude: Number(target.getAttribute("data-lon")),
    };
    this.latitudeTarget.value = data.latitude;
    this.longitudeTarget.value = data.longitude;
  }
}
