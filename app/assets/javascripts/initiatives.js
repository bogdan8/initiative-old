$(document).ready(function () {
    $('.category_select').select2({
        placeholder: 'Натисніть сюди щоб вибрати категорії'
    });
    $('form').submit(function () {
        $('.initiative-button-submit').css('display', 'none');
        $('.devise-registration-edit-button-submit').css('display', 'none');
        $('.sk-cube-grid').css('display', 'block');
    });
    $('.initiative-button-support').click(function(){
        $('.block-pay').slideDown( "slow");
        $('#button-support').css('background-color', '#4D4252')
    });
});