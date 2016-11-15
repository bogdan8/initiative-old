jQuery ->
  $('.select-sort').change ->
    category_id = $('#category_sort').val()
    $("#button-sort").submit()
    $.ajax
      url: 'search/sort?category[id]=' + category_id
      method: 'get'
      dataType: 'json'

  $('#search').on 'input', ->
    search = $('#search').val()
    $("#form-search-button").submit()
    $.ajax
      url: 'search?search=' + search
      method: 'get'
      dataType: 'json'