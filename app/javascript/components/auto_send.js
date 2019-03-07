function submitOnChange() {
    document.querySelector('input[id="photo"]').onchange=submitForm;
};

function submitForm(event) {
  const photoUploader = document.querySelector('.upload-photo');
  photoUploader.innerHTML = '<i class="fas fa-spinner"></i>';
  document.forms["photo-form"].submit()
};

export { submitOnChange };


// window.onload = function () {
//   var auto = setTimeout(function(){ autoRefresh(); }, 100);
//   function submitform(){
//     document.forms["photo-form"].submit();
//   };
//   function autoRefresh(){
//     clearTimeout(auto);
//     auto = setTimeout(function(){ submitform(); autoRefresh(); }, 10000);
//   };
// };

