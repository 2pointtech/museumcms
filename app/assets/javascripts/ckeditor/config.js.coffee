CKEDITOR.editorConfig = (config) ->
  config.toolbar = 'Basic'
  config.toolbar_Basic =
    [
        ['Bold', 'Italic', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink', '-', 'Image', 'Table']
    ]
  config.filebrowserImageUploadUrl = '/media/upload'
  true
