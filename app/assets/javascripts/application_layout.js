$(document).ready(function () {
    $(".select-sort").change(function () {
        var category_id = $('#category_sort').val();
        $("#button-sort").submit();
        $.ajax({
            url: 'search/sort?category[id]=' + category_id,
            method: 'get',
            dataType: 'json'
        });
    });
    $("#form-search-button").submit(function () {
        $.ajax({
            url: '/',
            method: 'post',
            dataType: 'json'
        });
    });
});
