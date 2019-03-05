import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  const search = document.querySelectorAll('.js-data-example-ajax');
  $('.js-data-example-ajax').select2({
    minimumInputLength: 2,
    ajax: {
      url: 'https://search.ledenicheur.fr/classic?class=Search_Supersearch&method=search&market=fr&skip_login=1&modes=product,raw_sorted,raw&limit=12',
      dataType: 'json',
      data: function(params) {
      var query = {
          q: params.term,
        }
        return query
      },
      processResults: function (data) {
      // Tranforms the top-level key of the response object from 'items' to 'results'
      //const products = data.message.product.items.map(product => product.id)
      //console.log(products)
        return {
          results: data.message.product.items
        };
      },
    },
    placeholder: 'Search for a product',
    escapeMarkup: function (markup) { return markup; },
    minimumInputLength: 2,
    templateResult: formatProduct,
    templateSelection: formatProductSelection,
    dropdownParent: $('.searchbar-position')
  });
  $('.js-data-example-ajax').on('select2:select', function () {
    $("#btn-successor").trigger('click');
  });
};

function formatProduct (product) {
  if (product.loading) {
    return product.name;
  }

  var markup =
  "<div class='select2-result-repository'>" +
    "<div class='select2-result-photo'><img src='" + 'https://cdn.pji.nu/product/standard/140/' + product.id + '.jpg' + "' /></div>" +
    "<div class='select2-name-price'>" +
      "<div class='select2-result-name'>" + product.name + "</div>" +
      "<div class='select2-result-price'>" + product.price.regular + "</div>"
    "</div>"
  "</div>";

  return markup;
}

function formatProductSelection (product) {
  return product.name;
}

export { initSelect2 };

// espace markup et template results
