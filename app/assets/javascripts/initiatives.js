$(document).ready(function () {
    $('.category_select').select2({
        placeholder: 'Натисніть сюди щоб вибрати категорії'
    });
    $('form').submit(function () {
        $('.initiative-button-submit').hide();
        $('.devise-registration-edit-button-submit').hide();
        $('.sk-cube-grid').show();
    });
    $('.initiative-button-support').click(function () {
        $('.block-pay').slideDown("slow");
        $('#button-support').css('background-color', '#4D4252')
    });
    /* show paypal block */
    $('input[type=radio][name=payed]').change(function () {
        if (this.value == 'paypal') {
            $('.stripe').hide();
            $('.paypal').show();
        }
        else if (this.value == 'stripe') {
            $('.stripe').show();
            $('.paypal').hide();
        }
    });
});