(($) ->
  $.fn.uploader = (id, type)->
    $('#fileupload').fileupload
      dataType: 'html'
      formData: [
        {
          name: 'relation_id'
          value: id
        }
        {
          name: 'relation_type'
          value: type
        }
      ]
      done: (e, data)->
        $('.progress').hide()
        $('.video-thumbs').html data.result
      progressall: (e, data)->
          progress = parseInt(data.loaded / data.total * 100, 10)
          $('.progress').show()
          $('.progress .bar').css(
              'width': progress + '%'
          )
)(jQuery)
