import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  const search = document.querySelectorAll('.js-data-example-ajax');
  //console.log(search);
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
        results: $.map(data.message.product.items, function(item) {
          return {
            text: item.name,
            id: item.id
          }
        })
        }
      }
    }
  }); // (~ document.querySelectorAll)
};

export { initSelect2 };
