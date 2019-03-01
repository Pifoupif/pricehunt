import "bootstrap";
import { button_sort } from '../components/button_price';
import { initSelect2 } from '../components/init_select2';
import 'select2/dist/css/select2.css';


// [...]

if (document.querySelector(".sort-price")) {
  button_sort();
}

initSelect2();
