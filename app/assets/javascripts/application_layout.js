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
    $('#search').on('input', function () {
        var search = $('#search').val();
        $("#form-search-button").submit();
        $.ajax({
            url: 'search?search=' + search,
            method: 'get',
            dataType: 'json'
        });
    });
});
