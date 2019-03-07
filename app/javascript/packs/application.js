import "bootstrap";
import { button_sort } from '../components/button_price';
import { initSelect2 } from '../components/init_select2';
import 'select2/dist/css/select2.css';
import { initChart } from '../components/chart.js';
import { submitOnChange } from '../components/auto_send';
import { initSweetalert } from '../plugins/init_sweetalert';

initSweetalert('#sweet-alert', {
  title: "Good job!",
  text: "Your alert is created",
  icon: "success",
  buttons: false,
});

// [...]

if (document.querySelector(".sort-price")) {
  button_sort();
}

if (document.querySelector("#photo-form")) {
  submitOnChange();
}

initChart();
initSelect2();
