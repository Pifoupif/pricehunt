import "bootstrap";
import { button_sort } from '../components/button_price';
import { initSelect2 } from '../components/init_select2';
import { initSelect2Nav } from '../components/init_select2_navbar';
import 'select2/dist/css/select2.css';
import { initChart } from '../components/chart.js';

// [...]

if (document.querySelector(".sort-price")) {
  button_sort();
}

if (document.querySelector("#select2-navbar")) {
  initSelect2Nav();
}

if (document.querySelector(".searchbar-position")) {
  initSelect2();
}

initChart();

